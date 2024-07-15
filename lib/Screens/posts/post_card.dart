import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(242, 242, 242, 1),
        border: Border.all(color: Colors.white38),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    snap['profimage'],
                  ),
                  radius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snap['username'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Omkar Nagar, Nagpur',
                      style: TextStyle(
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.more_vert,
                  size: 30,
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Image(
              height: 180,
              width: MediaQuery.of(context).size.width,
              image: NetworkImage(snap['posturl']),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Stack(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 15,
                      width: 15,
                      child: const Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 251, 14, 109),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.share_location_sharp,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
