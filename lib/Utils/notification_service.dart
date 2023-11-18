import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/Notifications/notifications_page.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/chat%20page/messages_page.dart';
import 'package:khedma/Utils/utils.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:flutter_push_notifications/utils/download_util.dart';
import 'package:rxdart/subjects.dart';

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
    logSuccess(body!);
  }

  void selectNotification(NotificationResponse? notiResponse) async {
    if (notiResponse!.payload != null) {
      logError('notification payload: ${notiResponse.payload}');
      if (notiResponse.payload!.contains("Message From")) {
        ChatController _chat = Get.find();

        if (Get.currentRoute == "/MessagesPage") {
          await _chat.getChats();
        } else {
          Get.to(() => MessagesPage());
        }
      } else if (Get.currentRoute == "/NotificationsPage") {
        NotificationController _notiController = Get.find();
        await _notiController.getNotifications();
      } else {
        Get.to(() => NotificationsPage());
      }
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.dropidea.khedma',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      // largeIcon: const DrawableResourceAndroidBitmap('justwater'),
      // styleInformation: BigPictureStyleInformation(
      //   FilePathAndroidBitmap(bigPicture),
      //   hideExpandedLargeIcon: false,
      // ),
      // color: const Color(0xff2196f3),
    );

    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      threadIdentifier: "thread1",
      // attachments: <DarwinNotificationAttachment>[
      //   NotificationAttachment(bigPicture)
      // ]
    );

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      behaviorSubject.add(details.notificationResponse!.payload!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
