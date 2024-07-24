import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String pageName;

  const NavBar({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          pageName,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'UrbanistBold',
            color: Colors.black,
          ),
        ),
        Spacer(),
        Icon(
          Icons.more_horiz_rounded,
          color: Colors.black,
          size: 30,
        ),
      ],
    );
  }
}
