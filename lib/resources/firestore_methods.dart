import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    String location,
    Uint8List file,
    String uid,
    String username,
    String profimage,
  ) async {
    String res = "Some Error Occoured";
    try {
      String photUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      String postid = const Uuid().v1();
      Post post = Post(
          description: description,
          location: location,
          uid: uid,
          username: username,
          postid: postid,
          datepublished: DateTime.now().toString(),
          posturl: photUrl,
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
