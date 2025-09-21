import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/Services/Auth/auth_services.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  String profile = '';
  String username = '';
  String bio = '';
  String followers = '';
  String following = '';
  String email = '';
  String currentUid = '';
  String postlength = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserDetails() async {
    try {
      emit(Profileloading());
      final currentUser = await AuthSevices().getUserDetails();
      profile = currentUser.photoUrl;
      username = currentUser.username;
      bio = currentUser.bio;
      followers = currentUser.followers.toString();
      following = currentUser.following.toString();
      email = currentUser.email.toString();
      currentUid = currentUser.uid.toString();
      final querySnapshot = await _firestore
          .collection('posts')
          .where('uid', isEqualTo: currentUid)
          .get();
      postlength = querySnapshot.docs.length.toString();
      emit(Profileloaded());
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProfileList() {
    return _firestore
        .collection('posts')
        .where('uid', isEqualTo: currentUid)
        .snapshots();
  }
}
