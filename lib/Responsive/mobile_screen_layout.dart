import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/users_chat_screen.dart';
import 'package:insta_clone/Screens/home/home_screen.dart';
import 'package:insta_clone/Screens/home/posts/addpost.dart';
import 'package:insta_clone/Screens/profile/create_profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentindex = 0;
  List screens = [
    const HomePage(),
    UserChatScreen(),
    const AddPostScreen(),
    const Scaffold(),
    const CreateProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentindex = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromRGBO(53, 112, 236, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: const Color.fromRGBO(248, 250, 254, 1),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentindex = 0;
                });
              },
              icon: Icon(Icons.home_work_outlined,
                  size: 30,
                  color: currentindex == 0
                      ? const Color.fromRGBO(53, 112, 236, 1)
                      : Colors.grey[400]),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentindex = 1;
                });
              },
              icon: Icon(Icons.chat_bubble_outline_rounded,
                  size: 30,
                  color: currentindex == 1
                      ? const Color.fromRGBO(53, 112, 236, 1)
                      : Colors.grey[400]),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentindex = 3;
                });
              },
              icon: Icon(Icons.favorite_border,
                  size: 30,
                  color: currentindex == 3
                      ? const Color.fromRGBO(53, 112, 236, 1)
                      : Colors.grey[400]),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentindex = 4;
                });
              },
              icon: Icon(Icons.person,
                  size: 30,
                  color: currentindex == 4
                      ? const Color.fromRGBO(53, 112, 236, 1)
                      : Colors.grey[400]),
            ),
          ],
        ),
      ),
      body: screens[currentindex],
    );
  }
}
