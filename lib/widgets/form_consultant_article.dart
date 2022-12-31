import 'package:flutter/material.dart';

import '../shared/theme.dart';

class FormConsultantAndArticle extends StatelessWidget {
  const FormConsultantAndArticle(
      {super.key,
      required this.controller,
      required this.minlines,
      required this.title});

  final TextEditingController controller;
  final int minlines;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: minlines,
      maxLines: null,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(color: primaryColor)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          fillColor: Colors.white,
          filled: true),
      validator: (value) {
        if (value!.isEmpty) {
          return '$title is Required!';
        }
        return null;
      },
    );
  }
}
