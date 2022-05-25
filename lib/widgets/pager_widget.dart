import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({Key? key, required this.currentPage}) : super(key: key);

  final Function(int) currentPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        scrollDirection: Axis.horizontal,
        onPageChanged: (index){
          currentPage(index);
        },
        children: const [
          CameraWidget(),
          LocationWidget(),
          PrivacyWidget(),
        ],
      ),
    );
  }
}

class CameraWidget extends StatelessWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsets.only(top: 49.92, left: 20, right: 20),
      child: Column(
        children: [
          const Icon(Icons.camera, size: 90),
          const SizedBox(
            height: 23.02,
          ),
          UpperCaseText(
            'record live videos of crime with our built in on-the-fly recording camera',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 10.53,
                letterSpacing: 2.54,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w500),
          ),
          
        ],
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsets.only(top: 49.92, bottom: 23.02, left: 20, right: 20),
      child: Column(
        children: [
          const Icon(Icons.camera, size: 90),
          const SizedBox(
            height: 23.02,
          ),
          UpperCaseText(
            'record live videos of crime with our built in on-the-fly recording camera',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 10.53,
                letterSpacing: 2.54,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsets.only(top: 49.92, bottom: 23.02, left: 20, right: 20),
      child: Column(
        children: [
          const Icon(Icons.camera, size: 90),
          const SizedBox(
            height: 23.02,
          ),
          UpperCaseText(
            'record live videos of crime with our built in on-the-fly recording camera',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 10.53,
                letterSpacing: 2.54,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
