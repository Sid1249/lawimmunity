import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lawimmunity/screens/location_page/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt getIt = GetIt.instance;
  getIt.registerSingleton(await SharedPreferences.getInstance());
  getIt.registerSingleton(LocationService());
}
