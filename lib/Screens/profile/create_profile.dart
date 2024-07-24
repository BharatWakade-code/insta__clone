import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/profile/componets/CirccularandName.dart';
import 'package:insta_clone/Screens/profile/componets/navbar.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              ProfileNavbar(),
              CirccularandName(),
            ],
          ),
        ),
      ),
    );
  }
}
