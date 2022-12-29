import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double heightButton;
  final double widthButton;
  final double radiusButton;
  final Color buttonColor;

  const CustomButton(
      {Key? key,
      required this.radiusButton,
      required this.buttonColor,
      required this.buttonText,
      required this.widthButton,
      required this.onPressed,
      required this.heightButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthButton,
      height: heightButton,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style:
                whiteText.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radiusButton)))),
    );
  }
}
