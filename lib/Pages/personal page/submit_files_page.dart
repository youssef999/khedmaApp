// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart' as db;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/user%20home/user_home_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class SubmitFilesPage extends StatefulWidget {
  const SubmitFilesPage({super.key, required this.employeeId});
  final int employeeId;
  @override
  State<SubmitFilesPage> createState() => _SubmitFilesPageState();
}

class _SubmitFilesPageState extends State<SubmitFilesPage> {
  FocusNode focusNode = FocusNode();
  TextEditingController descriptionController = TextEditingController();
  final GlobalController _globalController = Get.find();
  List<DesFile> files = [];
  File? file;
  String uploadText = "upload_files".tr;
  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(text: "docs".tr, fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !files.isNotEmpty
                  ? db.DottedBorder(
                      dashPattern: const [8, 8, 8, 8],
                      padding: const EdgeInsets.all(1),
                      radius: const Radius.circular(10),
                      color: const Color(0xffAEAEAE),
                      borderType: db.BorderType.RRect,
                      child: primaryButton(
                        radius: 10,
                        onTap: () async {
                          Utils.customDialog(
                              context: context,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: StatefulBuilder(builder: (c, s) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () => Get.back(),
                                            child: const Icon(
                                              EvaIcons.close,
                                            ),
                                          )
                                        ],
                                      ),
                                      coloredText(
                                          text: "name".tr, fontSize: 12.0.sp),
                                      spaceY(20),
                                      SendMessageTextField(
                                        maxLength: 40,
                                        controller: descriptionController,
                                        focusNode: focusNode,
                                        fillColor: Colors.transparent,
                                        wholeBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xffC7C7C7),
                                          ),
                                        ),
                                      ),
                                      spaceY(20),
                                      db.DottedBorder(
                                        dashPattern: const [8, 8, 8, 8],
                                        padding: const EdgeInsets.all(1),
                                        radius: const Radius.circular(10),
                                        color: const Color(0xffC7C7C7),
                                        borderType: db.BorderType.RRect,
                                        child: primaryButton(
                                          radius: 10,
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                                        allowMultiple: false);

                                            // XFile? image = await Utils()
                                            //     .selectImageSheet();

                                            // if (image != null) {
                                            //   file = image;
                                            //   uploadText = image.name;

                                            //   s(() {});
                                            //   setState(() {});
                                            // }

                                            if (result != null) {
                                              file = File(
                                                  result.files.single.path!);

                                              uploadText =
                                                  result.files.single.name;

                                              s(() {});
                                              setState(() {});
                                            }
                                          },
                                          width: 100.0.w,
                                          height: 15.h,
                                          color: const Color(0xffC7C7C7)
                                              .withOpacity(0.1),
                                          text: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                EvaIcons.cloudUploadOutline,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 40.sp,
                                              ),
                                              spaceY(10),
                                              Align(
                                                child: coloredText(
                                                  textAlign: TextAlign.center,
                                                  text: uploadText.length > 15
                                                      ? "${uploadText.substring(0, 15)}..."
                                                      : uploadText,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      spaceY(20),
                                      primaryButton(
                                        onTap: descriptionController.text !=
                                                    "" &&
                                                file != null
                                            ? () {
                                                DesFile tmp = DesFile(
                                                    descriptionController.text,
                                                    file!);
                                                files.add(tmp);

                                                file = null;
                                                uploadText = "upload_files".tr;
                                                descriptionController.text = "";
                                                Get.back();
                                                s(() {});
                                                setState(() {});
                                              }
                                            : null,
                                        width: 40.0.w,
                                        radius: 10.w,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        text: coloredText(
                                          text: "upload".tr,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ));
                        },
                        width: 100.0.w,
                        height: 35.h,
                        color: const Color(0xffAEAEAE).withOpacity(0.1),
                        text: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              EvaIcons.plus,
                              color: Colors.black,
                            ),
                            spaceX(10),
                            coloredText(
                              text: "upload_files".tr,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              !files.isNotEmpty
                  ? Container()
                  : SizedBox(
                      height: 70.0.h,
                      child: ListView.separated(
                          primary: false,
                          itemBuilder: (context, index) => index == files.length
                              ? Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: primaryButton(
                                    onTap: () {
                                      Utils.customDialog(
                                          context: context,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: StatefulBuilder(
                                                builder: (c, s) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => Get.back(),
                                                        child: const Icon(
                                                          EvaIcons.close,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  coloredText(
                                                      text: "name".tr,
                                                      fontSize: 12.0.sp),
                                                  spaceY(20),
                                                  SendMessageTextField(
                                                    controller:
                                                        descriptionController,
                                                    focusNode: focusNode,
                                                    fillColor:
                                                        Colors.transparent,
                                                    wholeBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xffC7C7C7),
                                                      ),
                                                    ),
                                                  ),
                                                  spaceY(20),
                                                  db.DottedBorder(
                                                    dashPattern: const [
                                                      8,
                                                      8,
                                                      8,
                                                      8
                                                    ],
                                                    padding:
                                                        const EdgeInsets.all(1),
                                                    radius:
                                                        const Radius.circular(
                                                            10),
                                                    color:
                                                        const Color(0xffC7C7C7),
                                                    borderType:
                                                        db.BorderType.RRect,
                                                    child: primaryButton(
                                                      radius: 10,
                                                      onTap: () async {
                                                        FilePickerResult?
                                                            result =
                                                            await FilePicker
                                                                .platform
                                                                .pickFiles(
                                                                    allowMultiple:
                                                                        false);

                                                        if (result != null) {
                                                          file = File(result
                                                              .files
                                                              .single
                                                              .path!);

                                                          uploadText = result
                                                              .files
                                                              .single
                                                              .name;

                                                          s(() {});
                                                          setState(() {});
                                                        }
                                                      },
                                                      width: 100.0.w,
                                                      height: 15.h,
                                                      color: const Color(
                                                              0xffC7C7C7)
                                                          .withOpacity(0.1),
                                                      text: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            EvaIcons
                                                                .cloudUploadOutline,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            size: 40.sp,
                                                          ),
                                                          spaceY(10),
                                                          Align(
                                                            child: coloredText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              text: uploadText
                                                                          .length >
                                                                      15
                                                                  ? "${uploadText.substring(0, 15)}..."
                                                                  : uploadText,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  spaceY(20),
                                                  primaryButton(
                                                    onTap: descriptionController
                                                                    .text ==
                                                                "" ||
                                                            file == null
                                                        ? null
                                                        : () {
                                                            DesFile tmp = DesFile(
                                                                descriptionController
                                                                    .text,
                                                                file!);
                                                            files.add(tmp);

                                                            file = null;
                                                            uploadText =
                                                                "upload_files"
                                                                    .tr;
                                                            descriptionController
                                                                .text = "";
                                                            Get.back();
                                                            s(() {});
                                                            setState(() {});
                                                          },
                                                    width: 40.0.w,
                                                    height: 50,
                                                    radius: 10.w,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    text: coloredText(
                                                      text: "upload".tr,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ));
                                    },
                                    width: 100.0.w,
                                    text: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xffF5F5F5)),
                                          child: Icon(
                                            EvaIcons.plus,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        spaceX(20),
                                        coloredText(
                                          text: "upload_files".tr,
                                          fontSize: 14.0.sp,
                                          color: const Color(0xff919191),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Material(
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(10),
                                  shadowColor: Colors.grey,
                                  child: ListTile(
                                    visualDensity: const VisualDensity(
                                        vertical: 2), // to expand

                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    title: coloredText(
                                        text: files[index].fileName!,
                                        color: Colors.black,
                                        fontSize: 11.sp),
                                    subtitle: coloredText(
                                        text: files[index].description,
                                        color: Colors.grey,
                                        fontSize: 11.sp),
                                    trailing: Theme(
                                      data:
                                          ThemeData(primaryColor: Colors.white),
                                      child: PopupMenuButton(
                                        constraints: BoxConstraints(
                                          minWidth: 2.0 * 56.0,
                                          maxWidth:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem<int>(
                                            value: 0,
                                            child: coloredText(
                                                text: 'delete'.tr,
                                                fontSize: 11.0.sp),
                                            onTap: () {
                                              files.removeAt(index);
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                        child: const Icon(
                                          EvaIcons.moreVertical,
                                        ),
                                      ),
                                    ),
                                    leading: Icon(
                                      EvaIcons.fileText,
                                      size: 30.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                          separatorBuilder: (context, index) => spaceY(10),
                          itemCount: files.length + 1),
                    ),
              !files.isNotEmpty
                  ? Container()
                  : primaryButton(
                      onTap: () async {
                        bool b = await _globalController.submitDocs(
                            files: files, id: widget.employeeId);
                        if (b) {
                          Utils.customDialog(
                              actions: [
                                primaryButton(
                                  onTap: () {
                                    Get.back();
                                    Get.offAll(() => const UserHomePage());
                                  },
                                  width: 40.0.w,
                                  height: 50,
                                  radius: 10.w,
                                  color: Theme.of(context).colorScheme.primary,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        text: "the_documents_have_been_sent".tr,
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
                      width: 50.0.w,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ]),
                      text: coloredText(
                        text: "submit".tr,
                        color: Colors.white,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class DesFile {
  final String description;
  final File? file;
  String? fileName;
  DesFile(
    this.description,
    this.file,
  ) {
    if (file != null) {
      fileName = basename(file!.path);
    }
  }
}
