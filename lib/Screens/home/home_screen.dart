import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Screens/home/nav_bar_home.dart';
import 'package:insta_clone/Screens/posts/category_card.dart';
import 'package:insta_clone/Screens/posts/post_card.dart';
import 'package:insta_clone/utils/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Navbar
                const HomeNavbar(),
                // ListView for profiles
                SizedBox(
                  height: 100,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, int index) => CategoryCard(
                                snap: snapshot.data!.docs[index],
                              ));
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, int index) => PostCard(
                                snap: snapshot.data!.docs[index],
                              ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}