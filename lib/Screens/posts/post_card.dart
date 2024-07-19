import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class PostCard extends StatefulWidget {
  final DocumentSnapshot snap;
  PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap.data() as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 58, 176, 226),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              child: Image.asset(
                'assets/images/profile.jpeg', // Default image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
