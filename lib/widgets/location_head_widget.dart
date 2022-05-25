import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationHead extends StatefulWidget {
  const LocationHead({Key? key}) : super(key: key);

  @override
  _LocationHeadState createState() {
    return _LocationHeadState();
  }
}

class _LocationHeadState extends State<LocationHead> {
  var _switchValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.40),
        color: _switchValue
            ? Theme.of(context).colorScheme.onSecondaryContainer
            : Theme.of(context).colorScheme.error,
      ),
      padding: const EdgeInsets.only(left: 15, right: 23, top: 20, bottom: 20),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _switchValue
                    ? 'LOCATION SHARING IS ON'
                    : 'LOCATION SHARING IS OFF',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.64,
                ),
              ),
              const Spacer(),
              Theme(
                data: ThemeData(
                    backgroundColor: Colors.black,
                    switchTheme: SwitchThemeData().copyWith(
                        thumbColor: MaterialStateProperty.resolveWith((states) {
                          return _switchValue ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.inversePrimary ;
                    }),
                    trackColor: MaterialStateProperty.resolveWith((states) {
                      return _switchValue ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.background ;
                    }),

                    )),
                child: Switch.adaptive(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Text(
              _switchValue
                  ? 'WE ARE CONSTANTLY UPDATING YOUR LIVE LOCATION'
                  : 'YOU ARE NOT SYNCING YOUR LIVE LOCATION WITH US',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.64,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
