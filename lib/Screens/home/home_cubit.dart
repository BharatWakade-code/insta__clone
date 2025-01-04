// ignore_for_file: empty_catches

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/Services/Auth/auth_services.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentUserUid = '';
  bool isLikeAnimating = false;

  Future<void> fetchUserDetails() async {
    try {
      final currentUser = await AuthSevices().getUserDetails();
      currentUserUid = currentUser.uid;
    } catch (e) {}
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFeedList() {
    final feed = _firestore
        .collection('posts')
        .orderBy("datepublished", descending: true)
        .snapshots();

    return feed;
  }

  Future<void> likePost(String postid, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }

  void togglelikebtn() {
    isLikeAnimating = !isLikeAnimating;
    // emit(IsLiked(isLiked: isLikeAnimating));
  }
}
