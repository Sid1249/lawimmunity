import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lawimmunity/screens/nominess_page/models/nominee_model.dart';
import 'package:lawimmunity/screens/timeline_page/models/timeline_videos_model.dart';

class FirebaseServices {
  String? getCurrentUid() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.uid;
    }
    return null;
  }

  Future<String?> getUserToken() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var token = await FirebaseAuth.instance.currentUser!.getIdToken();
      return token;
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

  Future<List<Nominee>> getCurrentUserNomineeList() async {
    String? currentUserUID = getCurrentUser()?.uid;
    Map<String, dynamic> currentUserMap = {};
    List<Nominee> currentUserNomineeList = [];
    if (currentUserUID != null) {
      DocumentSnapshot<dynamic> currentUserSnapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUserUID)
          .get();
      currentUserMap = currentUserSnapshot.data();
      Map<String, dynamic>? nominees = currentUserMap['nominees'];
      if (nominees != null) {
        for (int i = 0; i < nominees.length; i++) {
          Map<String, dynamic>? tempNominee = nominees.values.toList()[i];
          if (tempNominee != null) {
            currentUserNomineeList.add(Nominee(
                nomineeName: tempNominee['name'],
                nomineePhone: tempNominee['phone'],
                nomineeUid: tempNominee['uid']));
          }
        }
      }
    }
    return currentUserNomineeList.reversed.toList();
  }

  Future<List<TimelineVideos>> getVideoList() async {
    String? currentUserUID = getCurrentUser()?.uid;
    List<TimelineVideos> currentUserVideoList = [];
    if (currentUserUID != null) {
      QuerySnapshot<dynamic> currentUserVideosSnapshot = await FirebaseFirestore
          .instance
          .collection('rooms')
          .where('uid', isEqualTo: currentUserUID)
          .get();
      if (currentUserVideosSnapshot.size > 0) {
        for (var element in currentUserVideosSnapshot.docs) {
          var tempRoomMap = element.data();
          currentUserVideoList.add(TimelineVideos(
            uid: tempRoomMap['uid'],
            time: tempRoomMap['time'],
            roomid: tempRoomMap['roomid'],
            coords: tempRoomMap['coords'],
            video: tempRoomMap['video'],
          ));
        }
      }
    }
    return currentUserVideoList;
  }

  String? generateRoomKey() {
    //todo: check if user is pro and has minutes to record
    return null;
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
