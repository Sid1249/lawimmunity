
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider extends ChangeNotifier{

  bool _isLocationShared = false;

  DateTime _updateTime = DateTime.now();

  late Location _currentLocation;

  bool get isLocationShared => _isLocationShared;

  MapController _mapController = MapController();

  set isLocationShared(bool value) {
    _isLocationShared = value;
    notifyListeners();
  }

  DateTime get updateTime => _updateTime;

  set updateTime(DateTime value) {
    _updateTime = value;
  }

  Location get currentLocation => _currentLocation;

  set currentLocation(Location value) {
    _currentLocation = value;
    _updateTime = DateTime.now();
    mapController.move(LatLng(value.coords.latitude,value.coords.longitude),16);
    notifyListeners();
  }

  MapController get mapController => _mapController;

  set mapController(MapController value) {
    _mapController = value;
  }
}