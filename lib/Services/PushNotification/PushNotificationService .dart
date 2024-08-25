// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// Background message handler should be a top-level function
Future<void> backgroundHandler(RemoteMessage message) async {}

class PushNotificationService {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final currentuser = FirebaseAuth.instance.currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission Not Granted';
    }
  }

  Future<void> initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await fcm.getToken();
    return token;
  }

  Future<void> uploadFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await firebaseFirestore
            .collection("DeviceToken")
            .doc(currentuser!.uid)
            .set({
          'notificationtoken': token,
          'currentemail': currentuser!.email
        });
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
        await firebaseFirestore
            .collection("DeviceToken")
            .doc(currentuser!.uid)
            .set({
          'notificationtoken': token,
          'currentemail': currentuser!.email
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> getTokenForUID(String currentUserID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseFirestore
              .collection("DeviceToken")
              .doc(currentUserID)
              .get();

      if (documentSnapshot.exists) {
        String? token = documentSnapshot.data()?['notificationtoken'];
        print(token);
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Ensure the icon is a PNG and placed correctly in drawable folder
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Change this line
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(RemoteMessage message) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: '',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notificationId = DateTime.now().millisecondsSinceEpoch ~/
        1000; // Unique ID for each notification
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        notificationId,
        message.notification?.title ?? 'No Title', // Null check
        message.notification?.body ?? 'No Body', // Null check
        notificationDetails,
        payload: 'not Present');
  }
}
