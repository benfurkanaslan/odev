import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text('Email Verify')),
      body: Center(
        child: OutlinedButton(
          onPressed:() {
            auth.currentUser!.sendEmailVerification();
            Fluttertoast.showToast(msg: 'We sent an email to your email address, please verify and restart our app.');
          },
          child: const Text('Send Verify Message'),
        ),
      ),
    );
  }
}
