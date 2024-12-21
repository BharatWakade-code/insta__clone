import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/components/ChatboxScreen.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserListTile extends StatefulWidget {
  final DocumentSnapshot snap;

  const UserListTile({super.key, required this.snap});

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap.data() as Map<String, dynamic>;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatboxScreen(
                    receiverEmail: snap['username'],
                    receiverID: snap['uid'],
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    snap['photoUrl'],
                  ),
                  radius: 30,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snap['username'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'UrbanistRegular',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hii ..Sisko',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                        fontFamily: 'UrbanistRegular',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
