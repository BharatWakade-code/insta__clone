import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/components/SelfMessage.dart';
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';

class ChatboxScreen extends StatefulWidget {
  final Map<String, dynamic> snap;
  ChatboxScreen({super.key, required this.snap});

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(
                pageName: snap['username'],
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Container(
                  height: 24,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'UrbanistBold',
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              SelfMessages(),
            ],
          ),
        ),
      ),
    );
  }
}
