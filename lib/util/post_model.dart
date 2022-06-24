import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postText;
  final String uploaderUID;
  final String videoUrl;
  final String username;
  final String postID;
  final int likeCount;

  PostModel({
    required this.postText,
    required this.uploaderUID,
    required this.videoUrl,
    required this.username,
    required this.likeCount,
    required this.postID,
  });

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
      username: doc['userName'],
      uploaderUID: doc['uploaderUID'],
      videoUrl: doc['videoUrl'],
      postText: doc['postText'],
      likeCount: doc['likeCount'],
      postID: doc[doc.id],
    );
  }
}
