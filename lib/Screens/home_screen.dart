import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: mobileBackgroundColor,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Insta LOGO
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_instagram.svg',
                    color: primaryColor,
                    height: 34,
                  ),
                  Spacer(),
                  Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
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
                ],
              ),
              SizedBox(
                height: 20,
              ),

              // ListView for profiles
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpeg',
                            ),
                            radius: 34,
                          ),
                          Positioned(
                            left: 47,
                            top: 45,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 300,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: CupertinoContextMenu.kEndBoxShadow,
                          color: Colors.white,
                          border: Border.all(color: Colors.white38)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.jpeg',
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
                                      'BharatWakade',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Omkar Nagar,Nagpur',
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.more_vert,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Image(
                              height: 170,
                              width: MediaQuery.sizeOf(context).width,
                              image: AssetImage(
                                'assets/images/profile.jpeg',
                              ),
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
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 251, 14, 109),
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
