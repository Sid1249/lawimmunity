import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LawImmunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  LawImmunityAppBar({Key? key})
      : preferredSize = const Size.fromHeight(42),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[200],
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      title: Text.rich(TextSpan(
          text: "Law",
          style: GoogleFonts.baskervville(
              fontSize: 26, color: Colors.black, fontWeight: FontWeight.w500),
          children: [
            TextSpan(
                text: "Immunity",
                style: GoogleFonts.baskervville(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800))
          ])),
    );
  }

}
