import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/chat%20page/model/my_message.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../Themes/themes.dart';
import '../../Utils/utils.dart';
import '../../models/send_items_model.dart';
import '../../widgets/underline_text_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.chatId,
    required this.receiverId,
    required this.recieverName,
    required this.recieverImage,
  });
  final int chatId;
  final int receiverId;
  final String recieverName;
  final String recieverImage;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<SendMenuItems> menuItems = [];

  List<types.Message> _messages = [];
  List<MMessage> _myMessages = [];
  GlobalController _globalController = Get.find();
  late final types.User _user;
  TextEditingController sendController = TextEditingController(text: "");
  ChatController _chatController = Get.find();

  FocusNode sendFocus = FocusNode();
  late Timer _timer;
  @override
  void initState() {
    logWarning(widget.chatId);
    _user = types.User(id: _globalController.me.id!.toString());
    super.initState();
    sendFocus.addListener(
      () {
        setState(() {});
      },
    );

    menuItems = [
      SendMenuItems(
        text: "Photos",
        icons: Icons.image,
        color: Colors.amber,
        onTap: _handleImageSelection,
      ),
      // SendMenuItems(
      //   text: "Document",
      //   icons: Icons.insert_drive_file,
      //   color: Colors.blue,
      //   onTap: _handleFileSelection,
      // ),
      SendMenuItems(
        text: "Audio",
        icons: Icons.music_note,
        color: Colors.orange,
        onTap: () {},
      ),
      SendMenuItems(
        text: "Cancel",
        icons: EvaIcons.close,
        color: Colors.red,
        onTap: () {
          Get.back();
        },
      ),
    ];
    _loadMessages(true);
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        _loadMessages(false);
      },
    );
  }

  bool isRTL(String text) {
    if (text == "") return true;
    return intl.Bidi.detectRtlDirectionality(text);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2.25,
            color: const Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  spaceY(16),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  spaceY(10),
                  ListView.builder(
                    itemCount: menuItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          onTap: menuItems[index].onTap,
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: menuItems[index].color.shade50,
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              menuItems[index].icons,
                              size: 20,
                              color: menuItems[index].color.shade400,
                            ),
                          ),
                          title: Text(menuItems[index].text),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
    // showModalBottomSheet<void>(
    //   backgroundColor: Colors.white,
    //   context: context,
    //   builder: (BuildContext context) => SafeArea(
    //     child: SizedBox(
    //       height: 144,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               _handleImageSelection();
    //             },
    //             child: const Align(
    //               alignment: AlignmentDirectional.centerStart,
    //               child: Text('Photo'),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               _handleFileSelection();
    //             },
    //             child: const Align(
    //               alignment: AlignmentDirectional.centerStart,
    //               child: Text('File'),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.pop(context),
    //             child: const Align(
    //               alignment: AlignmentDirectional.centerStart,
    //               child: Text('Cancel'),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  // void _handleFileSelection() async {
  //   XFile? image = await Utils().selectImageSheet();

  //   if (image != null) {
  //     setState(() {});

  //     // final message = types.FileMessage(
  //     //   author: _user,
  //     //   createdAt: DateTime.now().millisecondsSinceEpoch,
  //     //   id: const Uuid().v4(),
  //     //   mimeType: lookupMimeType(image.path!),
  //     //   name: image.name,
  //     //   size: image.size,
  //     //   uri: image.path!,
  //     // );

  //     Get.back();

  //     _addMessage(message);
  //   }
  // }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      Get.back();
      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    // if (message is types.FileMessage) {
    //   var localPath = message.uri;

    //   if (message.uri.startsWith('http')) {
    //     try {
    //       final index =
    //           _messages.indexWhere((element) => element.id == message.id);
    //       final updatedMessage =
    //           (_messages[index] as types.FileMessage).copyWith(
    //         isLoading: true,
    //       );

    //       setState(() {
    //         _messages[index] = updatedMessage;
    //       });

    //       final client = http.Client();
    //       final request = await client.get(Uri.parse(message.uri));
    //       final bytes = request.bodyBytes;
    //       final documentsDir = (await getApplicationDocumentsDirectory()).path;
    //       localPath = '$documentsDir/${message.name}';

    //       if (!File(localPath).existsSync()) {
    //         final file = File(localPath);
    //         await file.writeAsBytes(bytes);
    //       }
    //     } finally {
    //       final index =
    //           _messages.indexWhere((element) => element.id == message.id);
    //       final updatedMessage =
    //           (_messages[index] as types.FileMessage).copyWith(
    //         isLoading: null,
    //       );

    //       setState(() {
    //         _messages[index] = updatedMessage;
    //       });
    //     }
    //   }

    //   await OpenFilex.open(localPath);
    // }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
    sendController.text = "";

    logError("reciever id : " + widget.receiverId.toString());
    await _chatController.storeMessage(
        id: widget.receiverId, message: message.text);
    setState(() {});
  }

  int _mySortComparison(MMessage a, MMessage b) {
    final propertyA = DateTime.parse(a.createdAt!);
    final propertyB = DateTime.parse(b.createdAt!);
    if (propertyA.isBefore(propertyB)) {
      return 1;
    } else if (propertyA.isAfter(propertyB)) {
      return -1;
    } else {
      return 0;
    }
  }

  void _loadMessages(bool b) async {
    // final response = await rootBundle.loadString('assets/messages.json');
    final response =
        await _chatController.showChat(id: widget.chatId, indicator: b);
    final messages = MyChat.fromJson(response);

    setState(() {
      _myMessages = messages.messages!;
      _myMessages.sort(_mySortComparison);
      _messages = _myMessages
          .map(
            (e) => types.TextMessage(
                author: types.User(id: e.user!.id!.toString()),
                id: e.id.toString(),
                createdAt: DateTime.parse(e.createdAt!).millisecondsSinceEpoch,
                text: e.message!),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _chatController.getChats();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size(100.0.w, 2.0.h),
              child: const Divider(
                color: Colors.grey,
                thickness: 0.5,
              )),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.recieverImage),
              ),
              spaceX(20),
              coloredText(text: widget.recieverName, fontSize: 15.0.sp),
            ],
          ),
        ),
        body: GetBuilder<ChatController>(builder: (c) {
          return c.getChatFlag
              ? const Center(child: CircularProgressIndicator())
              : Theme(
                  data: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                          seedColor: AppThemes.colorCustom),
                      primaryColor: Colors.white),
                  child: Chat(
                    messages: _messages,
                    customBottomWidget: Container(
                      padding: const EdgeInsets.all(20),
                      child: SendMessageTextField(
                        focusNode: sendFocus,
                        hintText: "Type a message",
                        padding: const EdgeInsetsDirectional.only(start: 20),

                        textDirection: isRTL(sendController.text)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _handleSendPressed(
                                types.PartialText(
                                  text: sendController.text,
                                ),
                              );
                              sendController.text = "";
                            },
                            child: Icon(
                              Icons.send,
                              color: sendController.text == ""
                                  ? const Color(0xff919191)
                                  : Theme.of(context).colorScheme.secondary,
                            )),

                        // prefixIcon: GestureDetector(
                        //   onTap: () {
                        //     _handleAttachmentPressed();
                        //   },
                        //   child: const Icon(
                        //     EvaIcons.attach,
                        //     color: Color(0xff919191),
                        //   ),
                        // ),

                        controller: sendController,
                        onchanged: (s) {
                          setState(() {});
                        },
                        // textDirection: TextDirection.ltr,
                      ),
                    ),
                    // dateHeaderBuilder: (p0) =>
                    //     coloredText(text: p0.text, color: Colors.red),

                    customDateHeaderText: (p0) =>
                        intl.DateFormat('yyyy-MM-dd hh:mm a').format(p0),
                    // onAttachmentPressed: _handleAttachmentPressed,
                    theme: DefaultChatTheme(
                      primaryColor: Theme.of(context).colorScheme.primary,
                    ),
                    // onMessageTap: _handleMessageTap,
                    // onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: _handleSendPressed,
                    showUserAvatars: false,
                    showUserNames: true,
                    user: _user,
                  ),
                );
        }),
      );
}
