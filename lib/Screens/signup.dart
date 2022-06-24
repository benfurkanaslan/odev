import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odev/home.dart';
import '../main.dart';
import '/Screens/feed.dart';
import '/Screens/login.dart';
import '/util/dimensions.dart';
import '/util/styles.dart';
import '/widgets/checkbox.dart';
import '/widgets/signupform.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static const String routeName = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Sign Up',
                style: titleText,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Already a member?',
                    style: subTitle,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Login',
                      style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: kDefaultPadding,
              child: SignUpForm(),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: kDefaultPadding,
              child: Check(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  user = (await auth.createUserWithEmailAndPassword(
                    email: createEmailController.text,
                    password: createPasswordController.text,
                  ))
                      .user;
                  await firestore.collection('users').doc(user!.uid).set({
                    'userName': createUsernameController.text.toLowerCase(),
                    'followerCount': 0,
                    'followingCount': 0,
                    'postCount': 0,
                    'userUid': user!.uid,
                    'userEmail': user!.email,
                    'emailVerified': false,
                    'userPassword': createPasswordController.text.toLowerCase(),
                    'firstLogin': DateTime.now(),
                    'lastLogin': DateTime.now(),
                    'userPhotoUrl': '-',
                    'isPrivate': false,
                    'bioText': createBioController.text,
                  });
                } on FirebaseAuthException catch (e) {
                  debugPrint('toast message:${e.toString()}');
                  Fluttertoast.showToast(
                    msg: e.toString(),
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
              icon: const Icon(Icons.navigate_next),
              label: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
