import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/components/SelfMessage.dart';
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';

import '../../../Services/Chat/chat_services.dart';

class ChatboxScreen extends StatefulWidget {
  final Map<String, dynamic> snap;
  ChatboxScreen({super.key, required this.snap});

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  TextEditingController sendMessageController = TextEditingController();
  ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    var snap = widget.snap as Map<String, dynamic>;
    void sendMessage() async {
      if (sendMessageController.text.isNotEmpty) {
        await _chatServices.sendMessage(
            snap['username'], sendMessageController.text);
        print("Done");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
              Spacer(),
              TextField(
                controller: sendMessageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: sendMessage,
                    child: Icon(
                      Icons.send,
                    ),
                  ),
                  hintText: 'Message',
                  helperStyle: TextStyle(
                    fontFamily: 'UrbanistBold',
                  ),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
