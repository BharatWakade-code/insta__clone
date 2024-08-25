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
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          pageName,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'UrbanistBold',
            color: Colors.black,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.more_horiz_rounded,
          color: Colors.black,
          size: 30,
        ),
      ],
    );
  }
}
