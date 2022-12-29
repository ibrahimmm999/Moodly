import 'package:flutter/material.dart';

import '../../shared/theme.dart';

// UNTUK LOGIN DAN SIGN UP

class CustomTextFormField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final double radiusBorder;

  const CustomTextFormField(
      {Key? key,
      required this.icon,
      required this.radiusBorder,
      this.hintText = '',
      this.obscureText = false,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            controller: controller,
            obscureText: obscureText,
            cursorColor: primaryColor,
            decoration: InputDecoration(
                prefixIcon: icon,
                hintText: hintText,
                hintStyle: greyText,
                focusColor: primaryColor,
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(radiusBorder)),
                    borderSide: BorderSide(color: grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radiusBorder),
                    borderSide: BorderSide(color: primaryColor)))),
      ],
    );
  }
}
