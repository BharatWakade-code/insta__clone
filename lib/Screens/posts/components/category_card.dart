import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final DocumentSnapshot snap;

  const CategoryCard({super.key, required this.snap});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap.data() as Map<String, dynamic>;

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(89, 141, 250, 1),
              Color.fromRGBO(218, 89, 250, 1),
            ]),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2),
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              snap['photoUrl'],
            ),
            radius: 34,
          ),
        ),
      ],
    );
  }
}
