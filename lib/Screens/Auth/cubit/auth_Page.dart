import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Screens/Auth/cubit/auth_cubit.dart';
import 'package:insta_clone/Screens/Chat/users_chat_screen.dart';
import 'package:insta_clone/Screens/Heroes/superheroscreen.dart';
import 'package:insta_clone/Screens/home/home_screen.dart';
import 'package:insta_clone/Screens/login_signup_toggle.dart';
import 'package:insta_clone/Screens/posts/addpost.dart';
import 'package:insta_clone/Screens/profile/create_profile.dart';
import '../../../Services/PushNotification/PushNotificationService .dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PushNotificationService().uploadFCMToken();
            return const BottomNavBar();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Define the screens list explicitly as List<Widget>
  List<Widget> screens = [
    const SuperHeroScreen(),
    UserChatScreen(),
    const HomePage(),
    // AddPostScreen(),
    const CreateProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    String appBarTitle;

    switch (_selectedIndex) {
      case 0:
        appBarTitle = 'Superheroes';
        break;
      case 1:
        appBarTitle = 'Messages';
        break;
      case 2:
        appBarTitle = 'Posts';
        break;
      case 3:
        appBarTitle = 'Profile';
        break;
      default:
        appBarTitle = 'Home';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'UrbanistBold',
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.chat_sharp,
                  text: 'Chat',
                ),
                GButton(
                  icon: Icons.post_add_sharp,
                  text: 'Posts',
                ),
                GButton(
                  icon: Icons.person_2,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: screens[_selectedIndex],
    );
  }
}
