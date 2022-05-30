import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class DescriptionText extends StatelessWidget {
  String title;
  String subtitle;
  EdgeInsets edgeInsetsTop;
  EdgeInsets edgeInsetsBottom;


  DescriptionText({Key? key, this.title = '', this.subtitle = '', this.edgeInsetsTop = const EdgeInsets.only(top: 29.9,left: 9.79,bottom: 5.17) , this.edgeInsetsBottom = const EdgeInsets.only(left: 9.79)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: edgeInsetsTop ,
        child: UpperCaseText(title,
            style: GoogleFonts.calistoga(
                fontSize: 18.87,
                letterSpacing: 2.19,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w400)),
      ),
      Padding(
        padding: edgeInsetsBottom,
        child: UpperCaseText(subtitle,
          style: GoogleFonts.roboto(
              fontSize: 10.53,
              letterSpacing: 2.54,
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w500),),
      )

    ],);
  }
}
