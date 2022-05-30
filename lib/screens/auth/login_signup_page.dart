import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawimmunity/screens/auth/otp_verficiation_modal.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/description_widget.dart';
import 'package:lawimmunity/widgets/pager_widget.dart';
import 'package:lawimmunity/widgets/phone_input_field.dart';
import 'package:lawimmunity/widgets/text_component.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({Key? key}) : super(key: key);

  @override
  _LoginSignupPageState createState() {
    return _LoginSignupPageState();
  }
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  int currentPageIndex = 0;

  String userPhone = '';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: LawImmunityAppBar(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DescriptionText(
                  title: 'Login/Signup',
                  subtitle: 'Login/Signup quickly to get started',
                ),
                Container(
                  height: 230,
                  child: Column(
                    children: [
                      
                      PageViewWidget(
                        currentPage: (int index) {
                          setState(() {
                            currentPageIndex = index;
                          });
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: 1.06,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: currentPageIndex == 0
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: 1.06,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: currentPageIndex == 1
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: 1.06,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: currentPageIndex == 2
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                width: 2,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                DescriptionText(
                  title: 'Enter Phone',
                ),
                PhoneInputField(
                  hintText: 'Phone Number',
                  onPhoneChanged: (phone) {
                    setState(() {
                      userPhone = phone;
                    });
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                Center(
                  child: RaisedGradientButton(
                    userPhone.isNotEmpty && userPhone.length > 5
                        ? 'CONTINUE '
                        : 'ENTER PHONE',
                    onPressed: () {
                      if (userPhone.isNotEmpty && userPhone.length > 5) {
                        OtpLoginModal().showOtpLoginModalSheet(
                            mobileNo: userPhone, context: context);
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerifyScreen()));
                    },
                    edgeInsets: const EdgeInsets.only(
                        top: 25, left: 40, right: 40, bottom: 25),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: AutoSizeText.rich(
                    TextSpan(
                        text: 'By continuing, you agree to our '.toUpperCase(),
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'T&C'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // code to open / launch terms of service link here
                                }),
                          const TextSpan(
                              text: ' AND ',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black),
                          ),
                          TextSpan(
                              text: 'Privacy Policy'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                Theme.of(context).colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // code to open / launch privacy policy link here
                                }),
                        ]),
                    minFontSize: 11,
                    maxLines: 1,
                  )),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
