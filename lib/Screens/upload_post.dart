import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odev/home.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  State<UploadPost> createState() => _UploadPostState();
}

PlatformFile? pickedFile;
UploadTask? uploadTask;
bool isUploading = false;
TextEditingController _postTextController = TextEditingController();
String postId = const Uuid().v4();
VideoPlayerController? videoPlayerController;

class _UploadPostState extends State<UploadPost> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Post')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SizedBox(width: width),
              SizedBox(
                width: width * 0.9,
                child: TextField(
                  controller: _postTextController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    prefixIcon:
                        Icon(CupertinoIcons.bubble_left, color: Colors.grey),
                    labelText: 'Post Text',
                    floatingLabelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              pickedFile == null
                  ? OutlinedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                            type: FileType.video, allowMultiple: false);
                        if (mounted) {
                          pickedFile = result!.files.single;
                        }
                        final file = File(pickedFile!.path!);
                        videoPlayerController =
                            VideoPlayerController.file(file);
                        if (mounted) {
                          setState(() {
                            pickedFile = result!.files.single;
                          });
                        }
                      },
                      child: const Text('Video Seç'),
                    )
                  : SizedBox(
                      width: 16*15,
                      height: 9*15,
                      child: VideoPlayer(videoPlayerController!
                        ..addListener(() {})
                        ..setLooping(true)
                        ..initialize()
                            .then((value) => videoPlayerController!.play())),
                    ),
              const SizedBox(height: 20),
              isUploading
                  ? SizedBox(
                      width: width * 0.4,
                      child: const SizedBox(
                        height: 41,
                        width: 20,
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () async {
                        setState(() {
                          isUploading = true;
                        });
                        final path = pickedFile!.path.toString();
                        final file = File(pickedFile!.path!);
                        uploadTask = storageRef.child(path).putFile(file);
                        final snapshot =
                            await uploadTask!.whenComplete(() => null);
                        final url = await snapshot.ref.getDownloadURL();
                        firestore
                            .collection('posts')
                            .doc(user1!.uid)
                            .collection('userPosts')
                            .doc(postId)
                            .set({
                          'post-text': _postTextController.text,
                          'username': appUser!.username,
                          'postID': postId,
                          'likeCount': 0,
                          'uploaderUID': user1!.uid,
                          'videoUrl': url,
                          'time': DateTime.now(),
                        });
                        firestore
                            .collection('users')
                            .doc(user1!.uid)
                            .update({
                          'postCount': FieldValue.increment(1),
                        });
                        firestore
                            .collection('users')
                            .doc(user1!.uid)
                            .collection('posts')
                            .doc(postId)
                            .set({
                          'post-text': _postTextController.text,
                          'likeCount': 0,
                          'username': appUser!.username,
                          'postID': postId,
                          'uploaderUID': user1!.uid,
                          'videoUrl': url,
                          'time': DateTime.now(),
                        });
                        firestore
                            .collection('timelines')
                            .doc(user1!.uid)
                            .collection('posts')
                            .doc(postId)
                            .set({
                          'post-text': _postTextController.text,
                          'likeCount': 0,
                          'username': appUser!.username,
                          'postID': postId,
                          'uploaderUID': user1!.uid,
                          'videoUrl': url,
                          'time': DateTime.now(),
                        });
                        if (mounted) {
                          setState(() {
                            isUploading = false;
                            _postTextController.clear();
                            videoPlayerController!.dispose();
                            pickedFile == null;
                            postId = const Uuid().v4();
                          });
                        }
                      },
                      child: const Text('Yükle'),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: videoPlayerController != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  videoPlayerController!.value.isPlaying
                      ? videoPlayerController!.pause()
                      : videoPlayerController!.play();
                });
              },
              child: Icon(
                videoPlayerController!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
