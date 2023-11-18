import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Utils/utils.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  //   print('Handling a background message ${message.messageId}');
  // }

  // handleNotifications() async {
  //   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //       badge: true,
  //       alert: true,
  //       sound:
  //           true); //presentation options for Apple notifications when received in the foreground.

  //   FirebaseMessaging.onMessage.listen((message) async {
  //     print('Got a message whilst in the FOREGROUND!');
  //     return;
  //   }).onData((data) {
  //     print('Got a DATA message whilst in the FOREGROUND!');
  //     print('data from stream: ${data.data}');
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((message) async {
  //     print('NOTIFICATION MESSAGE TAPPED');
  //     return;
  //   }).onData((data) {
  //     print('NOTIFICATION MESSAGE TAPPED');
  //     print('data from stream: ${data.data}');
  //   });

  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //   FirebaseMessaging.instance.getInitialMessage().then(
  //       (value) => value != null ? _firebaseMessagingBackgroundHandler : false);
  //   return;
  // }

  Future<void> initNotifications(NotificationController c) async {
    String? tmp = await Utils.readFBToken();
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    logError(fcmToken!);
    if (tmp == null) {
      await Utils.saveFBToken(token: fcmToken);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // logSuccess(message.notification!.toString());
      // NotificationModel m =
      //     NotificationModel.fromJson(json.decode(message.notification!.body!));
      // if (m.notificationType == "chatMessage") {
      //   logSuccess("hello");
      //   if (Get.currentRoute == "/ChatPage") {
      //     ChatController _chat = Get.find();
      //     await _chat.showChat(id: m.typeId!, indicator: false);
      //   } else if (Get.currentRoute == "/MessagesPage") {
      //     ChatController _chat = Get.find();
      //     await _chat.getChats();
      //   } else {
      //     if (message.notification != null) {
      //       try {
      //         Utils.notificationService.showLocalNotification(
      //             id: 1,
      //             title: "Khedmah",
      //             body: m.text!,
      //             payload: m.notificationType!);
      //       } catch (e) {
      //         logError(e);
      //       }
      //     }
      //   }
      // }
      // else {
      if (message.notification != null) {
        if (message.notification!.body!.contains("Message From")) {
          if (Get.currentRoute == "/ChatPage") {
          } else if (Get.currentRoute == "/MessagesPage") {
            ChatController _chat = Get.find();
            await _chat.getChats();
          } else {
            logSuccess("asdas");
            logSuccess(message.notification!.body!);
            logSuccess(message.notification!.title!);
            try {
              Utils.notificationService.showLocalNotification(
                  id: 1,
                  title: message.notification!.title!,
                  body: message.notification!.body!,
                  payload: message.notification!.body!);
            } catch (e) {
              logError(e);
            }
          }
        } else {
          c.updateFlag(true);
          logSuccess("asdas");
          logSuccess(message.notification!.title!);
          logSuccess(message.notification!.body!);
          try {
            Utils.notificationService.showLocalNotification(
                id: 1,
                title: message.notification!.title!,
                body: message.notification!.body!,
                payload: message.notification!.body!);
          } catch (e) {
            logError(e);
          }
        }
      }
    });
  }
}
