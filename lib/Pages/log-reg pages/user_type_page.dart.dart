import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/log-reg%20pages/company/company_register_page.dart';
import 'package:khedma/Pages/log-reg%20pages/user/user_register_page.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ZeroAppBar(color: Theme.of(context).primaryColor),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                // clipper: WaveClipperOne(flip: true),
                child: Container(
                  height: 16.0.h,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              spaceY(10.0.h),
              Expanded(
                child: Container(
                  width: 100.0.w,
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  child: ListView(
                    primary: false,
                    children: [
                      Container(
                        width: 35.0.w,
                        height: 35.0.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      spaceY(10.0.h),
                      Align(
                        child: coloredText(
                          text: "user_type_text".tr,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 16.0.sp,
                        ),
                      ),
                      spaceY(5.0.h),
                      primaryBorderedButton(
                        onTap: () => Get.to(
                          () => const CompanyRegisterPage(),
                        ),
                        width: 75.0.w,
                        height: 40.sp,
                        text: coloredText(
                            text: "company".tr,
                            color: Theme.of(context).colorScheme.tertiary),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      spaceY(2.0.h),
                      primaryBorderedButton(
                        width: 75.0.w,
                        height: 40.sp,
                        text: coloredText(
                          text: "user".tr,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        color: Theme.of(context).colorScheme.tertiary,
                        onTap: () => Get.to(
                          () => const UserRegisterPage(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: -282.0.w,
            left: -95.0.w,
            child: Container(
              width: 300.0.w,
              height: 300.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: -288.0.w,
            left: -100.0.w,
            child: Container(
              width: 300.0.w,
              height: 300.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: -292.0.w,
            left: -105.0.w,
            child: Container(
              width: 300.0.w,
              height: 300.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ),
            ),
          ),
          PositionedDirectional(
            top: 40,
            start: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 22.0.sp,
              ),
            ),
          ),
          Positioned.fill(
            top: 40,
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: coloredText(
                text: "create_an_account".tr,
                color: Colors.white,
                fontSize: 16.0.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
