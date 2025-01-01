// ignore_for_file: use_super_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';
import 'package:insta_clone/Services/Chat/chat_services.dart';
import 'package:insta_clone/Services/PushNotification/sendPushMessage.dart';
import 'package:insta_clone/Screens/Chat/chat_cubit.dart' as chatcubit;

import '../../../Services/PushNotification/PushNotificationService .dart';

class ChatboxScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatboxScreen({
    Key? key,
    required this.receiverEmail,
    required this.receiverID,
  }) : super(key: key);

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  ChatServices chatServices = ChatServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController sendmessageController = TextEditingController();

  void sendMessage(String msg) async {
    await chatServices.sendMessage(
      widget.receiverID,
      msg,
    );
    final token =
        await PushNotificationService().getTokenForUID(widget.receiverID);
    if (token != null && token.isNotEmpty) {
      await sendPushMessage(
        body: msg,
        recipientToken: token,
        title: 'Message from ${widget.receiverEmail}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<chatcubit.ChatCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavBar(
        pageName: widget.receiverEmail,
      ),
      body: BlocConsumer<chatcubit.ChatCubit, chatcubit.ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(child: _buildMessageList(cubit)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageList(cubit) {
    String senderID = _auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: cubit.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong!",
              style: TextStyle(color: Colors.red[400]),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }

        final messages = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return types.TextMessage(
            author: types.User(id: data['senderID']),
            id: doc.id,
            text: data['message'],
            createdAt: (data['timestamp'] as Timestamp).millisecondsSinceEpoch,
          );
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Chat(
            messages: messages,
            onSendPressed: (types.PartialText message) {
              if (message.text.isNotEmpty) {
                sendMessage(message.text);
              }
            },
            user: types.User(id: senderID),
            theme: DefaultChatTheme(
              inputBackgroundColor: Colors.blue.shade100,
              inputTextColor: const Color.fromRGBO(0, 0, 0, 0.867),
              inputTextStyle: const TextStyle(fontSize: 16),
              messageInsetsVertical: 8,
              messageInsetsHorizontal: 16,
              messageBorderRadius: 16,
              primaryColor: const Color(0xFF007AFF),
              secondaryColor: const Color(0xFFEFEFEF),
              receivedMessageBodyTextStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              sentMessageBodyTextStyle: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            inputOptions: const InputOptions(
              usesSafeArea: true,
              sendButtonVisibilityMode: SendButtonVisibilityMode.editing,
            ),
          ),
        );
      },
    );
  }
}
