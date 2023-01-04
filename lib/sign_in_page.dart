import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/auth_cubit.dart';

import 'shared/theme.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_form_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inisialisasi
    final TextEditingController emailController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');

    AuthCubit authCubit = context.read<AuthCubit>();

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
        isPassword: true,
        radiusBorder: defaultRadius,
      );
    }

    Widget submitButton() {
      return BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.user.role == 'user') {
              Navigator.pushNamed(context, '/home-user');
            } else if (state.user.role == 'admin') {
              Navigator.pushNamed(context, '/home-admin');
            }
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(color: dark),
            );
          }
          return CustomButton(
              radiusButton: defaultRadius,
              buttonColor: primaryColor,
              buttonText: "Sign In",
              widthButton: double.infinity,
              onPressed: () {
                authCubit.signIn(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              heightButton: 50);
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            Text(
              "Login",
              style:
                  primaryColorText.copyWith(fontSize: 24, fontWeight: semibold),
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
                  style: greyText.copyWith(fontSize: 12),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-up');
                    },
                    child: Text(
                      "Sign Up",
                      style: secondaryColorText.copyWith(
                          fontSize: 12, fontWeight: medium),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
