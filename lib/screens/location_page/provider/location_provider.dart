import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:latlong2/latlong.dart';
import 'package:lawimmunity/widgets/flutter_map_widget.dart';

class LocationProvider extends ChangeNotifier {
  bool _isLocationShared = false;

  DateTime _updateTime = DateTime.now();

  Location? _currentLocation;

  bool get isLocationShared => _isLocationShared;

  MapWrapperController mapWrapperController = MapWrapperController();

  set isLocationShared(bool value) {
    _isLocationShared = value;
    notifyListeners();
  }

  DateTime get updateTime => _updateTime;

  set updateTime(DateTime value) {
    _updateTime = value;
  }


  Location? getCurrentLocation() {
    // if(_currentLocation != null) {
    return _currentLocation;
    // }else{
    //   if(isLocationShared){
    //
    //     BackgroundGeolocation.getCurrentPosition().then((location) {
    //       currentLocation = location;
    //     });
    //   }else{
    //     return null;
    //   }
    // }
  }

  set currentLocation(Location value) {
    _currentLocation = value;
    _updateTime = DateTime.now();
    mapWrapperController.controller!
        .move(LatLng(value.coords.latitude, value.coords.longitude), 16);
    notifyListeners();
  }
}
