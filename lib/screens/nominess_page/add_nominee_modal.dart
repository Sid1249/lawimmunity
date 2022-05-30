import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/helpers/toast.dart';
import 'package:lawimmunity/screens/home_redirect_page.dart';
import 'package:lawimmunity/widgets/app_logo.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:lawimmunity/widgets/custom_form_textfield.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/phone_input_field.dart';

class AddNomineeModal {
  bool isAutoValidate = false;
  var errorMessage = '';
  String? phoneNumberR;
  String? nomineeNameR;
  String? countryCodeR;

  showAddNomineeModal(
      {String? phoneNumber,
      String? nomineeName,
      String? countryCode,
      bool isEditMode = false,
      required BuildContext context}) {
    phoneNumberR = phoneNumber;
    nomineeNameR = nomineeName;
    countryCodeR = countryCode;
    errorMessage = '';

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      isScrollControlled: true,
      builder: (BuildContext bcontext) {
        return AnimatedPadding(
          padding: MediaQuery.of(bcontext).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: BottomSheet(
            onClosing: () {},
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, setState) =>
                      SingleChildScrollView(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: Text(
                              isEditMode ? 'ADD NOMINEE' : 'EDIT NOMINEE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontFamily: 'Calistoga',
                                  fontSize: 21,
                                  letterSpacing: 2.12,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomFormField(
                              validator: (value) {
                                if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                                  return ['Only characters are allowed'];
                                }
                                return [];
                              },
                              labelName: 'NOMINEE NAME',
                              onTextChanged: (value) {
                                nomineeNameR = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PhoneInputField(
                              labelName: 'NOMINEE PHONE',
                              onPhoneChanged: (value) {
                                phoneNumberR = value;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'SAVE NOMINEE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffeb9404),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                        ],
                      )));
            },
          ),
        );
      },
    );
  }
}
