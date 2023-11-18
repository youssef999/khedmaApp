// ignore_for_file: must_be_immutable

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/chat_card.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

import '/widgets/search_text_field.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  ChatController _chatController = Get.find();
  GlobalController _globalController = Get.find();

  @override
  void initState() {
    _chatController.getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "messages".tr, fontSize: 15.0.sp),
      ),
      body: GetBuilder<ChatController>(builder: (c) {
        return Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Column(
            children: [
              SearchTextField(
                onchanged: (s) {
                  if (s != null) {
                    c.handleEmployeesSearch(name: s);
                  }
                },
                hintText: "${"search".tr} ...",
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
              ),
              spaceY(2.0.h),
              Expanded(
                child: c.getChatsFlag
                    ? const Center(child: CircularProgressIndicator())
                    : c.chatsToShow.isEmpty
                        ? const NoItemsWidget()
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            itemBuilder: (context, index) {
                              ChatType chatType = ChatType.read;
                              // switch (Random().nextInt(100) % 2) {
                              //   case 0:
                              //     chatType = ChatType.read;
                              //     break;
                              //   case 1:
                              //     chatType = ChatType.delivered;
                              //     break;
                              //   case 2:
                              //     chatType = ChatType.typing;
                              //     break;
                              //   default:
                              //     chatType = ChatType.recieved;
                              //     break;
                              // }
                              // chatType = ChatType.read;
                              // chatType = ChatType.delivered;
                              // chatType = ChatType.typing;
                              if (c.chatsToShow[index].unreadMessagesCount! >
                                      0 &&
                                  _globalController.me.id! !=
                                      c.chatsToShow[index].lastMessage!
                                          .userId) {
                                chatType = ChatType.recieved;
                              } else {
                                chatType = ChatType.delivered;
                              }
                              return ChatCard(
                                chatType: chatType,
                                chat: c.chatsToShow[index],
                              );
                            },
                            separatorBuilder: (context, index) => Column(
                              children: [
                                spaceY(1.0.h),
                                const Divider(
                                  color: Color(0xffEBEBEB),
                                  thickness: 1,
                                ),
                                spaceY(1.0.h),
                              ],
                            ),
                            itemCount: c.chatsToShow.length,
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}
