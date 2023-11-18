import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';

class AdminProfileEditPage extends StatefulWidget {
  const AdminProfileEditPage({super.key});

  @override
  State<AdminProfileEditPage> createState() => _AdminProfileEditPageState();
}

class _AdminProfileEditPageState extends State<AdminProfileEditPage> {
  String nationality = "";
  String region = "";
  String city = "";
  String imagePath = "";
  Widget? imageWidget = Icon(
    EvaIcons.person,
    size: 35.w,
    color: Colors.white,
  );
  String? imageToEdit;
  XFile? imageAdmin;
  var errors = {};
  String logobuttonText = "upload_admin_logo".tr;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  GlobalController _globalController = Get.find();

  @override
  void initState() {
    _emailController.text = "";

    if (_globalController.me.adminPhoto != null) {
      imageToEdit = _globalController.me.adminPhoto;
      imageWidget = null;
    }
    if (_globalController.me.email != null) {
      _emailController.text = _globalController.me.email!;
    }
    if (_globalController.me.phone != null) {
      _phoneController.text = _globalController.me.phone!;
    }
    if (_globalController.me.fullName != null) {
      _nameController.text = _globalController.me.fullName!;
    }

    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  final key = GlobalKey<FormState>();
  bool valid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "edit_profile".tr, fontSize: 15.0.sp),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          primary: false,
          children: [
            spaceY(10.0.sp),
            GestureDetector(
              onTap: () async {
                XFile? image = await Utils().selectImageSheet();

                if (image != null) {
                  imageWidget = null;
                  imageToEdit = null;
                  imagePath = image.path;
                  imageAdmin = image;
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffEFEFEF),
                        image: imageToEdit != null
                            ? DecorationImage(
                                image: NetworkImage(imageToEdit!),
                                fit: BoxFit.cover,
                              )
                            : imageWidget != null
                                ? null
                                : DecorationImage(
                                    image: FileImage(
                                      File(imagePath),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      child: imageWidget,
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 0,
                    end: 23.w,
                    child: Align(
                      child: Container(
                        width: 15.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4),
                          shape: BoxShape.circle,
                          color: const Color(0xffEFEFEF),
                        ),
                        child: Icon(
                          EvaIcons.plus,
                          size: 10.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            spaceY(10.sp),
            coloredText(text: "name".tr),
            spaceY(5.sp),
            SearchTextField(
              focusNode: _focusNodes[0],
              controller: _nameController,

              autovalidateMode: AutovalidateMode.always,
              onchanged: (s) {
                errors['full_name'] = null;
                setState(() {});
              },
              validator: (String? value) {
                if (errors['full_name'] != null) {
                  String tmp = "";
                  tmp = errors['full_name'].join("\n");

                  return tmp;
                }
                return null;
              },

              //
            ),
            spaceY(10.sp),
            coloredText(text: "phone".tr),
            spaceY(5.sp),
            SearchTextField(
              focusNode: _focusNodes[2],
              controller: _phoneController,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              onchanged: (s) {
                errors['phone'] = null;
                setState(() {});
              },
              validator: (String? value) {
                if (errors['phone'] != null) {
                  String tmp = "";
                  tmp = errors['phone'].join("\n");

                  return tmp;
                }
                return null;
              },

              //
            ),

            spaceY(10.sp),
            coloredText(text: "email".tr),
            spaceY(5.sp),
            SearchTextField(
              focusNode: _focusNodes[1],
              controller: _emailController,
              keyBoardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.always,
              onchanged: (s) {
                errors['email'] = null;
                setState(() {});
              },
              validator: (String? value) {
                if (errors['email'] != null) {
                  String tmp = "";
                  tmp = errors['email'].join("\n");

                  return tmp;
                }
                return null;
              },

              //
            ),

            // spaceY(20.sp),
            // db.DottedBorder(
            //   dashPattern: const [6, 6, 6, 6],
            //   padding: const EdgeInsets.all(1),
            //   radius: const Radius.circular(10),
            //   color: const Color(0xffDBDBDB),
            //   borderType: db.BorderType.RRect,
            //   child: primaryButton(
            //       color: const Color(0xffF5F5F5),
            //       width: 100.0.w,
            //       height: 40.sp,
            //       radius: 10.sp,
            //       onTap: () async {
            //         XFile? image = await Utils().selectImageSheet();

            //         if (image != null) {
            //           setState(() {});

            //           logobuttonText =
            //               image.name.substring(0, min(15, image.name.length));

            //           setState(() {});
            //         }
            //       },
            //       text: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             EvaIcons.upload,
            //             color: const Color(0xff919191),
            //             size: 18.0.sp,
            //           ),
            //           spaceX(10),
            //           coloredText(
            //             text: logobuttonText,
            //             color: const Color(0xff919191),
            //             fontSize: 13.0.sp,
            //           ),
            //         ],
            //       )),
            // ),
            spaceY(40.0.sp),
            primaryButton(
              onTap: () async {
                FocusScope.of(context).unfocus();
                var x = await _globalController.updateAdminProfile(
                  name:
                      _nameController.text != "" ? _nameController.text : null,
                  email: _emailController.text != ""
                      ? _emailController.text
                      : null,
                  personaPhoto: imageAdmin,
                  phone: _phoneController.text != ""
                      ? _phoneController.text
                      : null,
                );
                if (x == true) {
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
                              color: Theme.of(context).colorScheme.secondary,
                              size: 40.sp,
                            ),
                            spaceY(20),
                            coloredText(
                                text: "profile_edited".tr, fontSize: 12.0.sp),
                            coloredText(
                              text: "successfully".tr,
                              fontSize: 14.0.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                      ));
                } else if (x['message'] == "The given data was invalid.") {
                  errors = x['errors'];

                  setState(() {});
                }
              },
              text: coloredText(text: "apply".tr, color: Colors.white),
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            spaceY(10.sp)
          ],
        ),
      ),
    );
  }
}
