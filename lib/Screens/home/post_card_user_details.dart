import 'package:flutter/material.dart';

class PostCardUserDetails extends StatefulWidget {
  const PostCardUserDetails({super.key});

  @override
  State<PostCardUserDetails> createState() => _PostCardUserDetailsState();
}

class _PostCardUserDetailsState extends State<PostCardUserDetails> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.jpeg',
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
                  Row(
                    children: [
                      Text(
                        "Bharat Wakade",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 81, 94, 1),
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Nagpur ",
                        style: TextStyle(
                            color: Color.fromRGBO(215, 189, 202, 1),
                            fontSize: 10),
                      ),
                      Text(
                        "1 hr Ago",
                        style: TextStyle(
                            color: Color.fromRGBO(215, 189, 202, 1),
                            fontSize: 8),
                      ),
                    ],
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
    );
  }
}
