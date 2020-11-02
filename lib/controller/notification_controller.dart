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

  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

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

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // 앱이 포그라운드 상태일 때 푸시 알림이 도착한 경우에 호출됨.
        // 앱이 전면에 켜져있기 때문에 푸시 알림 UI가 표시되지 않는다.
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        // 앱이 백그라운드 상태일 때 푸시 알림 UI를 누른 경우에 호출됨.
        // 앱이 포그라운드 상태로 전환된다.
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        // 앱이 꺼진 상태일 때 푸시 알림 UI를 눌러 앱을 시작하는 경우에 호출됨.
        print("onResume: $message");
      },
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  Future takeFCMTokenWhenAppLaunch() async {
    try {
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(
            IosNotificationSettings(sound: true, badge: true, alert: true));
        _firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
          print("Settings registered: $settings");
        });
      }

      final userToken = HiveController.instance.getFCMToken();
      if (userToken == null) {
        _firebaseMessaging.getToken().then((val) async {
          print('fcmToken: ' + val);
          HiveController.instance.setFCMToken(val);
        });
      }
    } catch (e) {
      print('fcmToken_error: ${e.message}');
    }
  }

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

  // mode:0 -> 최초로 보내는 메시지 알림
  // mode:1 -> 매칭이 완료되고 나서 기본 메시지 알림
  Future<void> sendNotificationToPeerUser(
      {messageType,
      text,
      myID,
      peerUserToken,
      unReadMSGCount,
      int mode = 1}) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$FIREBASE_CLOUD_SERVER_TOKEN',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': mode == 0
                ? '메시지가 도착했습니다!'
                : messageType == 'text' ? '$text' : '(사진)',
            'title': mode == 0 ? '익명의 상대방' : '$myID번 회원',
            "sound": "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '727340374289', // 이건 뭔지 모르겠음..
            'status': 'done',
          },
          'to': peerUserToken,
        },
      ),
    );
  }
}
