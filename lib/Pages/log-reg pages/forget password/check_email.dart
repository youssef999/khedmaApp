// ignore_for_file: use_build_context_synchronously

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/log-reg%20pages/forget%20password/controller/password_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:khedma/widgets/zero_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class CheckEmailPage extends StatefulWidget {
  CheckEmailPage(
      {super.key,
      required this.phoneEmailFlag,
      required this.sender,
      this.code});
  final bool phoneEmailFlag;
  final String sender;
  final String? code;

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController newPassController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  PasswordController _passwordController = Get.find();

  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  String? pin = "";
  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {});
    });
    focusNode2.addListener(() {
      setState(() {});
    });
    focusNode3.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZeroAppBar(
        color: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          primary: false,
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Lottie.asset(
                  widget.phoneEmailFlag
                      ? "assets/message.zip"
                      : "assets/email.zip",
                  width: 95.w,
                  fit: BoxFit.cover

                  // image: AssetImage("assets/images/email_check.gif"),
                  // fit: BoxFit.cover,
                  ),
            ),
            Center(
              child: coloredText(
                text: widget.phoneEmailFlag
                    ? "check_your_phone_messages".tr
                    : "check_your_email".tr,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            spaceY(10.sp),
            Center(
              child: SizedBox(
                width: 75.w,
                child: coloredText(
                    text: widget.phoneEmailFlag ? "phone_c".tr : "email_c".tr,
                    fontSize: 12.sp,
                    textAlign: TextAlign.center),
              ),
            ),
            spaceY(10.sp),
            SendMessageTextField(
              focusNode: focusNode,
              textDirection: TextDirection.ltr,
              borderRadius: 10,
              validator: (s) {
                if (s!.length < 6) return "required";
                return null;
              },
              autovalidateMode: AutovalidateMode.disabled,
              onchanged: (s) {
                pin = s!;
              },
            ),
            spaceY(10.sp),
            coloredText(text: "new_password".tr, fontSize: 13.sp),
            SendMessageTextField(
              focusNode: focusNode2,
              borderRadius: 10,
              padding: const EdgeInsets.all(0),
              controller: newPassController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validatePassword,
            ),
            spaceY(10.sp),
            coloredText(text: "confirm_password".tr, fontSize: 13.sp),
            SendMessageTextField(
              focusNode: focusNode3,
              borderRadius: 10,
              padding: EdgeInsets.all(0),
              controller: confirmPassController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (s) {
                if (s!.isEmpty) {
                  return "reqired";
                } else if (s != newPassController.text) {
                  return "passwords are not match!";
                } else {
                  return null;
                }
              },
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            primaryButton(
              text: coloredText(text: "save".tr, color: Colors.white),
              color: Theme.of(context).colorScheme.primary,
              width: 75.w,
              onTap: () async {
                bool b = false;
                if (formKey.currentState!.validate()) {
                  if (!widget.phoneEmailFlag) {
                    logWarning("email");
                    b = await _passwordController.resetPassWord(
                        sender: widget.sender,
                        verrificationCode: pin!,
                        type: widget.phoneEmailFlag ? 1 : 2,
                        password: newPassController.text,
                        passwordConfirm: confirmPassController.text);
                  } else {
                    logWarning("phone");
                    logSuccess(widget.code!);
                    b = await _passwordController.resetPassWord(
                        sender: widget.sender,
                        verrificationCode: pin!,
                        code: widget.code,
                        type: widget.phoneEmailFlag ? 1 : 2,
                        password: newPassController.text,
                        passwordConfirm: confirmPassController.text);
                  }
                  if (b) {
                    Utils.customDialog(
                        actions: [
                          primaryButton(
                            onTap: () {
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
                                  text: "password_reset".tr, fontSize: 12.0.sp),
                              coloredText(
                                text: "successfully".tr,
                                fontSize: 14.0.sp,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ),
                        ));
                  }
                }
              },
            ),
            spaceY(10.sp)
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String? value) {
  final numreg = RegExp(r'\d');
  final bigAlphareg = RegExp(r'[A-Z]');
  final smallAlpgareg = RegExp(r'[a-z]');
  if (value!.length < 6) {
    return ("password should be at least 6 characters");
  } else if (value.length > 20) {
    return ("password should be no more 20 characters");
  } else if (!numreg.hasMatch(value)) {
    return ("password should have at least 1 numbers");
  } else if (!smallAlpgareg.hasMatch(value)) {
    return ("password should have at least 1 small letter");
  } else if (!bigAlphareg.hasMatch(value)) {
    return ("password should have at least 1 capital letter");
  }
  return null;
}
