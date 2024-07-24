import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/components/MessagesList.dart';
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';
import 'package:insta_clone/Screens/Chat/components/search.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(
                pageName: 'Messages',
              ),
              SizedBox(
                height: 24,
              ),
              Search(),
              SizedBox(
                height: 24,
              ),
              MessagesList(),
            ],
          ),
        ),
      ),
    );
  }
}
