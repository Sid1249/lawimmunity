import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/timeline_page/models/timeline_videos_model.dart';
import 'package:lawimmunity/screens/timeline_page/timeline_widget.dart';
import 'package:lawimmunity/services/firebase_services.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/description_widget.dart';
import 'package:lawimmunity/widgets/list_empty_container.dart';
import 'package:lawimmunity/widgets/location_head_widget.dart';
import 'package:lawimmunity/widgets/text_component.dart';
import 'package:lawimmunity/widgets/timeline.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  bool reversed = false;

  @override
  Widget build(BuildContext context) {
    buildTimelineVideos();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Timeline',
        ),
        body: Column(
          children: [
            DescriptionText(
              edgeInsetsTop: const EdgeInsets.only(top: 24, left: 13),
              edgeInsetsBottom: const EdgeInsets.only(top: 8, left: 13),
              title: 'VIDEO TIMELINE',
              subtitle:
                  'YOUR VIDEO TIMELINE IS A LIST OF VIDEOS YOU HAVE RECORDED USING LAWIMMUNITY APP, THESE VIDEOS CAN ALSO BE ACCESSED BY YOUR NOMINEES.',
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: FutureBuilder<List<TimelineWidget>>(
              future: buildTimelineVideos(), // async work
              builder: (BuildContext context,
                  AsyncSnapshot<List<TimelineWidget>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error),
                        ),
                      );
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const ListEmptyContainer(
                          emptyText:
                              'YOUR VIDEO TIMELINE HISTORY IS EMPTY!\nWHEN YOU RECORD VIDEOS USING LAWIMMUNITY CAMERA, THEY WILL APPEAR HERE',
                          icon: Icons.delete_outline_outlined,
                        );
                      } else {
                        return Timeline(
                          indicatorColor: Colors.orange[300]!,
                          indicatorSize: 40,
                          children: snapshot.data!,
                        );
                      }
                    }
                }
              },
            )),
            const SizedBox(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Future<List<TimelineWidget>> buildTimelineVideos() async {
    List<TimelineWidget> listTimeLineVideos = [];
    final timelineVideos = await FirebaseServices().getVideoList();
    for (int i =0 ; i < timelineVideos.length ; i++) {
      final element = timelineVideos[i];
      listTimeLineVideos.add(TimelineWidget(
        index: i,
        videoId: element.roomid ?? '',
        videoLink: element.video ?? '',
        time: element.time,
        coords: element.coords ?? '',
      ));
    }
    return listTimeLineVideos;
  }
}

// listTimeLineVideos.isNotEmpty
// ?
