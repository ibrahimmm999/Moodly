import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import '../../shared/theme.dart';
import '../widgets/custom_text_form_field.dart';
import 'widgets/custom_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi
    final TextEditingController fullNameController =
        TextEditingController(text: '');
    final TextEditingController usernameController =
        TextEditingController(text: '');
    final TextEditingController emailController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');

    AuthCubit authCubit = context.read<AuthCubit>();

    Widget inputFullName() {
      return CustomTextFormField(
        icon: Icon(
          Icons.person_rounded,
          color: primaryColor,
        ),
        hintText: 'Your Full Name',
        controller: fullNameController,
        radiusBorder: defaultRadius,
      );
    }

    Widget inputUsername() {
      return CustomTextFormField(
        icon: Icon(
          Icons.radio_button_checked_rounded,
          color: primaryColor,
        ),
        hintText: 'Your Username',
        controller: usernameController,
        radiusBorder: defaultRadius,
      );
    }

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
      return BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamed(context, '/home-user');
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
            buttonText: "Sign Up",
            widthButton: double.infinity,
            heightButton: 50,
            onPressed: () {
              authCubit.signUp(
                email: emailController.text,
                password: passwordController.text,
                name: fullNameController.text,
                username: usernameController.text,
              );
            },
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: primaryColorText.copyWith(
                      fontSize: 24, fontWeight: semibold),
                ),
                Text(
                  "Register and Happy Your Mood",
                  style: darkText.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Full Name",
                  style: darkText.copyWith(fontSize: 16, fontWeight: medium),
                ),
                const SizedBox(
                  height: 12,
                ),
                inputFullName(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Username",
                  style: darkText.copyWith(fontSize: 16, fontWeight: medium),
                ),
                const SizedBox(
                  height: 12,
                ),
                inputUsername(),
                const SizedBox(
                  height: 20,
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: greyText.copyWith(fontSize: 12),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign-in');
                        },
                        child: Text(
                          "Sign In",
                          style: secondaryColorText.copyWith(
                              fontSize: 12, fontWeight: medium),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
