import 'package:flutter/material.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class NomineeWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;

  const NomineeWidget(
      {Key? key, required this.index, this.title = '', this.subtitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: UpperCaseText(
        title,
        style: const TextStyle(
          color: Colors.orange,
          fontSize: 14.15,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          letterSpacing: 2.45,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12.74,
          letterSpacing: 2.45,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 3,left: 8,right: 8),
        child: Text('#${index + 1}',style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          letterSpacing: 2.45,
        ),),
      ),
      trailing: IconButton(
        icon: Icon(Icons.dehaze_sharp,color: Theme.of(context).colorScheme.onPrimary,),
        onPressed: () {},
      ),
    );
  }
}
