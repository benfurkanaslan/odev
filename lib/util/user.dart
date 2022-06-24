import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String username;
  final String userEmail;
  final String userUid;
  final String userPhotoUrl;
  final String bioText;
  final bool emailVerified;
  final bool isPrivate;
  final int followerCount;
  final int followingCount;
  final int postCount;

  AppUser({
    required this.isPrivate,
    required this.bioText,
    required this.followingCount,
    required this.userPhotoUrl,
    required this.emailVerified,
    required this.followerCount,
    required this.userEmail,
    required this.username,
    required this.userUid,
    required this.postCount,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      username: doc['userName'],
      emailVerified: doc['emailVerified'],
      userPhotoUrl: doc['userPhotoUrl'],
      userEmail: doc['userEmail'],
      userUid: doc['userUid'],
      followerCount: doc['followerCount'],
      followingCount: doc['followingCount'],
      postCount: doc['postCount'],
      bioText: doc['bioText'],
      isPrivate: doc['isPrivate'],
    );
  }
}
