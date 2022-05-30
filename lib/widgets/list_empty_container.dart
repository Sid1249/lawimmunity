import 'package:flutter/material.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class ListEmptyContainer extends StatelessWidget {
  final IconData icon;
  final String emptyText;

  const ListEmptyContainer({Key? key, required this.icon, this.emptyText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,size: MediaQuery.of(context).size.width/2,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/9,),
          child: UpperCaseText(
            emptyText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12.21,
              letterSpacing: 2.12,
            ),
          ),
        ),
        const SizedBox(height: 50,),
      ],
    );
  }
}
