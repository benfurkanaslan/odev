import 'package:flutter/material.dart';
import '/util/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginFormState extends State<LoginForm> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          obscureText: false,
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email',
              labelStyle: TextStyle(
                  color: AppColors.secondary
              ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password',
              labelStyle: TextStyle(
                  color: AppColors.secondary
              ),
            ),
          ),
        ),
      ],
    );
  }
}

