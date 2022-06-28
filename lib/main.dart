import 'dart:isolate';
import 'dart:ui';

// import 'package:background_geolocation_firebase/background_geolocation_firebase.dart';
import 'package:background_geolocation_firebase/background_geolocation_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawimmunity/firebase_options.dart';
import 'package:lawimmunity/helpers/logging.dart';
import 'package:lawimmunity/provider/Key_value_store_provider.dart';
import 'package:lawimmunity/screens/auth/login_signup_page.dart';
import 'package:lawimmunity/screens/dashboard/dashboard_page.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:lawimmunity/screens/faq_page/faq_provider.dart';
import 'package:lawimmunity/screens/location_page/provider/location_provider.dart';
import 'package:lawimmunity/services/service_initializer.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'provider/theme_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isNotEmpty) {
    Firebase.app();
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  final port = IsolateNameServer.lookupPortByName(backgroundMessageIsolateName);
  port?.send(message);

  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

final ReceivePort backgroundMessageport = ReceivePort();
const String backgroundMessageIsolateName = 'fcm_background_msg_isolate';

void backgroundMessagePortHandler(message) {
  final dynamic data = message.data;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);


  await initServices();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'lawimmunity_high_importance_channel', // id
      'High Importance Notifications From LawImmunity', // title
      description:
          'This channel is used for important notifications from LawImmunity.',
      // description
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
  IsolateNameServer.registerPortWithName(
    backgroundMessageport.sendPort,
    backgroundMessageIsolateName,
  );

  backgroundMessageport.listen(backgroundMessagePortHandler);

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
        ChangeNotifierProvider<LocationProvider>(
            create: (ctx) => LocationProvider()),
        ChangeNotifierProvider<FAQProvider>(
            create: (ctx) => FAQProvider()),
      ],
      child: MaterialApp(
        title: 'LawImmunity',
        // routeInformationParser: _appRouter.defaultRouteParser(),
        // routerDelegate: _appRouter.delegate(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: myThemes.buildLightTheme(),
        darkTheme: myThemes.buildDarkTheme(),
        home: const HomeRedirectPage(),
        routes: {
          '/redirect': (context) => const HomeRedirectPage(),
        },
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
    initPlatformState();
    FirebaseMessaging.instance.getToken().then((value) {
      print('token = $value');
    });

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
              channelDescription: channel.description,
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
            'Loading..',
            style: GoogleFonts.baskervville(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 5,
          ),
          const Center(child: CircularProgressIndicator())
        ],
      )),
    );

    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        mainPage = DashboardPage();
      });

      BackgroundGeolocationFirebase.configure(
          BackgroundGeolocationFirebaseConfig(
              locationsCollection:
                  'users/${FirebaseAuth.instance.currentUser!.uid}',
              geofencesCollection: 'geofences',
              updateSingleDocument: true));

      if (!mounted) return;
    } else {
      setState(() {
        mainPage = LoginSignupPage();
      });
    }
  }

  Future<void> initPlatformState() async {
    bg.BackgroundGeolocation.state.then((bg.State value) {
      Provider.of<LocationProvider>(context, listen: false).isLocationShared =
          value.enabled;

      if(value.enabled){

        bg.BackgroundGeolocation.getCurrentPosition().then((value) {

          Provider.of<LocationProvider>(context, listen: false).currentLocation = value;


        });

      }
    });
  }
}
