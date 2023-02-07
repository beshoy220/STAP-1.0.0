import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';

Future<void> messageHandler(RemoteMessage message) async {
  Data notificationMessage = Data.fromJson(message.data);
  print('notification from background : ${notificationMessage.title}');
}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Data notificationMessage = Data.fromJson(message.data);
    print('notification from foreground : ${notificationMessage.title}');
  });
}

class Data {
  String? title;
  String? message;

  Data({this.title, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }
}

Future<void> sendNotification() async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  Dio dio = Dio();

  var token = await getDeviceToken();
  print('device token : $token');

  final data = {
    "data": {
      "message": "Accept Ride Request",
      "title": "This is Ride Request",
    },
    "to": token
  };

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      'key=AAAAjnX0RmU:APA91bHMuUFlRcu2mmMbxy8H-VZj6yNO_4SYvrea_yHqy8f6sOIv0WgVtRqkJwJOYtjToo6OciN80hpuoqJ4ytxsAHVmzfSwzZClFfABi_vJrmomzNISB1_LS_lw01wxlSw6eL3lWwT7';

  try {
    final response = await dio.post(postUrl, data: data);

    if (response.statusCode == 200) {
      print('Request Sent To Driver');
    } else {
      print('notification sending failed');
    }
  } catch (e) {
    print('exception $e');
  }
}

Future<String?> getDeviceToken() async {
  return await FirebaseMessaging.instance.getToken();
}
