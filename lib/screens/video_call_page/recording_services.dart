import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lawimmunity/helpers/logging.dart';
import 'package:lawimmunity/helpers/shared_keys.dart';
import 'package:lawimmunity/screens/video_call_page/video_call_page.dart';
import 'package:lawimmunity/services/firebase_services.dart';
import 'package:lawimmunity/services/shared_pref_services.dart';
import 'package:http/http.dart' as http;

class RecordingServices {
  static const String kBaseURL = 'https://api.enablex.io/video/v2/';

  Future<String?> createRoom(context) async {
    Map<String, dynamic>? appIdKeyMap = await FirebaseServices().getAppIdKey();



    if (appIdKeyMap != null) {
      var encodedAuthString = base64.encode(utf8.encode(
          '${appIdKeyMap[SharedKeys.appId]}:${appIdKeyMap[SharedKeys.appKey]}'));
      var header = {
        'accept': 'application/json',
        'Authorization': 'Basic $encodedAuthString',
        'Content-Type': 'application/json'
      };
      createToken(context, header, "629ef9d2bb268fa0e5b0b21e");


      print(header);

      print_debug('appkey = ${appIdKeyMap[SharedKeys.appKey].toString()}');
      print_debug('appid = ${appIdKeyMap[SharedKeys.appId].toString()}');

      var data = '{"name":"Topic or Room Title","owner_ref":"pop","settings":{"description":"Descriptive text","mode":"group","scheduled":false,"adhoc":false,"duration":30,"moderators":"1","participants":"5","auto_recording":false,"quality":"SD","canvas":false,"screen_share":false,"max_active_talkers":4,"knock":false,"wait_for_moderator":false,"single_file_recording":true,"role_based_recording":{"moderator":"audiovideo","participant":"audio"},"live_recording":{"auto_recording":true}},"sip":{"enabled":false},"data":{"custom_key":""}}';


      // var roomInfo = {
      //   "name": "Topic or Room Title",
      //   "owner_ref": "xyz",
      //   "settings": {
      //     "description": "Descriptive text",
      //     "mode": "group",
      //     "scheduled": false,
      //     "adhoc": false,
      //     "duration": 30,
      //     "moderators": "1",
      //     "participants": "2",
      //     "auto_recording": false,
      //     "quality": "SD"
      //   },
      //   "sip": {"enabled": false},
      //   "data": {"custom_key": ""}
      // };

      var response = await http.post(Uri.parse('${kBaseURL}rooms'),
          // replace FQDN with Your Server API URL
          headers: header,
          body: data+"rfrfrfrfesef");

      print('response__body = ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> user = jsonDecode(response.body);
        print_debug(response.body);
        Map<String, dynamic> room = user['room'];
        print('heree 1');
        FirebaseServices().generateRoomKeyManual(room['room_id'].toString());
        print('heree 2');
        createToken(context, header, "629ef9d2bb268fa0e5b0b21e");

        return room['room_id'].toString();
      } else {
        throw Exception('Failed to load post');
      }
    } else {
      return null;
    }
  }

  Future<String?> createToken(
      context, Map<String, String> header, String roomId) async {
    var tokenInfo = {
      'name': SharedPrefServices().getUserName(),
      'role': 'moderator',
      'user_ref': FirebaseServices().getCurrentUid()
    };

    print('body = ${jsonEncode(tokenInfo)}');

    var response = await http.post(
        Uri.parse('${kBaseURL}rooms/${roomId}/tokens'),
        headers: header,
        body: jsonEncode(tokenInfo));

    print('response__body = ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user['token']);
      print(user.toString());
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
}
