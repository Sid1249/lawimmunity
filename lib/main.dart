import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawimmunity/firebase_options.dart';
import 'package:lawimmunity/provider/Key_value_store_provider.dart';
import 'package:lawimmunity/screens/auth/login_signup_page.dart';
import 'package:lawimmunity/screens/dashboard/dashboard_page.dart';
import 'package:lawimmunity/screens/home_redirect_page.dart';
import 'package:lawimmunity/screens/location_page/location_provider.dart';
import 'package:lawimmunity/services/service_initializer.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';


import 'provider/theme_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');

  FirebaseDatabase.instance.ref().child('teemp').push().child('testing').set("hello");

}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {

  await initServices();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'lawimmunity_high_importance_channel', // id
      'High Importance Notifications From LawImmunity', // title
      description: 'This channel is used for important notifications from LawImmunity.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final myThemes = MyThemes();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<KeyValueStore>(create: (context) => KeyValueStoreImpl()),
        ChangeNotifierProvider<LocationProvider>(create: (ctx) => LocationProvider()),
      ],
      child: MaterialApp(
        title: 'LawImmunity',
        // routeInformationParser: _appRouter.defaultRouteParser(),
        // routerDelegate: _appRouter.delegate(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: myThemes.buildLightTheme(),
        darkTheme: myThemes.buildDarkTheme(),
        home: const HomeRedirectPage()
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}



class HomeRedirectPage extends StatefulWidget {
  const HomeRedirectPage({Key? key}) : super(key: key);

  @override
  _HomeRedirectPageState createState() {
    return _HomeRedirectPageState();
  }
}

class _HomeRedirectPageState extends State<HomeRedirectPage> {
  var mainPage;

  @override
  void initState() {
    super.initState();
    isUserAuthenticated();


    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        //Todo: navigate to correct screen
        // Navigator.pushNamed(
        //   context,
        //   '/message',
        //   arguments: MessageArguments(message, true),
        // );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription:channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');


      //Todo: navigate to correct screen

      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainPage;
  }

  void isUserAuthenticated() {


    mainPage = Scaffold(
      appBar: LawImmunityAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading..",
                style: GoogleFonts.baskervville(
                    fontSize: 22, color: Colors.black, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 5,),
              Center(child: CircularProgressIndicator())
            ],
          )),
    );


    if(FirebaseAuth.instance.currentUser != null){

      setState(() {
        mainPage = DashboardPage();
      });

    }else{

      setState(() {
        mainPage = LoginSignupPage();
      });

    }

  }

}