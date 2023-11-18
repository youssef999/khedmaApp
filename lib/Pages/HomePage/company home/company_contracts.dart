// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/request_files.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class CompanyDocsPage extends StatefulWidget {
  const CompanyDocsPage({super.key, required this.readOnly});
  final bool readOnly;
  @override
  State<CompanyDocsPage> createState() => _CompanyDocsPageState();
}

class _CompanyDocsPageState extends State<CompanyDocsPage> {
  List<ContractFiles> contractFiles = [];
  final GlobalController _globalController = Get.find();

  @override
  void initState() {
    super.initState();
    logError(_globalController.me.companyInformation!.toJson());
    if (!widget.readOnly) {
      contractFiles.addAll([
        ContractFiles(
          contractFileType: ContractFileType.localFile,
          file: "${_globalController.tempDir!.path}/contract_myfatoorah.pdf",
          name: "Myfatoorah Contract".tr,
        ),
        ContractFiles(
          contractFileType: ContractFileType.localFile,
          file: "${_globalController.tempDir!.path}/contract_khedmah.pdf",
          name: "khedmah Contract".tr,
        ),
        ContractFiles(
            contractFileType: ContractFileType.networkFile,
            file: _globalController.me.companyInformation!.commercialLicense!,
            name: "commercial_license".tr),
        ContractFiles(
            contractFileType: ContractFileType.networkFile,
            file: _globalController
                .me.companyInformation!.signatureAuthorization!,
            name: "signiture_auth".tr),
        ContractFiles(
          contractFileType: ContractFileType.networkFile,
          file: _globalController.me.companyInformation!.articlesOfAssociation!,
          name: "articles_of_association".tr,
        ),
      ]);
    } else {
      contractFiles.addAll([
        ContractFiles(
          contractFileType: ContractFileType.networkFile,
          file: _globalController.me.companyInformation!.contractMyfatoorah!,
          name: "Myfatoorah Contract".tr,
        ),
        ContractFiles(
          contractFileType: ContractFileType.networkFile,
          file: _globalController.me.companyInformation!.contractKhedmah!,
          name: "khedmah Contract".tr,
        ),
        ContractFiles(
            contractFileType: ContractFileType.networkFile,
            file: _globalController.me.companyInformation!.commercialLicense!,
            name: "commercial_license".tr),
        ContractFiles(
            contractFileType: ContractFileType.networkFile,
            file: _globalController
                .me.companyInformation!.signatureAuthorization!,
            name: "signiture_auth".tr),
        ContractFiles(
          contractFileType: ContractFileType.networkFile,
          file: _globalController.me.companyInformation!.articlesOfAssociation!,
          name: "articles_of_association".tr,
        ),
      ]);
    }
  }

  late String _localPath;

  Future<void> _prepareSaveDir() async {
    // PermissionStatus b = await Permission.storage.request();
    // logSuccess(b.isGranted);
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
        title: coloredText(text: "contracts".tr, fontSize: 15.0.sp),
      ),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: [
          primaryButton(
            onTap: () async {
              await _prepareSaveDir();

              for (var i = 0; i < contractFiles.length; i++) {
                if (contractFiles[i].contractFileType ==
                    ContractFileType.localFile) {
                  File f = File(contractFiles[i].file);
                  // await f
                  //     .copy("$_localPath/${basename(contractFiles[i].file)}");
                  await f.writeAsBytes(
                      await File(contractFiles[i].file).readAsBytes(),
                      mode: FileMode.writeOnly);
                  Utils.showToast(
                      message: "${basename(contractFiles[i].file)} Done");
                } else {
                  await FlutterDownloader.enqueue(
                    url: contractFiles[i].file,
                    fileName: contractFiles[i].name,
                    savedDir: _localPath,
                    saveInPublicStorage: true,

                    showNotification:
                        true, // show download progress in status bar (for Android)
                    openFileFromNotification:
                        true, // click on notification to open downloaded file (for Android)
                  );
                }
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
            height: widget.readOnly ? 80.h : 65.h,
            child: GridView.count(
              childAspectRatio: 0.50,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10.w,
              crossAxisCount: 2,
              children: List.generate(contractFiles.length, (index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: contractFiles[index].file.endsWith("png") ||
                                  contractFiles[index].file.endsWith("jpeg") ||
                                  contractFiles[index].file.endsWith("jpg")
                              ? Container(
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          contractFiles[index].file),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 200,
                                  width: 300,
                                  child: Center(
                                    child: Icon(
                                      EvaIcons.fileText,
                                      color: Colors.grey,
                                      size: 100,
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          child: Theme(
                            data: ThemeData(primaryColor: Colors.white),
                            child: PopupMenuButton(
                              constraints: BoxConstraints(
                                minWidth: 2.0 * 56.0,
                                maxWidth: MediaQuery.of(context).size.width,
                              ),
                              itemBuilder: (BuildContext cc) => [
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: coloredText(
                                      text: 'open'.tr, fontSize: 12.0.sp),
                                  onTap: () async {
                                    if (contractFiles[index].contractFileType ==
                                        ContractFileType.localFile) {
                                      OpenFile.open(contractFiles[index].file);
                                    } else {
                                      Uri x =
                                          Uri.parse(contractFiles[index].file);
                                      await launchUrl(x,
                                          mode: LaunchMode.externalApplication);
                                    }
                                  },
                                ),
                              ],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  EvaIcons.moreVertical,
                                  size: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceY(5.sp),
                    coloredText(
                        text: contractFiles[index].name,
                        fontSize: 12.sp,
                        textAlign: TextAlign.center),
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
          widget.readOnly ? Container() : spaceY(20),
          widget.readOnly
              ? Container()
              : primaryButton(
                  onTap: () async {
                    bool b = await _globalController.verifyContract(
                      contractKhedmah: File(contractFiles[1].file),
                      contractMyfatoorah: File(contractFiles[0].file),
                    );
                    if (b) {
                      Utils.doneDialog(
                        context: context,
                        backTimes: 2,
                        // onTap: () {
                        //   Restart.restartApp();
                        // },
                        // onClose: (x) {
                        //   Restart.restartApp();
                        // },
                      );
                    }
                  },
                  color: Colors.black,
                  width: 80.w,
                  height: 40.sp,
                  text: coloredText(text: "accept".tr, color: Colors.white),
                )
        ],
      ),
    );
  }
}
