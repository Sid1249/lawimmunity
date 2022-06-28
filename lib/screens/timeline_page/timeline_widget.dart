import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lawimmunity/widgets/text_component.dart';
import 'package:path_provider/path_provider.dart';

class TimelineWidget extends StatefulWidget {
  final String videoId;
  final Timestamp? time;
  final String? coords;
  final String videoLink;
  final int index;

  const TimelineWidget(
      {Key? key,
      required this.videoId,
      required this.time,
      required this.coords,
      required this.index,
      required this.videoLink})
      : super(key: key);

  // Authorization: Basic bGF3aW1tdW5pdHkuY29tQGdtYWlsLmNvbToxOTM2NTM=

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  // late VideoPlayerController _controller;
  // late BetterPlayerController _betterPlayerController;
  // final FijkPlayer player = FijkPlayer();

  bool downloading = false;
  bool downloaded = false;
  var progressString = '';
  late Directory dir;
  double progressPercent = 0;

  @override
  void initState() {
    super.initState();

    // print(
    //     "videolink = ${widget.videoLink.replaceFirst("https://lawimmunity.com@gmail.com:193653@", 'https://')}");
    //
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   'https://fileproinfo.com/outputfiles/811905000137_1%20(1).webm',
    //   // headers: {
    //   //   'Authorization': 'Basic bGF3aW1tdW5pdHkuY29tQGdtYWlsLmNvbToxOTM2NTM=',
    //   //   'User-Agent': 'PostmanRuntime/7.29.0',
    //   //   'Host': 'portal.enablex.io',
    //   //   'Accept-Encoding': 'gzip, deflate, br',
    //   // },
    // );
    // _betterPlayerController = BetterPlayerController(
    //     const BetterPlayerConfiguration(),
    //     betterPlayerDataSource: betterPlayerDataSource);

    // _controller = VideoPlayerController.network(widget.videoLink.replaceFirst("https://lawimmunity.com@gmail.com:193653@", 'https://'), httpHeaders: {
    //   'Authorization': 'Basic bGF3aW1tdW5pdHkuY29tQGdtYWlsLmNvbToxOTM2NTM='
    // })
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
    // _controller.setLooping(true);
    // _controller.initialize().then((_) {
    //   setState(() {});
    // });
  }

  Future<void> downloadFile() async {
    dir = await getTemporaryDirectory();

    bool videoExists =
        await File('${dir.path}/demo${widget.index}.webm').exists();
    if (videoExists) {
      setState(() {
        downloading = true;
        downloaded = true;
      });
    } else {
      Dio dio = Dio();

      try {
        print('path ${dir.path}');
        await dio.download(
            widget.videoLink.replaceFirst(
                'https://lawimmunity.com@gmail.com:193653@', 'https://'),
            '${dir.path}/demo${widget.index}.webm',
            onReceiveProgress: (rec, total) {
          print('Rec: $rec , Total: $total');

          if (rec == total) {
            setState(() {
              downloaded = true;
            });
          }

          setState(() {
            downloading = true;
            progressPercent = (((rec / total) * 100));
            progressString = '${(((rec / total) * 100)).toStringAsFixed(0)}%';
          });
        },
            options: Options(headers: {
              'Authorization':
                  'Basic bGF3aW1tdW5pdHkuY29tQGdtYWlsLmNvbToxOTM2NTM=',
            }));
      } catch (e) {
        print(e);
      }
    }

    // print("start compress");
    // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    //   '${dir.path}/demo${widget.index}.webm',
    //   quality: VideoQuality.DefaultQuality,
    //   deleteOrigin: true, // It's false by default
    // );
    //
    // print("stop compress");
    //
    //
    //
    // VideoCompress.compressProgress$.subscribe((progress) {
    //   debugPrint('progress video: $progress');
    //   progressPercent = progress / 2 + progressPercent;
    //
    //
    // });

    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.file,
    //   mediaInfo!.file!.path,
    // );
    // _betterPlayerController = BetterPlayerController(
    //     const BetterPlayerConfiguration(),
    //     betterPlayerDataSource: betterPlayerDataSource);

        //     player.setDataSource('https://dl8.webmfiles.org/big-buck-bunny_trailer.webm',
        // autoPlay: true);

    print('Download completed');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                '#${widget.videoId}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (widget.time != null)
              UpperCaseText(DateFormat('dd-MMM-yyyy, kk:mm')
                  .format(DateTime.parse(widget.time!.toDate().toString())))
            else
              const Text('TIME UNKNOWN'),
            const SizedBox(
              height: 8,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 2.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.51),
                  topRight: Radius.circular(12.51),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                color: Color(0xffc4c4c4),
              ),
              child: downloading
                  ? downloaded == false
                      ? Container(
                          child: Card(
                            color: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const CircularProgressIndicator(),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'Loading: $progressString',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container()
                  : Center(
                      child: GestureDetector(
                          onTap: () {
                            downloadFile();
                          },
                          child: const Text('No Data'))),
            ),
            //   child: _controller.value.isInitialized
            //       ? SizedBox(
            //           width: 100.0,
            //           height: 56.0,
            //           child: GestureDetector(
            //               onTap: () {
            //                 // if (_controller.value.isPlaying) {
            //                 //   _controller.pause();
            //                 // } else {
            //                 //   _controller.play();
            //                 // }
            //               },
            //               child: VideoPlayer(_controller)),
            //         )
            //       : Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: const [
            //             CircularProgressIndicator(),
            //           ],
            //         ),
            // ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width / 1.5,
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //           onTap: () {
            //             if (_controller.value.isPlaying) {
            //               _controller.pause();
            //             } else {
            //               _controller.play();
            //             }
            //           },
            //           child: Icon(Icons.play_circle_fill)),
            //       Expanded(
            //         child: Container(
            //           color: Colors.grey,
            //           child: VideoProgressIndicator(
            //             _controller,
            //             allowScrubbing: true,
            //             padding: EdgeInsets.all(3),
            //             colors: VideoProgressColors(
            //                 playedColor: Theme.of(context).primaryColor),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5 / 2,
              height: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Color(0xffc4c4c4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.share,
                        color: Theme.of(context).colorScheme.onPrimary),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            if (widget.coords != null)
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Location: ${widget.coords}',
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      child: Column(
                        children: const [
                          Icon(Icons.my_location),
                          Text('SEE ON MAP')
                        ],
                      ),
                    ),
                  ),
                ),
              )
            else
              UpperCaseText('LOCATION UNKNOWN'),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
