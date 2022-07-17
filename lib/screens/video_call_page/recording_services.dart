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

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => MyConfApp(
          //               token: token.toString().trim(),
          //             )));
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
}
