import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  List<Widget>? actionWidgets;

  CustomAppBar({Key? key, required this.title,this.actionWidgets})
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
      actions: actionWidgets??[],
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      title: Text(title,
          style: GoogleFonts.baskervville(
              fontSize: 28,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800)),
    );
  }
}
