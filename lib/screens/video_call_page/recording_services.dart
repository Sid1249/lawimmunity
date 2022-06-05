import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lawimmunity/helpers/logging.dart';
import 'package:lawimmunity/helpers/shared_keys.dart';
import 'package:lawimmunity/screens/video_call_page/video_call_page.dart';
import 'package:lawimmunity/services/firebase_services.dart';
import 'package:lawimmunity/services/shared_pref_services.dart';
import 'package:http/http.dart' as http;

class RecordingServices {
  static const String kBaseURL = 'https://demo.enablex.io/';
  static bool kTry = false;

  Future<String?> createToken(context) async {
    Map<String, dynamic>? appIdKeyMap = await FirebaseServices().getAppIdKey();
    if (appIdKeyMap != null) {
      var header = (kTry)
          ? {
              'x-app-id': appIdKeyMap[SharedKeys.appId].toString(),
              'x-app-key': appIdKeyMap[SharedKeys.appKey].toString(),
              'Content-Type': 'application/json'
            }
          : {'Content-Type': 'application/json'};

      String? roomKey;
      roomKey = await createRoom();

      if (roomKey != null) {
        var value = {
          'user_ref': FirebaseServices().getCurrentUid(),
          'roomId': roomKey,
          'role': 'lecture',
          'name': SharedPrefServices().getUserName()
        };
        var response = await http.post(Uri.parse('${kBaseURL}createToken'),
            // replace FQDN with Your Server API URL
            headers: header,
            body: jsonEncode(value));

        if (response.statusCode == 200) {
          Map<String, dynamic> user = jsonDecode(response.body);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyConfApp(
                        token: user['token'].toString(),
                      )));
          return response.body;
        } else {
          throw Exception('Failed to load post');
        }
      }
    } else {
      return null;
    }
    return null;
  }

  Future<String?> createRoom() async {
    Map<String, dynamic>? appIdKeyMap = await FirebaseServices().getAppIdKey();
    if (appIdKeyMap != null) {
      var header = (kTry)
          ? {
              'x-app-id': appIdKeyMap[SharedKeys.appId].toString(),
              'x-app-key': appIdKeyMap[SharedKeys.appKey].toString(),
              'Content-Type': 'application/json'
            }
          : {'Content-Type': 'application/json'};

      var response = await http.post(
          Uri.parse(
              '${kBaseURL}createRoom'), // replace FQDN with Your Server API URL
          headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> user = jsonDecode(response.body);
        print_debug(response.body);
        Map<String, dynamic> room = user['room'];
        FirebaseServices().generateRoomKeyManual(room['room_id'].toString());
        return room['room_id'].toString();
      } else {
        throw Exception('Failed to load post');
      }
    } else {
      return null;
    }
  }
}
