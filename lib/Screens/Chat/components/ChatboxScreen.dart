// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';

class ChatboxScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatboxScreen({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  ChatServices chatServices = ChatServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController sendmessageController = TextEditingController();
  final currentuser = FirebaseAuth.instance.currentUser;

  void sendMessage() async {
    if (sendmessageController.text.isNotEmpty) {
      await chatServices.sendMessage(
          widget.receiverID, sendmessageController.text);
      final token =
          await PushNotificationService().getTokenForUID(widget.receiverID);
      if (token != null && token.isNotEmpty) {
        await sendPushMessage(
          body: sendmessageController.text,
          recipientToken: token,
          title: 'Message from ${widget.receiverEmail.toString()}' ,
        );
      } else {
        print("Failed to get FCM token.");
      }
      sendmessageController.clear();
      print("Message Send Successful");
    }
  }

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
                pageName: widget.receiverEmail,
              ),
              const SizedBox(
                height: 15,
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
              const SizedBox(
                height: 15,
              ),
              SelfMessages(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _auth.currentUser!.uid;
    return StreamBuilder(
        stream: chatServices.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    var timestamp = timeago.format(data['timestamp'].toDate());
    bool isCurrentUser = data['senderID'] == _auth.currentUser!.uid;
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: isCurrentUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
            gradient: isCurrentUser
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(114, 16, 255, 1),
                      Color.fromRGBO(157, 89, 255, 1),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 77, 103, 1),
                      Color.fromRGBO(255, 131, 149, 1),
                    ],
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Wrap(children: [
                  Text(
                    data['message'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'UrbanistRegular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontFamily: 'UrbanistRegular',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
