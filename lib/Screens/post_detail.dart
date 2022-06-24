import 'package:flutter/material.dart';
import 'package:odev/Screens/profile.dart';
import 'package:odev/util/post_model.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class PostDetail extends StatefulWidget {
  PostModel postModel;
  PostDetail({Key? key, required this.postModel}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  VideoPlayerController? videoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
      postModel!.videoUrl,
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: videoPlayerController!.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(videoPlayerController!),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
