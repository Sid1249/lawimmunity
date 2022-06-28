import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/video_call_page/models/cloud_function_response_model.dart';
import 'package:lawimmunity/screens/video_call_page/video_call_page.dart';
import 'package:http/http.dart' as http;

class RecordingServices {
  static const String kBaseURL = 'https://api.enablex.io/video/v2/';

  Future<String?> createRoom(context) async {
    print('somethings');


    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final idToken = await user.getIdTokenResult();
        final token = idToken.token;

        var headers = {
          'authorization': 'Bearer ${token}',
        };

        var request = http.Request(
            'POST',
            Uri.parse(
                'https://us-central1-lawimmunity-2aa26.cloudfunctions.net/getroomtoken'));
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        var decodedResponse = await response.stream.bytesToString();

        if (response.statusCode == 300) {
          var token = decodedResponse;

          print('room token = ${token}');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyConfApp(
                        token: token.toString().trim(),
                      )));
          print(decodedResponse);
        } else {
          print(response.reasonPhrase);
          throw Exception('Error: Cannot get token');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

// FirebaseFunctions.instance.httpsCallable(
//   'createroom',
//   options: HttpsCallableOptions(
//     timeout: const Duration(seconds: 60),
//   ),
// ).call().then((value) {
//
//
//   try {
//     final result = value;
//
//
//     if(result.data != null){
//
//
//       RoomIdModel roomIdModel = RoomIdModel
//           .fromJson(result.data);
//
//       print("roomidmodel = ${roomIdModel.toJson()}");
//
//       // createToken(context, roomIdModel.room!.roomId!);
//
//
//       print(result.data);
//     }else{
//       throw Exception('Failed to connect to server');
//     }
//
//
//
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('$e'),
//       ),
//     );
//   }
//
// });
// }

// Future<String?> createToken(
//     context, String roomId) async {
//   var tokenInfo = {
//     'name': SharedPrefServices().getUserName(),
//     'role': 'moderator',
//     'user_ref': FirebaseServices().getCurrentUid()
//   };
//
//   print('body = ${jsonEncode(tokenInfo)}');
//
//   var response = await http.post(
//       Uri.parse('${kBaseURL}rooms/${roomId}/tokens'),
//       headers: header,
//       body: jsonEncode(tokenInfo));
//
//   print('response__body = ${response.body}');
//
//   if (response.statusCode == 200) {
//     Map<String, dynamic> user = jsonDecode(response.body);
//     print(user['token']);
//     print(user.toString());
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => MyConfApp(
//                   token: "eyJ0b2tlbklkIjoiNjJhNGExODBiYjI2OGZhMGU1YjBjNTVlIiwicm9vbU1ldGEiOnsiX2lkIjoiNjJhNGExNDNhODI0ZjRkM2M1ZWFiMTg2IiwibmFtZSI6IlRvcGljIG9yIFJvb20gVGl0bGUiLCJzZXJ2aWNlX2lkIjoiNjI5OWIyYmZmOTllZDI3NjFhYjY0ZGU0Iiwib3duZXJfcmVmIjoieHl6Iiwic2V0dGluZ3MiOnsiZGVzY3JpcHRpb24iOiJEZXNjcmlwdGl2ZSB0ZXh0IiwibW9kZSI6Imdyb3VwIiwic2NoZWR1bGVkIjpmYWxzZSwiYWRob2MiOmZhbHNlLCJkdXJhdGlvbiI6IjMwIiwicGFydGljaXBhbnRzIjoiMSIsImF1dG9fcmVjb3JkaW5nIjpmYWxzZSwic2NyZWVuX3NoYXJlIjp0cnVlLCJjYW52YXMiOmZhbHNlLCJtZWRpYV9jb25maWd1cmF0aW9uIjoiZGVmYXVsdCIsInF1YWxpdHkiOiJIRCIsIm1vZGVyYXRvcnMiOiIxIiwidmlld2VycyI6MCwiYWN0aXZlX3RhbGtlciI6dHJ1ZSwiZW5jcnlwdGlvbiI6ZmFsc2UsIndhdGVybWFyayI6ZmFsc2UsInNpbmdsZV9maWxlX3JlY29yZGluZyI6dHJ1ZSwibWF4X2FjdGl2ZV90YWxrZXJzIjoyLCJtZWRpYV96b25lIjoiWFgifSwic2lwIjp7ImVuYWJsZWQiOmZhbHNlfSwiZGF0YSI6eyJjdXN0b21fa2V5IjoiIn0sImNyZWF0ZWQiOiIyMDIyLTA2LTExVDE0OjA1OjU1Ljg3MFoifSwiaG9zdCI6InNzNC5lbmFibGV4LmlvOjQ0MyIsInNlY3VyZSI6dHJ1ZSwibG9nSWQiOiJBTFdCM2giLCJjdXJyZW50Um9vbU1vZGUiOiJncm91cCIsImdhdGV3YXkiOiIiLCJzaWduYXR1cmUiOiJNbUZpT0RJM01EQmxNRGcyTmpVME1qTTJZMll6Wm1VM1kyUTNPVGszTURCak5XRm1PR1k0Wmc9PSIsImRhdGEiOltdLCJldmVudFNlcnZlciI6eyJ1cmwiOiJlcy5lbmFibGV4LmlvIn19",
//                 )));
//     return response.body;
//   } else {
//     throw Exception('Failed to load post');
//   }
// }
}
