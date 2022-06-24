import 'package:flutter/material.dart';

class Post {
  String text;
  int comments;
  int likes;
  String date;

  Post({ //constructor
    required this.text,
    required this.comments,
    required this.likes,
    required this.date,
  });
}