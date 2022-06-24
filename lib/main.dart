import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:odev/Screens/bottom_navbar.dart';
import 'package:odev/home.dart';
import 'Screens/login.dart';
import 'Screens/signup.dart';
import 'Screens/walkthrough.dart';
import 'firebase_options.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      home: Home(),
    ),
  );
}
