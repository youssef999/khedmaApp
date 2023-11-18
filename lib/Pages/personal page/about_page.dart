// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  AdminController _adminController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: coloredText(text: "about_app".tr, fontSize: 15.0.sp),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          children: [
            spaceY(30.sp),
            Container(
              width: 60.w,
              height: 60.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain),
              ),
            ),
            spaceY(10.sp),
            coloredText(
              text: _adminController.aboutModel != null
                  ? _adminController.aboutModel!.about!
                  : "",
              fontSize: 14.sp,
              textAlign: TextAlign.justify,
            ),
            spaceY(10.sp),
            coloredText(
              text: "V 1.0",
              fontSize: 11.sp,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
