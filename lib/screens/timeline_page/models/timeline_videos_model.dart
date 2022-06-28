import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineVideos {
  final String? uid;
  final Timestamp? time;
  final String? roomid;
  final String? coords;
  final String? video;

  TimelineVideos({this.uid, this.time, this.roomid, this.coords,this.video});
}

