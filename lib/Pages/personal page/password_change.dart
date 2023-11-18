// ignore_for_file: use_build_context_synchronously

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/log-reg%20pages/forget%20password/controller/password_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../../widgets/underline_text_field.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  var errors = {};

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  PasswordController _passwordControllerGet = Get.find();
  bool valid = false;
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  @override
  void initState() {
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "change_password".tr, fontSize: 15.0.sp),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          primary: false,
          children: [
            spaceY(10.0.sp),
            UnderlinedCustomTextField(
              autovalidateMode: AutovalidateMode.always,
              focusNode: _focusNodes[0],
              controller: _oldPasswordController,
              keyBoardType: TextInputType.visiblePassword,
              hintText: "current_password".tr,
              validator: (String? value) {
                if (errors['oldPassword'] != null) {
                  String tmp = "";
                  tmp = errors['oldPassword'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors['oldPassword'] = null;
                setState(() {});
                valid = _oldPasswordController.text.isNotEmpty &&
                    _passwordConfirmController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty;
                setState(() {});
              },
            ),
            spaceY(20.0.sp),
            UnderlinedCustomTextField(
              autovalidateMode: AutovalidateMode.always,
              focusNode: _focusNodes[1],
              controller: _passwordController,
              keyBoardType: TextInputType.visiblePassword,
              hintText: "new_password".tr,
              validator: (String? value) {
                if (errors['newPassword'] != null) {
                  String tmp = "";

                  tmp = errors['newPassword'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors['newPassword'] = null;
                setState(() {});
                valid = _oldPasswordController.text.isNotEmpty &&
                    _passwordConfirmController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty;
                setState(() {});
              },
            ),
            spaceY(20.0.sp),
            UnderlinedCustomTextField(
              autovalidateMode: AutovalidateMode.always,
              focusNode: _focusNodes[2],
              controller: _passwordConfirmController,
              keyBoardType: TextInputType.visiblePassword,
              hintText: "confirm_password".tr,
              validator: (s) =>
                  _passwordConfirmController.text != _passwordController.text
                      ? "Password confirmations dosn't match new password"
                      : null,
              onchanged: (s) {
                errors['newPassword'] = null;
                setState(() {});
                valid = _oldPasswordController.text.isNotEmpty &&
                    _passwordConfirmController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty;
                setState(() {});
              },
            ),
            spaceY(60.0.sp),
            primaryButton(
                onTap: !valid
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        var x = await _passwordControllerGet.chageePassWord(
                            _oldPasswordController.text,
                            _passwordController.text,
                            _passwordConfirmController.text);
                        if (x != true) {
                          logError(x);
                          if (x['errors'] == null) {
                            errors['oldPassword'] = ["incorrect Password"];
                          } else {
                            errors = x['errors'];
                          }
                          setState(() {});
                        } else {
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 40.sp,
                                    ),
                                    spaceY(20),
                                    coloredText(
                                        text: "you_have_been_registered".tr,
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
                text: coloredText(text: "apply".tr, color: Colors.white),
                gradient: valid
                    ? LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      )
                    : null,
                color: !valid ? const Color(0xffB2B2B2) : null)
          ],
        ),
      ),
    );
  }
}
