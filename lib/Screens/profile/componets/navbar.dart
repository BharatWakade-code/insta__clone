import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileNavbar extends StatefulWidget {
  const ProfileNavbar({super.key});

  @override
  State<ProfileNavbar> createState() => _ProfileNavbarState();
}

class _ProfileNavbarState extends State<ProfileNavbar> {
  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    // userProvider.refreshUser();
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.person_add_alt_1_outlined,
                color: Colors.black,
                size: 30,
              ),
              Spacer(),
              Text(
                "@Sisko",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'UrbanistBold',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.black,
                size: 20,
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
