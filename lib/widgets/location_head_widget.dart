import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lawimmunity/screens/location_page/location_provider.dart';
import 'package:lawimmunity/screens/location_page/location_service.dart';
import 'package:provider/provider.dart';

class LocationHead extends StatefulWidget {
  const LocationHead({Key? key}) : super(key: key);

  @override
  _LocationHeadState createState() {
    return _LocationHeadState();
  }
}

class _LocationHeadState extends State<LocationHead> {

  GetIt getIt = GetIt.instance;
  late LocationService locationService;

  @override
  void initState() {
    super.initState();
    locationService = getIt<LocationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
  builder: (context, provider, child) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.40),
        color: provider.isLocationShared
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
                provider.isLocationShared
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
                          return provider.isLocationShared ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.inversePrimary ;
                    }),
                    trackColor: MaterialStateProperty.resolveWith((states) {
                      return provider.isLocationShared ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.background ;
                    }),

                    )),
                child: Switch.adaptive(
                  value: provider.isLocationShared,
                  onChanged: (value) {
                    provider.isLocationShared = value;
                    if(value){
                      locationService.startLocationService(context);
                    }else{
                      locationService.stopLocationService(context);

                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Text(
              provider.isLocationShared
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
  },
);
  }
}
