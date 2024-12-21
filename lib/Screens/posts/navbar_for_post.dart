import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/utils/utils.dart';

class Navbar_Home extends StatefulWidget {
  const Navbar_Home({super.key});

  @override
  State<Navbar_Home> createState() => _Navbar_HomeState();
}

class _Navbar_HomeState extends State<Navbar_Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 0, right: 20),
      child: Container(
          width: MediaQuery.sizeOf(context).width * 0.93,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.menu,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async => await pickImage(ImageSource.camera),
                child: Icon(
                  Icons.camera,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          )),
    );
  }
}
