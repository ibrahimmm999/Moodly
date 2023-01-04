import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/obscure_form_cubit.dart';

import '../../shared/theme.dart';

// UNTUK LOGIN DAN SIGN UP

class CustomTextFormField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final double radiusBorder;

  const CustomTextFormField(
      {Key? key,
      required this.icon,
      required this.radiusBorder,
      this.isPassword = false,
      this.hintText = '',
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ObscureFormCubit obscureFormCubit = context.read<ObscureFormCubit>();
    obscureFormCubit.change(true);

    return BlocBuilder<ObscureFormCubit, bool>(
      bloc: obscureFormCubit,
      builder: (context, state) {
        return TextFormField(
            controller: controller,
            obscureText: isPassword ? state : false,
            cursorColor: primaryColor,
            decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: isPassword,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      obscureFormCubit.change(!state);
                    },
                    child: state
                        ? Icon(
                            Icons.visibility_off,
                            color: grey,
                          )
                        : Icon(
                            Icons.visibility,
                            color: primaryColor,
                          ),
                  ),
                ),
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
                    borderSide: BorderSide(color: primaryColor))));
      },
    );
  }
}
