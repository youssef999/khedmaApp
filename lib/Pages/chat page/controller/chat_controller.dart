import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
// import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:khedma/Pages/chat%20page/model/my_message.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';

class ChatController extends GetxController {
  final Dio dio = Utils().dio;
  List<MyChat> chats = [];
  List<MyChat> chatsToShow = [];
  bool unreadChatsFlag = false;
  bool getChatsFlag = false;
  GlobalController _globalController = Get.find();

  handleEmployeesSearch({required String name}) {
    List<MyChat> tmp = [];
    for (var i in chats) {
      if (i.participants![0].user!.fullName!.toLowerCase().contains(name) ||
          i.participants![1].user!.fullName!.toLowerCase().contains(name)) {
        logSuccess(i.participants![0].user!.fullName!);
        logSuccess(i.participants![1].user!.fullName!);
        logSuccess(name);
        tmp.add(i);
      }
      if (name == "") {
        chatsToShow = chats;
      } else {
        chatsToShow = tmp;
      }
      update();
    }
  }

  Future getChats() async {
    try {
      getChatsFlag = true;
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getAllChats,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      List<MyChat> tmp = [];
      int cc = 0;
      for (var i in res.data['data']) {
        MyChat t = MyChat.fromJson(i);
        if (t.unreadMessagesCount! > 0 &&
            _globalController.me.id! != t.lastMessage!.userId) {
          unreadChatsFlag = true;
          cc = cc + 1;
        }

        tmp.add(t);
      }
      if (cc == 0) unreadChatsFlag = false;
      chats = tmp;
      chatsToShow = tmp;
      chats.sort(_mySortComparison);
      logSuccess("Chats get done");
      getChatsFlag = false;
      update();
    } on DioException catch (e) {
      logError(e.response!.data);

      getChatsFlag = false;
      update();
      logError("Chats failed");
    }
  }

  bool getChatFlag = false;
  Future showChat({required int id, required bool indicator}) async {
    try {
      if (indicator) getChatFlag = true;
      String? token = await Utils.readToken();
      var res = await dio.get(
        EndPoints.showChat(id),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      logError(res.data);
      logSuccess("Chat get done");
      await getChats();
      if (indicator) getChatFlag = false;
      update();
      return res.data;
    } on DioException {
      getChatFlag = false;
      update();
      logError("Chat failed");
    }
  }

  Future storeMessage({required int id, required String message}) async {
    try {
      String? token = await Utils.readToken();
      final body = d.FormData.fromMap(
        {"chat_id": id, "message": message},
      );
      logWarning(body.fields[0].value);
      logWarning(body.fields[1].value);
      await dio.post(
        EndPoints.storeMessage,
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      await getChats();
      logSuccess("message store  done");
    } on DioException catch (e) {
      logError(e.response!.data);
      logError("message store failed");
    }
  }

  Future<GlobalChat?> storeChat({required int id}) async {
    try {
      Utils.circularIndicator();
      String? token = await Utils.readToken();
      final body = d.FormData.fromMap(
        {"user_id": id},
      );

      var res = await dio.post(
        EndPoints.storeChat,
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      GlobalChat tmp = GlobalChat.fromJson(res.data['data']);

      logSuccess("chat store  done");
      logSuccess(tmp.toJson());
      Get.back();
      return tmp;
    } on DioException catch (e) {
      Get.back();
      logError(e.response!.data);
      logError("chat store failed");
    }
    return null;
  }

  int _mySortComparison(MyChat a, MyChat b) {
    final propertyA = DateTime.parse(a.createdAt!);
    final propertyB = DateTime.parse(b.createdAt!);
    if (a.unreadMessagesCount! < b.unreadMessagesCount! ||
        propertyA.isAfter(propertyB)) {
      return 1;
    } else if (a.unreadMessagesCount! > b.unreadMessagesCount! ||
        propertyA.isBefore(propertyB)) {
      return -1;
    } else {
      return 0;
    }
  }
}
