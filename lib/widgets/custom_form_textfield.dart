import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final bool enabled;
  final String labelName, hintText;
  final List<String> Function(String) validator;
  final int maxLines, minLines;
  final ValueChanged<String> onTextChanged;

  late List<String> errorList = [];

  final bool isPasswordField;

  void setErrorList(List<String> listOfError) {
    errorList = listOfError;
  }

  CustomFormField({
    Key? key,
    this.enabled = true,
    this.labelName = '',
    this.hintText = '',
    required this.validator,
    this.maxLines = 1,
    this.minLines = 1,
    required this.onTextChanged,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() {
    return _CustomFormFieldState();
  }
}

class _CustomFormFieldState extends State<CustomFormField> {
  var obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPasswordField ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> errorList = [];

  //Update the state from inside the widget
  void setErrorList(List<String> listOfError) {
    setState(() {
      errorList = listOfError;
    });
  }

  _buildPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4,left: 11, right: 11),
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
          TextField(
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            onChanged: (value) {
              widget.onTextChanged(value);
              setErrorList(widget.validator(value));
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.85)),
              labelText: widget.hintText,
            ),
            obscureText: obscureText,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: errorList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              String value = errorList.elementAt(index);
              return Container(
                decoration: BoxDecoration(
                    color: const Color(0xff1E2838),
                    borderRadius: index == errorList.length - 1
                        ? const BorderRadius.only(
                            bottomLeft: const Radius.circular(6),
                            bottomRight: const Radius.circular(6))
                        : null),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
