import 'package:flutter/material.dart';
import '/util/colors.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

TextEditingController createUsernameController = TextEditingController();
TextEditingController createEmailController = TextEditingController();
TextEditingController createPasswordController = TextEditingController();
TextEditingController createConfirmPasswordController = TextEditingController();
TextEditingController createBioController = TextEditingController();

class _SignUpFormState extends State<SignUpForm> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            obscureText: false,
            controller: createUsernameController,
            decoration: const InputDecoration(
              hintText: 'Username',
              hintStyle: TextStyle(color: AppColors.secondary),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.captionColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            obscureText: false,
            controller: createBioController,
            decoration: const InputDecoration(
              hintText: 'Bio',
              hintStyle: TextStyle(color: AppColors.secondary),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.captionColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            obscureText: false,
            controller: createEmailController,
            decoration: const InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: AppColors.secondary),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.captionColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            obscureText: false,
            controller: createPasswordController,
            decoration: const InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: AppColors.secondary),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.captionColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            obscureText: false,
            controller: createConfirmPasswordController,
            decoration: const InputDecoration(
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: AppColors.secondary),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.captionColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
