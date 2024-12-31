// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Services/Auth/auth_services.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:meta/meta.dart';

part 'addpost_state.dart';

class AddpostCubit extends Cubit<AddpostState> {
  AddpostCubit() : super(AddpostInitial());

  Uint8List? file;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void clearImage() {
    file = null;
  }

  void postImage(String description) async {
    try {
      emit(Addpostloading());
      final currentUser = await AuthSevices().getUserDetails();
      print('Current deatils $currentUser');
      String res = await FirebaseMethods().uploadPost(description, file!,
          currentUser.uid, currentUser.username, currentUser.photoUrl);
      if (res == "success") {
        emit(Addpostloaded());
        clearImage();
      } else {
        emit(AddpostError());
        clearImage();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void pickimage() async {
    Uint8List pickedfile = await pickImage(ImageSource.gallery);
    file = pickedfile;
    emit(Imageloaded());
  }

  void captureimage() async {
    Uint8List pickedfile = await pickImage(ImageSource.camera);
    file = pickedfile;
    emit(Imageloaded());
  }
}
