import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';
import 'package:lawimmunity/widgets/description_widget.dart';

class NomineesPage extends StatefulWidget {
  const NomineesPage({Key? key}) : super(key: key);

  @override
  State<NomineesPage> createState() => _NomineesPageState();
}

class _NomineesPageState extends State<NomineesPage> {

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
              title: 'NOMINEES',
              subtitle:
              'NOMINEES CAN ACCESS YOUR RECORDED VIDEOS AND LAST LOCATION IN CASE OF EMERGENCY.',
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
