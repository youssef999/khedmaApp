import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Pages/chat%20page/model/my_message.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:sizer/sizer.dart';

import '../Pages/chat%20page/chat_page.dart';
import '../Utils/utils.dart';

// ignore: must_be_immutable
class ChatCard extends StatelessWidget {
  ChatCard({
    super.key,
    required this.chatType,
    required this.chat,
  });
  final ChatType chatType;
  final MyChat chat;
  final GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            // final response =
            //     await _chatController.showChat(id: chat.id!, indicator: true);
            Get.to(
              () => ChatPage(
                chatId: chat.id!,
                receiverId:
                    _globalController.me.id == chat.participants![0].userId
                        ? chat.participants![1].chatId!
                        : chat.participants![0].chatId!,
                recieverName:
                    _globalController.me.id == chat.participants![0].userId
                        ? chat.participants![1].user!.fullName!
                        : chat.participants![0].user!.fullName!,
                recieverImage: _globalController.me.userType == "company"
                    ? _globalController.me.id == chat.participants![0].userId
                        ? chat.participants![1].user!.userInformation!
                            .personalPhoto!
                        : chat.participants![0].user!.userInformation!
                            .personalPhoto!
                    : _globalController.me.id == chat.participants![0].userId
                        ? chat.participants![1].user!.companyInformation!
                            .companyLogo!
                        : chat.participants![0].user!.companyInformation!
                            .companyLogo,
              ),
            );
          },
          child: Container(
            width: 70.0.sp,
            height: 70.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(_globalController.me.userType == "company"
                      ? _globalController.me.id == chat.participants![0].userId
                          ? chat.participants![1].user!.userInformation!
                              .personalPhoto!
                          : chat.participants![0].user!.userInformation!
                              .personalPhoto!
                      : _globalController.me.id == chat.participants![0].userId
                          ? chat.participants![1].user!.companyInformation!
                              .companyLogo!
                          : chat.participants![0].user!.companyInformation!
                              .companyLogo!),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        spaceX(10),
        Expanded(
          child: SizedBox(
            height: 70.0.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    coloredText(
                        text: (_globalController.me.id ==
                                            chat.participants![0].userId
                                        ? chat.participants![1].user!.fullName!
                                        : chat.participants![0].user!.fullName!)
                                    .length >
                                13
                            ? "${(_globalController.me.id == chat.participants![0].userId ? chat.participants![1].user!.fullName! : chat.participants![0].user!.fullName!).substring(0, 13)}..."
                            : (_globalController.me.id ==
                                    chat.participants![0].userId
                                ? chat.participants![1].user!.fullName!
                                : chat.participants![0].user!.fullName!),
                        fontSize: 12.0.sp),
                    coloredText(
                        text: DateFormat('hh:mm a').format(
                            DateTime.parse(chat.lastMessage!.createdAt!)),
                        fontSize: 12.0.sp,
                        color: Colors.grey),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    chatType == ChatType.typing
                        ? coloredText(
                            text: "Typing...",
                            fontSize: 12.0.sp,
                            color: const Color(0xff2BB294),
                          )
                        : coloredText(
                            text: chat.lastMessage!.message!.length > 15
                                ? "${chat.lastMessage!.message!.substring(0, 15)}..."
                                : chat.lastMessage!.message!,
                            fontSize: 12.0.sp,
                            color: const Color(0xff919191),
                          ),
                    chatType == ChatType.recieved
                        ? Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: coloredText(
                                text: chat.unreadMessagesCount!.toString(),
                                color: Colors.white,
                              ),
                            ),
                          )
                        // :
                        // chatType == ChatType.delivered ||
                        //         chatType == ChatType.read
                        //     ? Icon(
                        //         EvaIcons.doneAll,
                        //         color: chatType == ChatType.delivered
                        //             ? const Color(0xff617FEA)
                        //             : const Color(0xff919191),
                        //       )
                        : Container()
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

enum ChatType {
  typing,
  recieved,
  delivered,
  read,
}
