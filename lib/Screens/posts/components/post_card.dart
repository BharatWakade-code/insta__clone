import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 5,
              offset: Offset(0, 5), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: [
            // Image Section with Cover Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 220,
                  ),
                  Image.network(
                    snap['posturl'],
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image has finished loading
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                            color: Colors.black,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            // User Information Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Profile Image
                  ClipOval(
                    child: Image.network(
                      snap['profimage'] ,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Username, Location, and Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap['username'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Nagpur",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeago.format(
                          DateTime.parse(snap['datepublished']).toLocal(),
                        ),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Icons (Like and Bookmark)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 22,
                        ),
                        onPressed: () {
                          // Handle like action
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: Colors.black,
                          size: 22,
                        ),
                        onPressed: () {
                          // Handle bookmark action
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment_outlined,
                          color: Colors.grey[600],
                          size: 22,
                        ),
                        onPressed: () {
                          // Handle comment action
                        },
                      ),
                      const SizedBox(width: 8),
                      // Share Icon
                      IconButton(
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.grey[600],
                          size: 22,
                        ),
                        onPressed: () {
                          // Handle share action
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
