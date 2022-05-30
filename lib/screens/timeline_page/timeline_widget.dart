import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
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
              child: Icon(Icons.play_circle_fill,color: Theme.of(context).colorScheme.onPrimary,),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5 / 2,
              height: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
                  color: Color(0xffc4c4c4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.share,color: Theme.of(context).colorScheme.onPrimary), onPressed: () {



                  },),
                  IconButton(icon: Icon(Icons.delete,color: Theme.of(context).colorScheme.onPrimary,), onPressed: () {



                  },),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
