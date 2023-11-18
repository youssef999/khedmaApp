import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/models/company_request_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class RequestFilesPage extends StatefulWidget {
  const RequestFilesPage({super.key, required this.documentModel});
  final DocumentModel documentModel;
  @override
  State<RequestFilesPage> createState() => _RequestFilesPageState();
}

class _RequestFilesPageState extends State<RequestFilesPage> {
  List<ContractFiles> contractFiles = [];
  final GlobalController _globalController = Get.find();
  @override
  void initState() {
    for (var i = 0; i < widget.documentModel.names!.length; i++) {
      contractFiles.add(
        ContractFiles(
          file: widget.documentModel.files![i],
          name: widget.documentModel.names![i],
          contractFileType: ContractFileType.localFile,
        ),
      );
    }
    super.initState();
  }

  late String _localPath;

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      // var dir = (await _dirsOnIOS)[0]; // temporary
      // var dir = (await _dirsOnIOS)[1]; // applicationSupport
      // var dir = (await _dirsOnIOS)[2]; // library
      var dir = (await _dirsOnIOS)[3]; // applicationDocuments
      // var dir = (await _dirsOnIOS)[4]; // downloads

      dir ??= await getApplicationDocumentsDirectory();
      externalStorageDirPath = dir.absolute.path;
    }

    return externalStorageDirPath;
  }

  Future<List<Directory?>> get _dirsOnIOS async {
    final temporary = await getTemporaryDirectory();
    final applicationSupport = await getApplicationSupportDirectory();
    final library = await getLibraryDirectory();
    final applicationDocuments = await getApplicationDocumentsDirectory();
    final downloads = await getDownloadsDirectory();

    final dirs = [
      temporary,
      applicationSupport,
      library,
      applicationDocuments,
      downloads
    ];

    return dirs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(text: "show_files".tr, fontSize: 15.0.sp),
      ),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: [
          primaryButton(
            onTap: () async {
              await _prepareSaveDir();

              for (var i = 0; i < widget.documentModel.names!.length; i++) {
                await FlutterDownloader.enqueue(
                  url: widget.documentModel.files![i],
                  fileName: widget.documentModel.names![i],
                  savedDir: _localPath,
                  saveInPublicStorage: true,
                  showNotification:
                      true, // show download progress in status bar (for Android)
                  openFileFromNotification:
                      true, // click on notification to open downloaded file (for Android)
                );
              }
            },
            width: 100.w,
            color: const Color(0xffF5F5F5),
            text: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(EvaIcons.download),
                spaceX(10),
                coloredText(text: "download".tr),
              ],
            ),
          ),
          spaceY(20),
          SizedBox(
            height: 65.h,
            child: GridView.count(
              childAspectRatio: 0.65,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10.w,
              crossAxisCount: 2,
              children: List.generate(contractFiles.length, (index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uri x = Uri.parse(contractFiles[index].file);
                        await launchUrl(x,
                            mode: LaunchMode.externalApplication);
                      },
                      child: contractFiles[index].file.endsWith("pdf") ||
                              contractFiles[index].file.endsWith("docx")
                          ? const SizedBox(
                              height: 200,
                              width: 300,
                              child: Center(
                                child: Icon(
                                  EvaIcons.fileText,
                                  color: Colors.grey,
                                  size: 100,
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(contractFiles[index].file),
                                ),
                              ),
                            ),
                    ),
                    spaceY(5.sp),
                    coloredText(
                      text: contractFiles[index].name,
                      fontSize: 15.sp,
                    ),
                    // spaceY(10),
                    // coloredText(
                    //     text: contractFiles[index].size,
                    //     fontSize: 12.sp,
                    //     color: const Color(0xff919191))
                  ],
                );
              }),
            ),
          ),
          spaceY(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              primaryButton(
                onTap: () async {
                  bool b = await _globalController.approveDocs(
                      approve: 1, id: widget.documentModel.id!);
                  if (b) Utils.doneDialog(context: context, backTimes: 2);
                },
                color: Colors.black,
                width: 43.w,
                height: 50,
                text: coloredText(text: "accept".tr, color: Colors.white),
              ),
              primaryButton(
                onTap: () {
                  String desc = "";
                  Utils.showDialogBox(
                    context: context,
                    actions: [
                      primaryButton(
                        onTap: () async {
                          Get.back();
                          bool b = await _globalController.approveDocs(
                              approve: 0,
                              id: widget.documentModel.id!,
                              desc: desc);
                          if (b) {
                            // ignore: use_build_context_synchronously
                            Utils.customDialog(
                                actions: [
                                  primaryButton(
                                    onTap: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    width: 40.0.w,
                                    height: 50,
                                    radius: 10.w,
                                    color: Colors.black,
                                    text: coloredText(
                                      text: "ok".tr,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                context: context,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      spaceY(20),
                                      Icon(
                                        EvaIcons.checkmarkCircle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 40.sp,
                                      ),
                                      spaceY(20),
                                      coloredText(
                                          text: "your_note_have_been_sent".tr,
                                          fontSize: 12.0.sp),
                                      coloredText(
                                        text: "successfully".tr,
                                        fontSize: 14.0.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ],
                                  ),
                                ));
                          }
                        },
                        color: Colors.black,
                        width: 45.w,
                        height: 50,
                        text:
                            coloredText(text: "submit".tr, color: Colors.white),
                      ),
                    ],
                    content: TextFormField(
                      onChanged: (value) {
                        desc = value;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "write_your_notes".tr,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xffF5F5F5),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            EvaIcons.close,
                          ),
                        )
                      ],
                    ),
                  );
                },
                width: 43.w,
                height: 50,
                color: const Color(0xffEEEEEE),
                text: coloredText(
                  text: "missing_files".tr,
                  color: const Color(0xff919191),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ContractFiles {
  final String file;
  final String name;
  final ContractFileType contractFileType;
  // final String size;
  ContractFiles({
    required this.file,
    required this.name,
    required this.contractFileType,
  });
}

enum ContractFileType {
  networkImage,
  localFile,
  networkFile,
}
