import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/users_chat_screen.dart';
import 'package:insta_clone/Screens/Heroes/superheroscreen.dart';
import 'package:insta_clone/Screens/home/home_screen.dart';
import 'package:insta_clone/Screens/profile/create_profile.dart';
import 'package:insta_clone/Services/Auth/auth_services.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clone/models/User.dart' as model;
import 'package:insta_clone/resources/storage_methods.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int selectedIndex = 0;

  Future<void> fetchUserDetails() async {
    try {
      final currentUser = await AuthSevices().getUserDetails();
      emit(Userloaded(username: currentUser.username));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String PhotoUrl = await StorageMethod()
            .uploadImageToStorage('ProfilePics', file, false);

        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            photoUrl: PhotoUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []);
        //Add USer
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "Success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
