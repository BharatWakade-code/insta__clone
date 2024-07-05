import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Auth/auth_Page.dart';
import 'package:insta_clone/Responsive/mobile_screen_layout.dart';
import 'package:insta_clone/Responsive/responsive_layout.dart';
import 'package:insta_clone/Responsive/web_screen_layout.dart';
import 'package:insta_clone/firebase_options.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const AuthPage(),
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileLayout(),
        //   webScreenLayout: WebLayout(),
        // ),
      ),
    );
  }
}
