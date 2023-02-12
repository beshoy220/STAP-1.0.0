import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

// TOKEN
Future<String> getToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken().then((value) {
    return value.toString();
  });
  // return fcmToken;
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // ignore: todo
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
  return fcmToken;
}

// REQUEST PERMISSION FOR APPLE AND WEB
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

// FOREGROUND MESSAGE (NEED TO HANDLE IN flutter_local_notification PACKAGE)
foreground() {
  // var androidInitialize =
  //     const AndroidInitializationSettings('@mipmap/ic_launcher');
  // var iOSInitialize = const IOSInitializationSettings();
  // var initializationsSettings =
  //     InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin.initialize(initializationsSettings,
  //     onSelectNotification: (String? payload) async {
  //   try {
  //     if (payload != null && payload.isNotEmpty) {
  //     } else {}
  //   } catch (e) {}
  //   return;
  // });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification!.body}');
    }
  });
}

// BACKGROUND MESSAGE
background() {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getInitialMessage();
    await FirebaseMessaging.instance.subscribeToTopic('checkUp');
    debugPrint("Handling a background message: ${message.messageId}");
  }
}

sendFcmMessage(
    String to, String title, String message, String from, String time) async {
  try {
    var url = 'https://fcm.googleapis.com/fcm/send';
    var header = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAjnX0RmU:APA91bHMuUFlRcu2mmMbxy8H-VZj6yNO_4SYvrea_yHqy8f6sOIv0WgVtRqkJwJOYtjToo6OciN80hpuoqJ4ytxsAHVmzfSwzZClFfABi_vJrmomzNISB1_LS_lw01wxlSw6eL3lWwT7",
    };
    var request = {
      "notification": {
        "title": title,
        "body": "$message\n\n from : $from  \n time: $time",
        "sound": "default",
        "color": "#990000",
      },
      "priority": "high",
      "to": to,
    };
    var client = Client();
    var response = await client.post(Uri.parse(url),
        headers: header, body: json.encode(request));
    return true;
  } catch (e, s) {
    print(e.toString() + ' / ' + s.toString());
    return false;
  }
}

// TERMINATED MESSAGE
terminated() {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      // _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // void _handleMessage(RemoteMessage message) {
  //   if (message.data['type'] == 'chat') {
  //     Navigator.pushNamed(context, '/chat',
  //       arguments: ChatArguments(message),
  //     );
  //   }
  // }
}
