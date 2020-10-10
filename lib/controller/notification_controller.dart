import 'dart:convert';
import 'dart:io';

import 'package:anony_chat/controller/hive_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationController {
  static const String FIREBASE_CLOUD_SERVER_TOKEN =
      'AAAAqVjdWRE:APA91bEftR1Ws3vkb3unv6HNnXQ5SQg0CMrN5AU3jCYMmI3EOiG_gga7tLapVQEkga5-_TWH-0Ndh6LLDO8ZoESs4RFMuh1nj_4jL-VldNqF6Wl4gNWeu3Vw2yX73u8xpf_HcWBp4zsk';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static NotificationController get instance => NotificationController();

  Future init() async {
    if (Platform.isIOS) {
      // set iOS Local notification.
      final initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );
      final initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } else {
      // set Android Local notification.
      final initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final initializationSettingsIOS = IOSInitializationSettings();
      final initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
  }

  Future takeFCMTokenWhenAppLaunch() async {
    try {
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(
            IosNotificationSettings(sound: true, badge: true, alert: true));
      }

      final userToken = HiveController.instance.getFCMToken();
      if (userToken == null) {
        _firebaseMessaging.getToken().then((val) async {
          print('Token: ' + val);
          HiveController.instance.setFCMToken(val);
        });
      }
    } catch (e) {
      print(e.message);
    }
  }

  /*
 sendLocalNotification(name, msg) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(0, name, msg, platformChannelSpecifics, payload: 'item x');
  }
 */

  Future<void> sendNotificationToPeerUser(
      unReadMSGCount, messageType, text, myID, peerUserToken) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$FIREBASE_CLOUD_SERVER_TOKEN',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': messageType == 'text' ? '$text' : '(사진)',
            'title': '$myID',
            'badge': '$unReadMSGCount',
            "sound": "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': peerUserToken,
        },
      ),
    );
  }
}
