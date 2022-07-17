
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lawimmunity/screens/location_page/location_page.dart';
import 'package:lawimmunity/screens/nominess_page/nominees_page.dart';
import 'package:lawimmunity/screens/settings_page/settings_page.dart';
import 'package:lawimmunity/screens/timeline_page/timeline_page.dart';
import 'package:lawimmunity/screens/video_call_page/recording_services.dart';
import 'package:lawimmunity/services/permission_service.dart';
import 'package:lawimmunity/services/shared_pref_services.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/location_head_widget.dart';
import 'package:lawimmunity/screens/dashboard/single_dashboadrd_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  late SharedPreferences _keyValueStore;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    SharedPrefServices().setUserName('Siddhant Parashar');

    GetIt getIt = GetIt.instance;

    _keyValueStore = getIt<SharedPreferences>();
    var userName = _keyValueStore.getString('user_name');

    return SafeArea(
      child: Scaffold(
        appBar: LawImmunityAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              const LocationHead(),
              const Spacer(),
              GridView.count(
                childAspectRatio: (itemWidth / itemHeight) * 2,
                primary: false,
                padding: const EdgeInsets.all(2),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  SingleDashboardButton(
                    text: 'Location',
                    icon: Icons.location_on,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LocationPage()));
                    },
                  ),
                  SingleDashboardButton(
                    text: 'Timeline',
                    icon: Icons.history,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TimelinePage()));
                    },
                  ),
                  SingleDashboardButton(
                    text: 'Nominees',
                    icon: Icons.spatial_audio_off,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NomineesPage()));
                    },
                  ),
                  SingleDashboardButton(
                    text: 'Settings',
                    icon: Icons.settings_sharp,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                    },
                  ),
                ],
              ),
              const Spacer(),
              RaisedGradientButton('Record Video', onPressed: () {
                PermissionService().RequestPermissions().then((value) {
                  if (value == true) {
                    RecordingServices().createRoom(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Permission denied',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                });
              }),
              TextButton(
                  onPressed: () {},
                  child: const AutoSizeText(
                    'SEND SOS TO NOMINEES WITH LOCATION',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.90,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
