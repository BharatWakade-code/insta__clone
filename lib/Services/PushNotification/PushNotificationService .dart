import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// Background message handler should be a top-level function
Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class PushNotificationService {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final currentuser = FirebaseAuth.instance.currentUser;

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission Not Granted';
    }
  }

  Future<void> initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showNotification(message);
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await fcm.getToken();
    print('Token: $token');
    return token;
  }

  Future<void> uploadFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print('Get Token $token');
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
        print('On Refresh Token $token');
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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Ensure the icon is a PNG and placed correctly in drawable folder
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Change this line
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

    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Unique ID for each notification
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        notificationId,
        message.notification?.title ?? 'No Title', // Null check
        message.notification?.body ?? 'No Body',   // Null check
        notificationDetails,
        payload: 'not Present');
  }
}
