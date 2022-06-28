import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lawimmunity/screens/location_page/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;


Future<void> initServices() async {
  bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton(await SharedPreferences.getInstance());
  getIt.registerSingleton(LocationService());


}

void headlessTask(bg.HeadlessEvent headlessEvent) async {
  print('[BackgroundGeolocation HeadlessTask]: $headlessEvent');
  // Implement a 'case' for only those events you're interested in.
  bg.BackgroundGeolocation.startSchedule();
  switch(headlessEvent.name) {
    case bg.Event.TERMINATE:
      bg.State state = headlessEvent.event;
      print('xx - State: $state');
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      print('xx - Location: $location');
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      print('xx - Location: $location');
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      print('xx - GeofenceEvent: $geofenceEvent');
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      print('xx - GeofencesChangeEvent: $event');
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      print('xx - State: $state');
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      print('xx ActivityChangeEvent: $event');
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      print('EnabledChangeEvent: $enabled');
      break;
  }
}
