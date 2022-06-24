import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odev/Screens/walkthrough.dart';
import 'package:odev/util/user.dart';

import 'Screens/bottom_navbar.dart';
import 'main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
  static const String routeName = 'home';
}

User? user1;
AppUser? appUser;

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  String? page;

  @override
  void initState() {
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        debugPrint('user boş');
        if (mounted) {
          setState(() {
            page = 'login';
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Walkthrough()));
          });
        }
      } else {
        debugPrint('user boş değil');
        debugPrint(user.uid);
        user1 = user;
        final snapshot =
            await firestore.collection('users').doc(user.uid).get();
        appUser = AppUser(
          userEmail: snapshot.data()!['userEmail'],
          username: snapshot.data()!['userName'],
          userUid: snapshot.data()!['userUid'],
          bioText: snapshot.data()!['bioText'],
          followerCount: snapshot.data()!['followerCount'],
          followingCount: snapshot.data()!['followingCount'],
          postCount: snapshot.data()!['postCount'],
          emailVerified: user.emailVerified,
          userPhotoUrl: snapshot.data()!['userPhotoUrl'],
          isPrivate: snapshot.data()!['isPrivate'],
        );
        debugPrint(appUser!.userUid);
        if (mounted) {
          setState(() {
            page = 'main';
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case 'login':
        {
          return const Walkthrough();
        }
      case 'main':
        {
          return const BottomNavBar();
        }
      default:
        {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
