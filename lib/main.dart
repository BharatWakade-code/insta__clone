// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Screens/Auth/cubit/auth_Page.dart';
import 'package:insta_clone/Screens/Auth/cubit/auth_cubit.dart';
import 'package:insta_clone/Screens/Chat/chat_cubit.dart';
import 'package:insta_clone/Screens/Heroes/cubit/superhero_cubit.dart';
import 'package:insta_clone/Screens/home/home_cubit.dart';
import 'package:insta_clone/Screens/profile/profile_cubit.dart';
import 'package:insta_clone/firebase_options.dart';
import 'Services/PushNotification/PushNotificationService .dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    PushNotificationService pushNotificationService = PushNotificationService();
    await pushNotificationService.requestPermission();
    await pushNotificationService.requestPermission();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    await pushNotificationService.init();
    await pushNotificationService.initialize();
  } catch (e) {
    print('Error initializing push notifications: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static bool? isUpload;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    notificationHandler();
  }

  void notificationHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (event.notification != null) {
        print(event.notification!.body);
        PushNotificationService().showNotification(event);
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        PushNotificationService().showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotificationService().showNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => SuperheroCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insta Clone',
        home: AuthPage(),
      ),
    );
  }
}
