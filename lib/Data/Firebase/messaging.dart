import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// Future<void> messageHandler(RemoteMessage message) async {
//   Data notificationMessage = Data.fromJson(message.data);
//   print('notification from background : ${notificationMessage.title}');
// }

// void firebaseMessagingListener() {
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     Data notificationMessage = Data.fromJson(message.data);
//     print('notification from foreground : ${notificationMessage.title}');
//   });
// }

// class Data {
//   String? title;
//   String? message;

//   Data({this.title, this.message});

//   Data.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     message = json['message'];
//   }
// }

// Future<void> sendNotification() async {
//   const postUrl = 'https://fcm.googleapis.com/fcm/send';
//   Dio dio = Dio();

//   var token = await getDeviceToken();
//   print('device token : $token');

//   final data = {
//     "data": {
//       "message": "Accept Ride Request",
//       "title": "This is Ride Request",
//     },
//     "to": token
//   };

//   dio.options.headers['Content-Type'] = 'application/json';
//   dio.options.headers["Authorization"] =
//       'key=AAAAjnX0RmU:APA91bHMuUFlRcu2mmMbxy8H-VZj6yNO_4SYvrea_yHqy8f6sOIv0WgVtRqkJwJOYtjToo6OciN80hpuoqJ4ytxsAHVmzfSwzZClFfABi_vJrmomzNISB1_LS_lw01wxlSw6eL3lWwT7';

//   try {
//     final response = await dio.post(postUrl, data: data);

//     if (response.statusCode == 200) {
//       print('Request Sent To Driver');
//     } else {
//       print('notification sending failed');
//     }
//   } catch (e) {
//     print('exception $e');
//   }
// }

// Future<String?> getDeviceToken() async {
//   return await FirebaseMessaging.instance.getToken();
// }

/// FCM Documentaion code test
///
///
///
///
///
///
///
///
///
///
///
///
///

// Future<String> getToken() async {
//   final fcmToken = await FirebaseMessaging.instance.getToken().then((value) {
//     debugPrint(value.toString());
//   });
//   // return fcmToken;
//   FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
//     // ignore: todo
//     // TODO: If necessary send token to application server.

//     // Note: This callback is fired at each app startup and whenever a new
//     // token is generated.
//   }).onError((err) {
//     // Error getting token.
//   });
//   return fcmToken;
// }

requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  debugPrint('User granted permission: ${settings.authorizationStatus}');
}

foreground() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification!.body}');
    }
  });
}

background() {
  // @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    debugPrint("Handling a background message: ${message.messageId}");
  }
}
