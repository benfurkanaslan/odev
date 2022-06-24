import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odev/Screens/post_detail.dart';
import 'package:odev/Screens/upload_post.dart';
import 'package:odev/home.dart';
import 'package:odev/main.dart';
import 'package:odev/util/post_model.dart';
import '../util/user.dart';
import '/Screens/profile_edit.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  AppUser? appUser2;
  Profile({Key? key, required this.appUser2}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

PostModel? postModel;
bool? isFollowing;
bool x = false;

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    asyncProcess();
    debugPrint(
        '${firestore.collection('users').doc(widget.appUser2!.userUid).get()}');
  }

  asyncProcess() async {
    DocumentSnapshot doc = await firestore
        .collection('followings')
        .doc(appUser!.userUid)
        .collection('following')
        .doc(widget.appUser2!.userUid)
        .get();

    if (!doc.exists) {
      isFollowing = false;
    } else {
      isFollowing = doc['stillFollowing'];
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFollowing == null) {
      return const Center(child: CupertinoActivityIndicator());
    } else {
      return buildPage(context);
    }
  }

  Scaffold buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appUser2!.username,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          (() {
            if (appUser!.userUid == widget.appUser2!.userUid) {
              return CupertinoSwitch(
                onChanged: (bool value) {
                  firestore.collection('users').doc(appUser!.userUid).update({
                    'isPrivate': value,
                  });
                  setState(() {
                    x = value;
                  });
                },
                value: x,
              );
            } else {
              return Container();
            }
          }()),
          (() {
            if (appUser!.userUid == widget.appUser2!.userUid) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfile(appUser2: widget.appUser2)));
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              );
            } else {
              return Container();
            }
          }()),
        ],
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (() {
                      if (widget.appUser2!.userPhotoUrl == '-') {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('images/guest-user.jpg'),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(widget.appUser2!.userPhotoUrl),
                              ),
                            ),
                          ),
                        );
                      }
                    }()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '${widget.appUser2!.postCount}',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Text(
                          'Movies',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '${widget.appUser2!.followerCount}',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Text(
                          'Followers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '${widget.appUser2!.followingCount}',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Text(
                          'Following',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                Text(widget.appUser2!.bioText),
                (() {
                  if (appUser!.userUid == widget.appUser2!.userUid) {
                    return OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UploadPost(),
                            ));
                      },
                      child: const Text('Upload Post'),
                    );
                  } else {
                    return OutlinedButton(
                      onPressed: () async {
                        if (isFollowing!) {
                          firestore
                              .collection('followers')
                              .doc(widget.appUser2!.userUid)
                              .collection('follower')
                              .doc(appUser!.userUid)
                              .delete();
                          firestore
                              .collection('followings')
                              .doc(appUser!.userUid)
                              .collection('following')
                              .doc(widget.appUser2!.userUid)
                              .set({'stillFollowing': false});
                          firestore
                              .collection('notifications')
                              .doc(widget.appUser2!.userUid)
                              .collection('following')
                              .doc()
                              .delete();
                          firestore
                              .collection('users')
                              .doc(appUser!.userUid)
                              .update({
                            'followingCount': FieldValue.increment(-1),
                          });
                          firestore
                              .collection('users')
                              .doc(widget.appUser2!.userUid)
                              .update({
                            'followerCount': FieldValue.increment(-1),
                          });
                          firestore
                              .collection('notifications')
                              .doc(widget.appUser2!.userUid)
                              .collection('following')
                              .doc()
                              .delete();
                        } else {
                          firestore
                              .collection('followers')
                              .doc(widget.appUser2!.userUid)
                              .collection('follower')
                              .doc(appUser!.userUid)
                              .set({});
                          firestore
                              .collection('followings')
                              .doc(appUser!.userUid)
                              .collection('following')
                              .doc(widget.appUser2!.userUid)
                              .set({'stillFollowing': true});
                          firestore
                              .collection('notifications')
                              .doc(widget.appUser2!.userUid)
                              .collection('following')
                              .doc()
                              .set({
                            'type': 'follow',
                            'ownerID': appUser!.userUid,
                            'ownerUsername': appUser!.username,
                            'ownerPhotoUrl': appUser!.userPhotoUrl,
                            'time': DateTime.now(),
                          });
                          firestore
                              .collection('users')
                              .doc(appUser!.userUid)
                              .update({
                            'followingCount': FieldValue.increment(1),
                          });
                          firestore
                              .collection('users')
                              .doc(widget.appUser2!.userUid)
                              .update({
                            'followerCount': FieldValue.increment(1),
                          });
                        }
                      },
                      child: (() {
                        if (isFollowing == null) {
                          return const SizedBox(width: 0, height: 0);
                        } else if (isFollowing!) {
                          return const Text('Unfollow');
                        } else {
                          return const Text('Follow this user');
                        }
                      }()),
                    );
                  }
                }()),
                const Divider(
                  color: Colors.black,
                  thickness: 2.0,
                  height: 40,
                ),
                (() {
                  if (widget.appUser2!.userUid == appUser!.userUid) {
                    debugPrint('build1');
                    return buildPosts();
                  } else if (isFollowing!) {
                    return FutureBuilder(
                      future: firestore
                          .collection('followings')
                          .doc(appUser!.userUid)
                          .collection('following')
                          .doc(widget.appUser2!.userUid)
                          .get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data['stillFollowing']) {
                            debugPrint('build3');
                            return buildPosts();
                          } else {
                            return const Text('This account is private.');
                          }
                        } else {
                          return const CupertinoActivityIndicator();
                        }
                      },
                    );
                  } else {
                    debugPrint('build2');
                    if (!widget.appUser2!.isPrivate) {
                      return buildPosts();
                    }
                    return const Text('This account is private.');
                  }
                }()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildPosts() {
    return StreamBuilder(
      stream: firestore
          .collection('users')
          .doc(widget.appUser2!.userUid)
          .collection('posts')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              postModel = PostModel(
                postText: snapshot.data.docs[index]['post-text'],
                uploaderUID: snapshot.data.docs[index]['uploaderUID'],
                videoUrl: snapshot.data.docs[index]['videoUrl'],
                username: snapshot.data.docs[index]['username'],
                likeCount: snapshot.data.docs[index]['likeCount'],
                postID: snapshot.data.docs[index]['postID'],
              );
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostDetail(postModel: postModel!)));
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0,
                      8), //margin is space between our object and inner and outer objects
                  child: Padding(
                    //padding sayesinde text will not touch the its border
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          postModel!.username,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, //end because everything should be right hand side
                          children: [
                            Text(
                              postModel!.postText,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Spacer(), //flexi koymamışsak put maximum amount of space between the objects that arasında olduğu

                            TextButton.icon(
                              onPressed: () {
                                final DocumentReference docRef1 = firestore
                                    .collection('posts')
                                    .doc(widget.appUser2!.userUid)
                                    .collection('userPosts')
                                    .doc(postModel!.postID);
                                docRef1.update(
                                    {"likeCount": FieldValue.increment(1)});
                                final DocumentReference docRef2 = firestore
                                    .collection('users')
                                    .doc(widget.appUser2!.userUid)
                                    .collection('posts')
                                    .doc(snapshot.data.docs[index]['postID']);
                                docRef2.update(
                                    {"likeCount": FieldValue.increment(1)});
                              },
                              icon: const Icon(
                                Icons.thumb_up,
                                size: 14,
                                color: Colors.green,
                              ),
                              label: Text(
                                postModel!.likeCount.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            (() {
                              if (postModel!.uploaderUID == appUser!.userUid) {
                                return IconButton(
                                  iconSize: 14,
                                  onPressed: () async {
                                    await firestore
                                        .collection('posts')
                                        .doc(widget.appUser2!.userUid)
                                        .collection('userPosts')
                                        .doc(postModel!.postID)
                                        .delete();
                                    await firestore
                                        .collection('users')
                                        .doc(widget.appUser2!.userUid)
                                        .update({
                                      'postCount': FieldValue.increment(-1),
                                    });
                                    await firestore
                                        .collection('users')
                                        .doc(widget.appUser2!.userUid)
                                        .collection('posts')
                                        .doc(postModel!.postID)
                                        .delete();
                                    await firestore
                                        .collection('timelines')
                                        .doc(widget.appUser2!.userUid)
                                        .collection('posts')
                                        .doc(postModel!.postID)
                                        .delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}
