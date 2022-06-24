import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('notifications')
            .doc(appUser!.userUid)
            .collection('following')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      title: Text(
                        '${snapshot.data.docs[index]['ownerUsername']} followed you',
                      ),
                      trailing: (() {
                        if (snapshot.data.docs[index]['ownerPhotoUrl'] != '-') {
                          return Image.network(
                            snapshot.data.docs[index]['ownerPhotoUrl'],
                          );
                        } else {
                          return Image.asset('images/guest-user.jpg');
                        }
                      }()),
                    ),
                  ),
                );
              },
            );
          }
          return const Text('No Notifications');
        },
      ),
    );
  }
}
