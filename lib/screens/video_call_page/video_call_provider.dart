import 'package:flutter/material.dart';

class VideoCallProvider extends ChangeNotifier{


  String? _roomId;

  String? get roomId => _roomId;

  set roomId(String? value) {
    _roomId = value;
    notifyListeners();
  }
}