import 'package:flutter/material.dart';
import 'package:lawimmunity/services/firebase_services.dart';
import 'package:lawimmunity/widgets/custom_form_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:lawimmunity/widgets/phone_input_field.dart';

class AddNomineeModal {
  bool isAutoValidate = false;
  var errorMessage = '';
  String? nomineePhoneNumberR;
  String? nomineeNameR;
  String? countryCodeR;
  Function(bool)? nomineeAddedOrNotCallbackR;

  showAddNomineeModal(
      {String? phoneNumber,
      String? nomineeName,
      String? countryCode,
      bool isEditMode = false,
      required Function(bool) nomineeAddedOrNotCallback,
      required BuildContext context}) {
    nomineePhoneNumberR = phoneNumber;
    nomineeNameR = nomineeName;
    countryCodeR = countryCode;
    errorMessage = '';
    nomineeAddedOrNotCallbackR = nomineeAddedOrNotCallback;

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
                              isEditMode ? 'EDIT NOMINEE' : 'ADD NOMINEE',
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
                                nomineePhoneNumberR = value;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              String? headerToken =
                                  await FirebaseServices().getUserToken();
                              if (headerToken != null) {
                                var url = Uri.parse(
                                    'https://us-central1-lawimmunity-2aa26.cloudfunctions.net/createnominee');

                                // http://10.0.2.2:5001/lawimmunity-2aa26/us-central1/createnominee
                                // https://us-central1-lawimmunity-2aa26.cloudfunctions.net/createnominee
                                try {
                                  var response = await http.post(url, body: {
                                    'nomineephone': '$nomineePhoneNumberR',
                                    'nomineename': '$nomineeNameR'
                                  }, headers: {
                                    'authorization': 'Bearer $headerToken',
                                  });

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print(
                                      'Response body: ${response.reasonPhrase}');

                                  if (response.statusCode == 300) {
                                    nomineeAddedOrNotCallbackR!(true);
                                  } else {
                                    nomineeAddedOrNotCallbackR!(false);
                                  }
                                } catch (e) {
                                  nomineeAddedOrNotCallbackR!(false);
                                }
                              } else {}
                            },
                            child: const Text(
                              'SAVE NOMINEE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffeb9404),
                                fontSize: 17,
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
