import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/login_page.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../../widgets/zero_app_bar.dart';
import '../Select%20Language%20Page/get_started_page.dart';

class SelectLanguagePage extends StatelessWidget {
  SelectLanguagePage({super.key});
  final GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZeroAppBar(color: Colors.white),
      body: ListView(
        primary: false,
        children: [
          spaceY(15.0.h),
          GestureDetector(
            onTap: () {
              Get.to(
                () => const GettingStartedPage(),
              );
            },
            child: Container(
              width: 35.0.w,
              height: 35.0.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          spaceY(5.0.h),
          Center(
            child: coloredText(
              text: "Please choose a language",
              fontSize: 16.0.sp,
              color: Theme.of(context).colorScheme.tertiary,
              // fontWeight: FontWeight.w500,
            ),
          ),
          spaceY(5.0.h),
          primaryBorderedButton(
            onTap: () async {
              await Utils.saveLanguage(language: "en");
              await _globalController.setLocale();
              Get.to(
                () => const LoginPage(),
              );
            },
            width: 75.0.w,
            height: 55,
            color: Theme.of(context).colorScheme.secondary,
            text: coloredText(
              text: "English",
              fontSize: 18.0.sp,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          spaceY(5.0.h),
          primaryButton(
            onTap: () async {
              await Utils.saveLanguage(language: "ar");
              await _globalController.setLocale();
              Get.to(
                () => const LoginPage(),
              );
            },
            width: 75.0.w,
            height: 55,
            color: Theme.of(context).primaryColor,
            text: coloredText(
                text: "العربية", fontSize: 18.0.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
