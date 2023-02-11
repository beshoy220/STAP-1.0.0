import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
    debugPrint(value.toString());
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

// FOREGROUND MESSAGE (NEED TO HANDLE IN locl_notification PACKAGE)
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

// BACKGROUND MESSAGE
background() {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic('checkUp');
    // await FirebaseMessaging.instance.subscribeToTopic('topic');
    // FirebaseMessaging.instance.sendMessage(to: , data: );
    debugPrint("Handling a background message: ${message.messageId}");
  }
}

// Future<bool> sendFcmMessage(String title, String message) async {
//   try {
//     var url = 'https://fcm.googleapis.com/fcm/send';
//     var header = {
//       "Content-Type": "application/json",
//       "Authorization": "key=your_server_key",
//     };
//     var request = {
//       "notification": {
//         "title": title,
//         "text": message,
//         "sound": "default",
//         "color": "#990000",
//       },
//       "priority": "high",
//       "to": "/topics/all",
//     };

//     var client = Client();
//     var response = await client.post(url as Uri,
//         headers: header, body: json.encode(request));
//     return true;
//   } catch (e, s) {
//     print(e);
//     return false;
//   }
// }

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
