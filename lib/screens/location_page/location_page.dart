import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/location_page/location_model.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/location_head_widget.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool reversed = false;

  var locat = [
    LocationModel("2.882605, 2.532138", "none for now", "just now"),
    LocationModel("2.882605, 2.532138", "none for now", "2nd later"),
    LocationModel("2.882605, 2.532138", "none for now", "3rd later")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Location',
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              const LocationHead(),
              const SizedBox(
                height: 6,
              ),
              ListTile(
                contentPadding:
                const EdgeInsets.only(left: 4, right: 0, top: 0, bottom: 0),
                title: AutoSizeText.rich(
                  TextSpan(text: '', children: [
                    TextSpan(
                        text: 'LAST LOCATION: ',
                        style: TextStyle(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                          letterSpacing: 2.12,
                        )),
                    const TextSpan(
                        text: '2.882605, 2.532138',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: 2.12,
                        )),
                  ]),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    letterSpacing: 2.12,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                subtitle: UpperCaseText('Updated just now',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      letterSpacing: 0.62,
                    )),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.my_location,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .inversePrimary),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: const Color(0xffeb9404),
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 7,
                  bottom: 7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'PINNED LOCATIONS ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 2.45,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      child: Icon(
                        Icons.height,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .background,
                      ),
                      onTap: () {
                        setState(() {
                          reversed = !reversed;
                          locat = locat.reversed.toList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: locat.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(reversed ? "${locat.length - i}" : '${i + 1}'),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.list),
                          onPressed: () {},
                        ),
                        title: const Text(
                          '2.8882323,2.3422343',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.64,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I’M IN A CAB WITH SANTOSH AND HIS NUMBER IS 877323421',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 0.64,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              locat[i].time!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                letterSpacing: 0.62,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
              const SizedBox(
                height: 13,
              ),
              RaisedGradientButton('PIN CURRENT LOCATION', onPressed: () {}),
              const SizedBox(
                height: 13,
              ),
              Text.rich(
                TextSpan(text: '', children: [
                  TextSpan(
                      text: 'NOTE: ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium),
                  TextSpan(
                      text: 'FREE USERS LOCATION IS STORED ONLY FOR 12 HOURS',
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelSmall),
                ]),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  letterSpacing: 2.12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
