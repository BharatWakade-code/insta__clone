import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profimage,
  ) async {
    String res = "Some Error Occoured";
    try {
      String PhotoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      String postid = Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postid: postid,
          datepublished: DateTime.now().toString(),
          posturl: PhotoUrl,
          profimage: profimage,
          likes: []);

      _firestore.collection('posts').doc(postid).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
