import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Responsive/mobile_screen_layout.dart';
import 'package:insta_clone/Screens/login_signup_toggle.dart';

import '../PushNotification/PushNotificationService .dart';

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
            return BottomNavBar();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
