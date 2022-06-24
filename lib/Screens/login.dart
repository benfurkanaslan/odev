import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import '/Screens/feed.dart';
import '/Screens/forgotpassword.dart';
import '/Screens/profile.dart';
import '/Screens/signup.dart';
import '/util/colors.dart';
import '/util/styles.dart';
import '/util/dimensions.dart';
import '/widgets/loginform.dart';

User? user;

class Login extends StatelessWidget {
  var _element;

  Login({Key? key}) : super(key: key);

  static const String routeName = '/login';
  bool get mounted => _element != null;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'Welcome to Movienator',
                style: titleText,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: subTitle,
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Sign Up',
                      style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const LoginForm(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.headingColor,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    user = (await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    ))
                        .user;
                    await firestore.collection('users').doc(user!.uid).update({
                      'lastLogin': DateTime.now(),
                    });
                   
                  } on FirebaseAuthException catch (e) {
                    debugPrint('toast message:${e.toString()}');
                    Fluttertoast.showToast(
                      msg: e.toString(),
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Login'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: ImageIcon(
                                  AssetImage('images/google.png'),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sign Up with Google',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: ImageIcon(
                                  AssetImage('images/facebook.png'),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sign Up with Facebook',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
