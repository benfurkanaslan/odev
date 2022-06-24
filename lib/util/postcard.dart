import 'package:flutter/material.dart';
import '/util/objects.dart';



class PostCard extends StatelessWidget { //delete i falan biz veriyoruz isim olarak
  final Post post; //it's final because the post object that we created is not going to change
  final VoidCallback delete; //voidcallfunction does not require parameters
  final VoidCallback incrementLikes; //voidcallback bağlantıyı sağlıyor

  const PostCard({Key? key, required this.post, required this.delete, required this.incrementLikes,}) : super(key: key); //constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8), //margin is space between our object and inner and outer objects
      child: Padding( //padding sayesinde text will not touch the its border
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              post.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end, //end because everything should be right hand side
              children: [
                Text(
                  post.date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Spacer(), //flexi koymamışsak put maximum amount of space between the objects that arasında olduğu

                TextButton.icon(
                  onPressed: incrementLikes,
                  icon: const Icon(
                    Icons.thumb_up,
                    size: 14,
                    color: Colors.green,
                  ),
                  label: Text(
                    post.likes.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),



                const SizedBox(width: 8),

                const Icon(
                  Icons.comment,
                  size: 14,
                  color: Colors.blue,
                ),
                Text(
                  post.comments.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  iconSize: 14,
                  onPressed: delete,
                  icon: const Icon(Icons.delete, size: 14, color: Colors.red,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
