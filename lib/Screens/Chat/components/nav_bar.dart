import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  const NavBar({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () => Navigator.of(context).pop(),
      //   icon: const Icon(
      //     Icons.arrow_back_rounded,
      //     color: Colors.black,
      //     size: 30,
      //   ),
      // ),
      title: Text(
        pageName,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'UrbanistBold',
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
