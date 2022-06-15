import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  Future<bool> RequestPermissions() async {
    bool allGranted = false;
    Map<Permission, PermissionStatus> result = await [
      Permission.microphone,
      Permission.camera,
      Permission.location
    ].request();
      for (var element in result.keys) {
        allGranted  = await element.isGranted;
    }
    return allGranted;
  }

  // Future<bool> requestPermission({Function? onPermissionDenied}) async {
  //   var granted = await _requestPermission();
  //   if (!granted) {
  //     onPermissionDenied!();
  //   }
  //   return granted;
  // }

  Future<bool> hasPhonePermission() async {
    return Permission.phone.isGranted;
  }
}