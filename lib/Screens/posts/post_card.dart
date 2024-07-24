import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/Screens/home/post_card_user_details.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatefulWidget {
  final DocumentSnapshot snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap.data() as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 230,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Image.network(
                snap['posturl'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 230,
            right: 0,
            left: 0,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            snap['profimage'],
                          ),
                          radius: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snap['username'],
                              style: TextStyle(
                                  color: Color.fromRGBO(106, 81, 94, 1),
                                  fontSize: 16),
                            ),
                            Text(
                              "Nagpur ",
                              style: TextStyle(
                                  color: Color.fromRGBO(215, 189, 202, 1),
                                  fontSize: 10),
                            ),
                            Text(
                              timeago.format(
                                  DateTime.parse(snap['datepublished'])
                                      .toLocal()
                                      .add(Duration(hours: 5, minutes: 30))),
                              style: TextStyle(
                                color: Color.fromRGBO(215, 189, 202, 1),
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                        Icon(
                          Icons.bookmark_outline,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
