import 'package:flutter/material.dart';
import '/util/objects.dart';
import '/util/postcard.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Post> posts = [
    Post(text: 'Username 4', date: 'March 5', likes: 10, comments: 0),
    Post(text: 'Username 3', date: 'March 4', likes: 0, comments: 5),
    Post(text: 'Username 2', date: 'March 3', likes: 28, comments: 100),
    Post(text: 'Username 1', date: 'March 2', likes: 20, comments: 10),
    Post(text: 'Username 1', date: 'March 1', likes: 20, comments: 10),
  ];

  void deletePost(Post post) {
    setState(() {
      posts.remove(post);
    });
  }

  void increaseLikes(Post post) {
    setState(() {
      post.likes++;
    });
  }

  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          'Movienator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              children: posts
                  .map((post) => PostCard(
                        post: post,
                        delete: () {
                          deletePost(post);
                        },
                        incrementLikes: () {
                          increaseLikes(post);
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
