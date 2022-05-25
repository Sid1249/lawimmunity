import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text.rich(TextSpan(
        text: "Law",
        style: GoogleFonts.baskervville(
            fontSize: 26, color: Colors.black, fontWeight: FontWeight.w500),
        children: [
          TextSpan(
              text: "Immunity",
              style: GoogleFonts.baskervville(
                  fontSize: 28,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  fontWeight: FontWeight.w800))
        ])),);
  }
}
