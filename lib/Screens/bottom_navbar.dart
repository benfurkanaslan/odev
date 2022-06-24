import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odev/home.dart';

import '/Screens/feed.dart';
import '/Screens/profile.dart';
import '/Screens/search.dart';
import '/Screens/notifications.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController pageViewController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        pageSnapping: true,
        onPageChanged: (int page) => {
          setState(() {
            currentIndex = page;
          }),
        },
        children: [
          const Feed(),
          const Search(),
          const Notifications(),
          Profile(appUser2: appUser),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '',
          ),
        ],
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            pageViewController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            currentIndex = index;
          });
        },
      ),
    );
  }
}
