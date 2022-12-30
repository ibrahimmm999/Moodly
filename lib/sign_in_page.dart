import 'package:flutter/material.dart';

import 'shared/theme.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_form_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    Widget inputEmail() {
      return CustomTextFormField(
        icon: Icon(
          Icons.email_sharp,
          color: primaryColor,
        ),
        hintText: 'Your Email',
        controller: emailController,
        radiusBorder: defaultRadius,
      );
    }

    Widget inputPassword() {
      return CustomTextFormField(
        icon: Icon(Icons.lock, color: primaryColor),
        controller: passwordController,
        hintText: 'Your Password',
        obscureText: true,
        radiusBorder: defaultRadius,
      );
    }

    Widget submitButton() {
      return CustomButton(
          radiusButton: defaultRadius,
          buttonColor: primaryColor,
          buttonText: "Sign In",
          widthButton: double.infinity,
          onPressed: () {
            Navigator.pushNamed(context, '/home-admin');
          },
          heightButton: 50);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(defaultMargin),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Login",
                style: primaryColorText.copyWith(
                    fontSize: 24, fontWeight: semibold),
              ),
              Text(
                "Sign In to Countinue",
                style: greyText.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                "Email Address",
                style: darkText.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 12,
              ),
              inputEmail(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Password",
                style: darkText.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 12,
              ),
              inputPassword(),
              const SizedBox(
                height: 30,
              ),
              submitButton(),
              const SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: secondaryColorText.copyWith(fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign-up');
                      },
                      child: Text(
                        "Sign Up",
                        style: primaryColorText.copyWith(
                            fontSize: 12, fontWeight: medium),
                      ))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
