import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/Notifications/models/notification_model.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';

class NotificationController extends GetxController {
  final Dio dio = Utils().dio;
  bool newNotifications = false;
  List<NotificationModel> notifications = [];
  int _mySortComparison(NotificationModel a, NotificationModel b) {
    final propertyA = DateTime.parse(a.createdAt!);
    final propertyB = DateTime.parse(b.createdAt!);
    if (propertyA.isBefore(propertyB)) {
      return 1;
    } else {
      return -1;
    }
  }

  void updateFlag(bool f) {
    newNotifications = f;
    update();
  }

  GlobalController _globalController = Get.find();
  bool getNotificationsFlag = false;
  Future getNotifications() async {
    try {
      getNotificationsFlag = true;

      String? token = await Utils.readToken();
      var res = await dio.get(
          _globalController.me.userType == "admin"
              ? EndPoints.notificationsAdmin
              : EndPoints.notifications,
          options: Options(headers: {"authorization": "Bearer $token"}));
      logSuccess(res.data);
      List<NotificationModel> tmp = [];
      for (var i in res.data['data']) {
        NotificationModel t = NotificationModel.fromJson(i);
        if (t.notificationType != "chatMessage") {
          tmp.add(t);
        }
      }
      tmp.sort(_mySortComparison);
      updateFlag(false);
      notifications = tmp;
      logSuccess("Notifications get done");
      getNotificationsFlag = false;
      update();
    } on DioException catch (e) {
      getNotificationsFlag = false;
      update();
      logError(e.response!.data);
      logError("Notifications failed");
    }
  }
}
