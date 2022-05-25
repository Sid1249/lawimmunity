import 'package:flutter/material.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class SingleDashboardButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  const SingleDashboardButton({Key? key,required this.icon, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: itemWidth/3,
              height: itemWidth/3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.tertiary,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3f000000),
                    blurRadius: 1.02,
                    offset: Offset(0, 1.02),
                  ),
                ],
              ),
              child: Icon(icon,size: itemWidth/5.7,),
            ),
          ),
        ),
        SizedBox(height: 4,),
        UpperCaseText(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15.06,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.90,
          ),
        ),
      ],
    );
  }
}
