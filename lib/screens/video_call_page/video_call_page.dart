import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:enx_flutter_plugin/enx_player_widget.dart';

import 'package:enx_flutter_plugin/enx_flutter_plugin.dart';
import 'package:lawimmunity/services/firebase_services.dart';
import 'package:lawimmunity/widgets/app_logo.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class MyConfApp extends StatefulWidget {
  MyConfApp({required this.token});

  final String? token;

  @override
  Conference createState() => Conference();
}

class Conference extends State<MyConfApp> {
  bool isAudioMuted = false;
  bool isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    print('here 1');
    initEnxRtc();
    _addEnxrtcEventHandlers();
  }

  Future<void> initEnxRtc() async {
    Map<String, dynamic> map2 = {
      'minWidth': 320,
      'minHeight': 180,
      'maxWidth': 1280,
      'maxHeight': 720
    };
    Map<String, dynamic> map1 = {
      'audio': true,
      'video': true,
      'data': true,
      'framerate': 30,
      'maxVideoBW': 1500,
      'minVideoBW': 150,
      'audioMuted': false,
      'videoMuted': false,
      'name': 'flutter',
      'videoSize': map2
    };

    Map<String, dynamic> roomInfo = {
      'name': 'Topic or Room Title',
      'owner_ref': FirebaseServices().getCurrentUid(),
      'settings': {
        'live_recording': {
          'auto_recording': true,
        },
        'description': 'Descriptive text',
        'mode': 'group',
        'scheduled': true,
        'adhoc': false,
        'duration': 30,
        'single_file_recording': true,
        'moderators': '1',
        'participants': '3',
        'auto_recording': true,
        'quality': 'SD'
      },
      'sip': {'enabled': false},
      'data': {'custom_key': ''}
    };
    print('here 2');
    await EnxRtc.joinRoom(widget.token!, map1, roomInfo, []);
    print('here 3');
  }

  void _addEnxrtcEventHandlers() {
    print('here 4');
    EnxRtc.onRoomConnected = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onRoomConnectedFlutter' + jsonEncode(map));
      });
      EnxRtc.publish();
    };
    print('here 5');
    EnxRtc.onPublishedStream = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onPublishedStream' + jsonEncode(map));
        EnxRtc.setupVideo(0, 0, true, 300, 200);
      });
    };
    print('here 6');
    EnxRtc.onStreamAdded = (Map<dynamic, dynamic> map) {
      print('onStreamAdded' + jsonEncode(map));
      print('onStreamAdded Id' + map['streamId']);
      String? streamId;
      setState(() {
        streamId = map['streamId'];
      });
      EnxRtc.subscribe(streamId!);
    };
    print('here 7');
    EnxRtc.onRoomError = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onRoomError' + jsonEncode(map));
      });
    };
    EnxRtc.onNotifyDeviceUpdate = (String deviceName) {
      print('onNotifyDeviceUpdate' + deviceName);
    };
    print('here 8');
    EnxRtc.onActiveTalkerList = (Map<dynamic, dynamic> map) {
      print('onActiveTalkerList ' + map.toString());
      print('here 9');
      final items = (map['activeList'] as List)
          .map((i) => new ActiveListModel.fromJson(i));
      if (items.length > 0) {
        print('here 10');
        setState(() {
          for (final item in items) {
            if (!_remoteUsers.contains(item.streamId)) {
              print('_remoteUsers ' + map.toString());
              _remoteUsers.add(item.streamId);
            }
          }
        });
      }
    };
    print('here 11');
    EnxRtc.onEventError = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onEventError' + jsonEncode(map));
      });
    };
    print('here 12');
    EnxRtc.onEventInfo = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onEventInfo' + jsonEncode(map));
      });
    };
    print('here 13');
    EnxRtc.onUserConnected = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onUserConnected' + jsonEncode(map));
      });
    };
    EnxRtc.onUserDisConnected = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onUserDisConnected' + jsonEncode(map));
      });
    };
    print('here 14');
    EnxRtc.onRoomDisConnected = (Map<dynamic, dynamic> map) {
      setState(() {
        print('onRoomDisConnected' + jsonEncode(map));
        EnxRtc.stopRecord(); // To stop recording
        Navigator.pop(context, '/Conference');
      });
    };
    print('here 15');
    EnxRtc.onAudioEvent = (Map<dynamic, dynamic> map) {
      print('onAudioEvent' + jsonEncode(map));
      setState(() {
        if (map['msg'].toString() == 'Audio Off') {
          isAudioMuted = true;
        } else {
          isAudioMuted = false;
        }
      });
    };
    print('here 16');
    EnxRtc.onVideoEvent = (Map<dynamic, dynamic> map) {
      print('onVideoEvent' + jsonEncode(map));
      EnxRtc.startRecord(); // To start recording

      setState(() {
        if (map['msg'].toString() == 'Video Off') {
          isVideoMuted = true;
        } else {
          isVideoMuted = false;
        }
      });
    };
    print('here 17');
    EnxRtc.onACKStartLiveRecording = (Map<dynamic, dynamic> map) {
      print('onLiveRecordingEvent' + jsonEncode(map));
    };
  }

  void _setMediaDevice(String value) {
    Navigator.of(context, rootNavigator: true).pop();
    EnxRtc.switchMediaDevice(value);
  }

  createDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Media Devices'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: deviceList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(deviceList![index].toString()),
                          onTap: () =>
                              _setMediaDevice(deviceList![index].toString()),
                        );
                      },
                    ),
                  )
                ],
              ));
        });
  }

  void _disconnectRoom() {
    EnxRtc.disconnect();
    Navigator.pop(context);
  }

  void _toggleAudio() {
    if (isAudioMuted) {
      EnxRtc.muteSelfAudio(false);
    } else {
      EnxRtc.muteSelfAudio(true);
    }
  }

  void _toggleVideo() {
    if (isVideoMuted) {
      EnxRtc.muteSelfVideo(false);
    } else {
      EnxRtc.muteSelfVideo(true);
    }
  }

  void _toggleSpeaker() async {
    List<dynamic> list = await EnxRtc.getDevices();
    setState(() {
      deviceList = list;
    });
    print('deviceList');
    print(deviceList);
    createDialog();
  }

  void _toggleCamera() {
    EnxRtc.switchCamera();
  }

  int remoteView = -1;
  List<dynamic>? deviceList;

  // Widget _viewRows() {
  //   return Column(
  //     children: <Widget>[
  //       for (final widget in _renderWidget)
  //         Expanded(
  //           child: Container(
  //             child: widget,
  //           ),
  //         )
  //     ],
  //   );
  // }
  //
  // Iterable<Widget> get _renderWidget sync* {
  //   for (final streamId in _remoteUsers) {
  //     double width = MediaQuery.of(context).size.width;
  //     yield EnxPlayerWidget(streamId, local: false,width:width.toInt(),height:380);
  //   }
  // }

  // Widget _viewRows() {
  //   return  Expanded(
  //     child: EnxPlayerWidget(_remoteUsers.first, local: false),
  //   );
  // }

  // Iterable<Widget> get _renderWidget sync* {
  //   for (final streamId in _remoteUsers) {
  //     double width = MediaQuery.of(context).size.width;
  //     yield ;
  //   }
  // }

  final _remoteUsers = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Card(
              color: Colors.black,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height - 10,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: EnxPlayerWidget(
                        0,
                        local: false,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          // Container(
                          //   width: MediaQuery.of(context).size.width / 6,
                          //   child: MaterialButton(
                          //     child: isAudioMuted
                          //         ? Image.asset(
                          //             'assets/mute_audio.png',
                          //             fit: BoxFit.cover,
                          //             height: 30,
                          //             width: 30,
                          //           )
                          //         : Image.asset(
                          //             'assets/unmute_audio.png',
                          //             fit: BoxFit.cover,
                          //             height: 30,
                          //             width: 30,
                          //           ),
                          //     onPressed: _toggleAudio,
                          //   ),
                          // ),
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: MaterialButton(
                              child: Image.asset(
                                'assets/camera_switch.png',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              onPressed: _toggleCamera,
                            ),
                          ),
                          const Spacer(),

                          Center(
                            child: TextButton(
                                onPressed: () {},
                                child: UpperCaseText(
                                  'Send SOS to Nominees',
                                  style: Theme.of(context).textTheme.subtitle2,
                                )),
                          ),
                          const Spacer(),
                          // Container(
                          //   width: MediaQuery.of(context).size.width / 6,
                          //   child: MaterialButton(
                          //     child: isVideoMuted
                          //         ? Image.asset(
                          //             'assets/mute_video.png',
                          //             fit: BoxFit.cover,
                          //             height: 30,
                          //             width: 30,
                          //           )
                          //         : Image.asset(
                          //             'assets/unmute_video.png',
                          //             fit: BoxFit.cover,
                          //             height: 30,
                          //             width: 30,
                          //           ),
                          //     onPressed: _toggleVideo,
                          //   ),
                          // ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width / 6,
                          //   child: MaterialButton(
                          //     child: Image.asset(
                          //       'assets/unmute_speaker.png',
                          //       fit: BoxFit.cover,
                          //       height: 30,
                          //       width: 30,
                          //     ),
                          //     onPressed: _toggleSpeaker,
                          //   ),
                          // ),
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: MaterialButton(
                              child: Image.asset(
                                'assets/disconnect.png',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              onPressed: _disconnectRoom,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: const [
                          AppLogo(),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('RECORDING LIVE VIDEO + SAVING LOCATION'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActiveList {
  bool active;
  List<ActiveListModel> activeList = [];
  String event;

  ActiveList(this.active, this.activeList, this.event);

  factory ActiveList.fromJson(Map<dynamic, dynamic> json) {
    return ActiveList(
      json['active'] as bool,
      (json['activeList'] as List).map((i) {
        return ActiveListModel.fromJson(i);
      }).toList(),
      json['event'] as String,
    );
  }
}

class ActiveListModel {
  String name;
  int streamId;
  String clientId;
  String videoaspectratio;
  String mediatype;
  bool videomuted;
  String reason;

  ActiveListModel(this.name, this.streamId, this.clientId,
      this.videoaspectratio, this.mediatype, this.videomuted, this.reason);

  // convert Json to an exercise object
  factory ActiveListModel.fromJson(Map<dynamic, dynamic> json) {
    int sId = int.parse(json['streamId'].toString());
    return ActiveListModel(
      json['name'] as String,
      sId,
//      json['streamId'] as int,
      json['clientId'] as String,
      json['videoaspectratio'] as String,
      json['mediatype'] as String,
      json['videomuted'] as bool,
      json['reason'] as String,
    );
  }
}
