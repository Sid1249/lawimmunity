import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:lawimmunity/helpers/toast.dart';
import 'package:lawimmunity/screens/location_page/provider/location_provider.dart';
import 'package:provider/provider.dart';

class LocationService {
  LocationProvider? locationProvider;

  startLocationService(BuildContext context) async {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    Map<String, dynamic> deviceParams = await Config.deviceParams;

    bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    bg.BackgroundGeolocation.onActivityChange(_onActivityChange);
    bg.BackgroundGeolocation.onProviderChange(_onProviderChange);
    bg.BackgroundGeolocation.onConnectivityChange(_onConnectivityChange);
    bg.BackgroundGeolocation.onHttp(_onHttp);
    bg.BackgroundGeolocation.onAuthorization(_onAuthorization);

    // 2.  Configure the plugin
    bg.BackgroundGeolocation.ready(bg.Config(
            reset: true,
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE,
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10.0,
            locationUpdateInterval: 5000,
            isMoving: true,
            // url: 'https://lawimmunity.herokuapp.com/locations',
            // authorization: bg.Authorization(
            //   accessToken:
            //       await FirebaseAuth.instance.currentUser!.getIdToken(),
            //   refreshToken: FirebaseAuth.instance.currentUser!.refreshToken,
            // ),
            // headers: {
            //   'authorization':
            //       'Bearer ${await FirebaseAuth.instance.currentUser!.getIdToken()}',
            // },
            // params: {
            //   'uid': FirebaseAuth.instance.currentUser!.uid,
            // },
            locationAuthorizationRequest: 'Always',
            backgroundPermissionRationale: bg.PermissionRationale(
                title:
                    "Allow LawImmunity to access this device's location even when the app is closed or not in use.",
                message:
                    'This app collects location data to enable recording your trips to work and calculate distance-travelled.',
                positiveAction: 'Change to "{backgroundPermissionOptionLabel}"',
                negativeAction: 'Cancel'),
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true))
        .then((bg.State state) {
      print('[ready] ${state.toMap()}');
      bg.BackgroundGeolocation.changePace(true).then((bool isMoving) {
        print('[changePace] success $isMoving');
      }).catchError((e) {
        print('[changePace] ERROR: ${e}');
      });
      bg.BackgroundGeolocation.start().then((value) {
        Provider.of<LocationProvider>(context, listen: false).isLocationShared =
            true;
      }).onError((error, stackTrace) {

        print('[start] ERROR: $error');

        Provider.of<LocationProvider>(context, listen: false).isLocationShared =
            false;
        error.toString().contains('Permission denied')
            ? showToast('Location permission is required')
            : showToast('$error');
        throw stackTrace;
      });
    }).catchError((error) {
      Provider.of<LocationProvider>(context, listen: false).isLocationShared =
          false;
      print('[ready] ERROR: $error');
    });
  }

  void _onLocation(bg.Location location) {
    print('[location] - $location');

    locationProvider!.currentLocation = location;
  }

  void _onLocationError(bg.LocationError error) {
    print('[location] ERROR - $error');
  }

  void _onMotionChange(bg.Location location) {
    print('[motionchange] - $location');
  }

  void _onActivityChange(bg.ActivityChangeEvent event) {
    print('[activitychange] - $event');
  }

  void _onHttp(bg.HttpEvent event) async {
    print('[${bg.Event.HTTP}] - $event');
  }

  void _onAuthorization(bg.AuthorizationEvent event) async {
    print('[${bg.Event.AUTHORIZATION}] = $event');
  }

  void _onProviderChange(bg.ProviderChangeEvent event) {
    print('$event');
  }

  void _onConnectivityChange(bg.ConnectivityChangeEvent event) {
    print('$event');
  }

  void stopLocationService(BuildContext context) {
    bg.BackgroundGeolocation.stop();

    Provider.of<LocationProvider>(context, listen: false).isLocationShared =
        false;
  }
}
