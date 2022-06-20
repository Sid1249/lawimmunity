import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  String? getCurrentUid() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.uid;
    }
    return null;
  }

  String getCurrentPhone() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.phoneNumber!;
    }
    return '';
  }

  updateLocation() {}

  String? generateRoomKey() {
    //todo: check if user is pro and has minutes to record
    return null;
  }
}
