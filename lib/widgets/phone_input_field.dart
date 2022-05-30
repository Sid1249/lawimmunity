import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputField extends StatefulWidget {
  final Function(String) onPhoneChanged;

  final String labelName, hintText;

  const PhoneInputField(
      {Key? key,
      required this.onPhoneChanged,
      this.labelName = '',
      this.hintText = ''})
      : super(key: key);

  @override
  _PhoneInputFieldState createState() {
    return _PhoneInputFieldState();
  }
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  String initialCountryCode = '+91';

  String phoneNumber = '';

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
      padding: const EdgeInsets.only(left: 11, right: 11),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 2, bottom: 10),
              child: Text(
                widget.labelName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12.20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.45,
                ),
              ),
            ),
          Row(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.85),
                  border: Border.all(
                    color: Colors.black87,
                    width: 0.22,
                  ),
                ),
                child: CountryCodePicker(
                  onChanged: countryCodeSelection,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: '+91',
                  favorite: const ['+91', '+1'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = value;
                    widget.onPhoneChanged('$initialCountryCode$value');
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(12)],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.85)),
                    labelText: widget.hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void countryCodeSelection(CountryCode value) {
    initialCountryCode = value.dialCode!;
    widget.onPhoneChanged('$initialCountryCode$phoneNumber');
  }
}
