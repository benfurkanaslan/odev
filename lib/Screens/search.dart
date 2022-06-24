import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odev/home.dart';
import '../main.dart';
import '../util/user.dart';
import '/Screens/feed.dart';
import '/Screens/notifications.dart';
import '/Screens/profile.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

TextEditingController _searchController = TextEditingController();
String? kelime;
String? searchWord;
bool? isFollowing;

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                width: width,
                color: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.8,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) {
                            kelime = val;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            labelText: 'What Do You Want to Search For?',
                            hintStyle: TextStyle(color: Colors.white24),
                            floatingLabelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.1,
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.search),
                          onPressed: () async {
                            setState(() {
                              searchWord = kelime;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              searchWord != null
                  ? FutureBuilder(
                      future: firestore
                          .collection('users')
                          .where('userName',
                              isGreaterThanOrEqualTo: searchWord!.toLowerCase())
                          .where('userName',
                              isLessThan: '${searchWord!.toLowerCase()}z')
                          .get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    DocumentSnapshot doc = await firestore
                                        .collection('users')
                                        .doc(snapshot.data.docs[index]
                                            ['userUid'])
                                        .get();
                                        debugPrint(doc['userEmail']);
                                    AppUser appUser2 = AppUser(
                                      userEmail: doc['userEmail'],
                                      username: doc['userName'],
                                      userUid: doc['userUid'],
                                      followerCount: doc['followerCount'],
                                      followingCount: doc['followingCount'],
                                      postCount: doc['postCount'],
                                      emailVerified: doc['emailVerified'],
                                      userPhotoUrl: doc['userPhotoUrl'],
                                      bioText: doc['bioText'],
                                      isPrivate: doc['isPrivate'],
                                    );
                                    if (mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Profile(appUser2: appUser2),
                                          ));
                                    }
                                  },
                                  child: ListTile(
                                    tileColor: Colors.black12,
                                    // leading: OutlinedButton(
                                    //   onPressed: () async {
                                    //     DocumentSnapshot doc = await firestore
                                    //         .collection('followings')
                                    //         .doc(appUser!.userUid)
                                    //         .collection('following')
                                    //         .doc(snapshot.data.docs[index]
                                    //             ['userUid'])
                                    //         .get();
                                    //     if (mounted) {
                                    //       setState(() {
                                    //         isFollowing = doc.exists;
                                    //       });
                                    //     }
                                    //     if (!isFollowing!) {
                                    //       firestore
                                    //           .collection('followers')
                                    //           .doc(snapshot.data.docs[index]
                                    //               ['userUid'])
                                    //           .collection('follower')
                                    //           .doc(appUser!.userUid)
                                    //           .set({
                                    //             'stillFollowing': true,
                                    //           });
                                    //       firestore
                                    //           .collection('followings')
                                    //           .doc(appUser!.userUid)
                                    //           .collection('following')
                                    //           .doc(snapshot.data.docs[index]
                                    //               ['userUid'])
                                    //           .set({
                                    //             'stillFollowing': true,
                                    //           });
                                    //       firestore
                                    //           .collection('notifications')
                                    //           .doc(snapshot.data.docs[index]
                                    //               ['userUid'])
                                    //           .collection('following')
                                    //           .doc()
                                    //           .set({
                                    //         'type': 'follow',
                                    //         'ownerID': appUser!.userUid,
                                    //         'ownerUsername': appUser!.username,
                                    //         'ownerPhotoUrl':
                                    //             appUser!.userPhotoUrl,
                                    //         'time': DateTime.now(),
                                    //       });
                                    //       firestore
                                    //           .collection('users')
                                    //           .doc(appUser!.userUid)
                                    //           .update({
                                    //         'followerCount':
                                    //             FieldValue.increment(1),
                                    //       });
                                    //     } else {
                                    //       Fluttertoast.showToast(
                                    //           msg:
                                    //               'You are following this user');
                                    //     }
                                    //     // (() {
                                    //     //   if (isFollowing == false) {
                                    //     //     firestore
                                    //     //         .collection('followers')
                                    //     //         .doc(appUser!.userUid)
                                    //     //         .collection('follower')
                                    //     //         .doc(snapshot.data.docs[index]
                                    //     //             ['userUid'])
                                    //     //         .set({});
                                    //     //     firestore
                                    //     //         .collection('followings')
                                    //     //         .doc(appUser!.userUid)
                                    //     //         .collection('following')
                                    //     //         .doc(snapshot.data.docs[index]
                                    //     //             ['userUid'])
                                    //     //         .set({});
                                    //     //     firestore
                                    //     //         .collection('notifications')
                                    //     //         .doc(appUser!.userUid)
                                    //     //         .collection('following')
                                    //     //         .doc(snapshot.data.docs[index]
                                    //     //             ['userUid'])
                                    //     //         .set({
                                    //     //       'type': 'follow',
                                    //     //       'ownerID': snapshot.data.docs[index]
                                    //     //           ['userUid'],
                                    //     //       'ownerUsername': snapshot
                                    //     //           .data.docs[index]['userName'],
                                    //     //       'time': DateTime.now(),
                                    //     //     });
                                    //     //     firestore
                                    //     //         .collection('users')
                                    //     //         .doc(appUser!.userUid)
                                    //     //         .update({
                                    //     //       'followerCount':
                                    //     //           FieldValue.increment(1),
                                    //     //     });
                                    //     //   }
                                    //     // }());
                                    //   },
                                    //   child: (() {
                                    //     if (isFollowing == null) {
                                    //       return const SizedBox(
                                    //           width: 0, height: 0);
                                    //     } else if (isFollowing == true) {
                                    //       return const Text('Following');
                                    //     } else {
                                    //       return const Text('Follow');
                                    //     }
                                    //   }()),
                                    // ),
                                    title: Text(
                                      snapshot.data.docs[index]['userName'],
                                    ),
                                    trailing: Text(
                                      '${snapshot.data.docs[index]['followerCount']} user following',
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        } else {
                          return const Text('HERE');
                        }
                      },
                    )
                  : Container(),
              // FutureBuilder(
              //   future: firestore
              //       .collection('users')
              //       .where('meyve-sebze-adi', isEqualTo: 'asdasd')
              //       .get(),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     return Card(
              //       child: Text('${snapshot.data()['kilo-fiyati']}'),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomSearch extends SearchDelegate{
//   List<String> searchTerms = [];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return[
//       IconButton(onPressed: () {
//         query = '';
//       },
//           icon: Icon(Icons.clear)
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(onPressed: () {
//       close(context, null);
//     },
//         icon: Icon(Icons.arrow_back)
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for(var name in searchTerms) {
//       if(name.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(name);
//       }
//     }
//     return ListView.builder(itemCount: matchQuery.length,
//     itemBuilder: (context, index) {
//       var result = matchQuery[index];
//       return ListTile(
//         title: Text(result),
//       );
//     },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for(var name in searchTerms) {
//       if(name.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(name);
//       }
//     }
//     return ListView.builder(itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }

