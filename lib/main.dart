import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/provider/Key_value_store_provider.dart';
import 'package:lawimmunity/screens/auth/login_signup_page.dart';
import 'package:lawimmunity/screens/home_redirect_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'provider/theme_provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // final _appRouter = AppRouter(
  //   authGuard: AuthGuard(),
  //   devModeGuard: DevModeGuard(),
  // );
  final myThemes = MyThemes();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<WooClient>(create: (_) => WooClientImpl()),
        Provider<KeyValueStore>(create: (context) => KeyValueStoreImpl()),
        // ChangeNotifierProvider<AuthenticationService>(
        //     create: (ctx) => AuthenticationServiceImpl(
        //       Provider.of<WooClient>(ctx, listen: false),
        //       Provider.of<KeyValueStore>(ctx, listen: false),
        //     )),
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
