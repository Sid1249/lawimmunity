import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lawimmunity/helpers/logging.dart';

class FirebaseServices {
  String? getCurrentUid() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.uid;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getAppIdKey() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    Future<DatabaseEvent> myRef = database.ref('secret').once();
    final secretSnapshot = await myRef;
    if (secretSnapshot.snapshot.exists) {
      final secretNode = json.decode(json.encode(secretSnapshot.snapshot.value))
          as Map<String, dynamic>;
      return secretNode;
    } else {
      return null;
    }
  }

  String getCurrentPhone() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.phoneNumber!;
    }
    return '';
  }

  updateLocation() {}


  String? generateRoomKeyManual(String roomKey) {
    String? currentUid = getCurrentUid();
    if(currentUid!= null) {
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference myRef = database.ref('users').child(currentUid).child('videos');
        myRef.child(roomKey).child('rk').set(roomKey.toString());
        myRef.child(roomKey).child('ts').set(ServerValue.timestamp);
        return roomKey;

    }
    return null;
  }

  String? generateRoomKey() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference myRef = database.ref('users').child('videos');
    String? key = myRef.push().key;
    if (key != null) {
      myRef.child(key).child('rk').set(key.toString());
      myRef.child(key).child('ts').set(ServerValue.timestamp);
      return key;
    }
    return null;
  }
}
