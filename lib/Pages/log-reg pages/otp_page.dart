// ignore_for_file: use_build_context_synchronously
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/log-reg%20pages/controller/auth_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/login_page.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../../widgets/underline_text_field.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({
    super.key,
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  FocusNode node = FocusNode();
  TextEditingController codeController = TextEditingController();
  final AuthController _authController = Get.find();
  @override
  void initState() {
    node.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ZeroAppBar(color: Colors.red),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        primary: false,
        children: [
          spaceY(10.0.h),
          Align(
            child: Container(
              width: 40.0.w,
              height: 40.0.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/well-done.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          spaceY(5.0.h),
          Align(
            child: coloredText(
              text: "otp_text_1".tr,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
            ),
          ),
          spaceY(3.0.h),
          Align(
            child: coloredText(
              text: "otp_text_2".tr,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 13.0.sp,
              textAlign: TextAlign.center,
            ),
          ),
          spaceY(3.0.h),
          Center(
            child: UnderlinedCustomTextField(
              // width: 90.0.w,
              keyBoardType: TextInputType.number,
              controller: codeController,
              focusNode: node,
              hintText: "code",
            ),
          ),
          spaceY(7.0.h),
          primaryButton(
            height: 50,
            width: 45.0.w,
            radius: 30,
            text: coloredText(
              text: "send".tr,
              color: Colors.white,
              fontSize: 16.0.sp,
            ),
            color: Theme.of(context).colorScheme.primary,
            onTap: () async {
              bool x = await _authController.confirmEmail(
                  email: widget.email, code: codeController.text);
              if (x) {
                Utils.customDialog(
                    actions: [
                      primaryButton(
                        onTap: () {
                          Get.back();
                          Get.offAll(() => LoginPage());
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
                              text: "your_email_have_been_confirmed".tr,
                              fontSize: 12.0.sp),
                          coloredText(
                            text: "successfully".tr,
                            fontSize: 14.0.sp,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ));
              }
            },
          ),
          spaceY(2.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              coloredText(
                text: "otp_text_3".tr,
                color: Colors.grey,
              ),
              spaceX(10),
              GestureDetector(
                onTap: () async {
                  LoginStates state = await _authController.handleNormalSignIn(
                    userName: widget.email,
                    password: widget.password,
                    saveToken: false,
                  );
                  if (state == LoginStates.needsVerify) {
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
                                  text: "code_has_been_sent".tr,
                                  fontSize: 12.0.sp),
                              coloredText(
                                text: "successfully".tr,
                                fontSize: 14.0.sp,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ),
                        ));
                  }
                },
                child: coloredText(
                  text: "otp_text_4".tr,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
