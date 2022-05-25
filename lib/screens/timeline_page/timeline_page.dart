import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/description_widget.dart';
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
  List<Widget> listTimeLineVideos = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Location',
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
                child: ListView.builder(
              itemCount: 6,
              reverse: reversed,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Timeline(
                  children: buildTimelineVideos(),
                  indicatorColor: Colors.orange[300]!,
                  indicatorSize: 40,
                );
              },
            )),
            const SizedBox(
              height: 13,
            ),
            RaisedGradientButton('PIN CURRENT LOCATION', onPressed: () {}),
            const SizedBox(
              height: 13,
            ),
            Text.rich(
              TextSpan(text: '', children: [
                TextSpan(
                    text: 'NOTE: ',
                    style: Theme.of(context).textTheme.labelMedium),
                TextSpan(
                    text: 'FREE USERS LOCATION IS STORED ONLY FOR 12 HOURS',
                    style: Theme.of(context).textTheme.labelSmall),
              ]),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                letterSpacing: 2.12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildTimelineVideos() {
    listTimeLineVideos = [];
    for (int i = 0; i < 6; i++) {
      listTimeLineVideos.add(Row(
        children: [
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.51),
                    topRight: Radius.circular(12.51),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color(0xffc4c4c4),
                ),
                child: Icon(Icons.play_circle_fill),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5 / 2,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
                    color: Color(0xffc4c4c4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 27.826412200927734),
                    const FlutterLogo(size: 27.826412200927734),

                  ],
                ),
              )
            ],
          ),
          Spacer(),
        ],
      ));
    }
    return listTimeLineVideos;
  }
}
