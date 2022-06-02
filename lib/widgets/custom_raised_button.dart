import 'package:flutter/material.dart';

enum RaisedGradientButtonStyle {
  primary,
  secondary,
}

class RaisedGradientButton extends StatelessWidget {
  const RaisedGradientButton(
      this.label, {
        key,
        this.buttonKey,
        this.edgeInsets = EdgeInsets.zero,
        this.width = double.infinity,
        this.height = 46,
        this.radius = 4.77,
        required this.onPressed,
      }) : super(key: key);

  final Key? buttonKey;
  final String label;
  final double width;
  final double height;
  final double radius;
  final EdgeInsets edgeInsets;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: edgeInsets,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          onPrimary: Theme.of(context).colorScheme.primary,
          onSurface: Theme.of(context).colorScheme.primary,
          shadowColor : Theme.of(context).colorScheme.primary,
          surfaceTintColor : Theme.of(context).colorScheme.primary,
          primary: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
