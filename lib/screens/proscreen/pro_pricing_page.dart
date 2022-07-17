import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/proscreen/more_options_modal.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';

class ProPricingPage extends StatelessWidget {
  const ProPricingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LawImmunityAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                '₹799',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 51),
              ),
              const Spacer(),
              const Text(
                'TAKE OUR LAW IMMUNITY ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Roboto',
                    fontSize: 11.4,
                    letterSpacing: 2.7,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              const Spacer(),
              const Text(
                'GET SECURITY AND PROTECTION FOR YOU AND YOUR LOVED ONES',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Roboto',
                    fontSize: 11.4,
                    letterSpacing: 2.7,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: IconWithText(
                        iconData: Icons.camera, iconText: 'SYNC YOUR LOCATION'),
                  ),
                  Expanded(
                    child: IconWithText(
                        iconData: Icons.emergency_recording,
                        iconText: 'RECORD CRIME LIVE'),
                  ),
                  Expanded(
                    child: IconWithText(
                        iconData: Icons.local_police,
                        iconText: 'TAKE QUICK  ACTION'),
                  ),
                ],
              ),
              const Spacer(),
              RaisedGradientButton('Buy Now for 1 Year', onPressed: () {}),
              TextButton(
                  onPressed: () {
                    MoreOptionsModal().showMoreOptionsModal(context: context);
                  },
                  child: Text(
                    'MORE OPTIONS NEEDED?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ]),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String iconText;

  const IconWithText({Key? key, required this.iconData, required this.iconText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Icon(iconData),
        SizedBox(height: 3,),
        SizedBox(
          width: width / 3,
          child: Text(
            iconText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Roboto',
                fontSize: 8.7,
                letterSpacing: 2.1,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        )
      ],
    );
  }
}
