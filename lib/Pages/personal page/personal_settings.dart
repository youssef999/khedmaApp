// ignore_for_file: must_be_immutable

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/admin_profile_edit.dart';
import 'package:khedma/Pages/HomePage/company%20home/company_contracts.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/controller/auth_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/login_page.dart';
import 'package:khedma/Pages/personal%20page/about_page.dart';
import 'package:khedma/Pages/personal%20page/company_profile_edit.dart';
import 'package:khedma/Pages/personal%20page/contact_us_page.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import './languages.dart';
import './password_change.dart';
import './profile_edit.dart';
import '../../Utils/utils.dart';

class PersonalSettings extends StatefulWidget {
  const PersonalSettings({super.key, required this.userType});
  final String userType;
  @override
  State<PersonalSettings> createState() => _PersonalSettingsState();
}

class _PersonalSettingsState extends State<PersonalSettings> {
  GlobalController _globalController = Get.find();
  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              Utils.takeContainer(controller, "settings.png");
            },
            child: coloredText(text: "settings".tr, fontSize: 15.0.sp),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                spaceY(20),
                primaryBorderedButton(
                  onTap: () {
                    if (widget.userType == "company") {
                      Get.to(() => const CompanyProfileEditPage());
                    } else if (widget.userType == "user") {
                      Get.to(() => ProfileEditPage(userType: widget.userType));
                    } else {
                      Get.to(() => const AdminProfileEditPage());
                    }
                  },
                  width: 100.w,
                  text: Row(
                    children: [
                      spaceX(10),
                      Icon(
                        EvaIcons.personOutline,
                        size: 18.0.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      spaceX(10),
                      coloredText(
                        color: const Color(0xff919191),
                        text: "edit_profile".tr,
                      ),
                    ],
                  ),
                  color: const Color(0xffE9E9E9),
                ),
                spaceY(20),
                primaryBorderedButton(
                  onTap: () {
                    Get.to(
                      () => LanguagesPage(),
                    );
                  },
                  width: 100.w,
                  text: Row(
                    children: [
                      spaceX(10),
                      Icon(
                        Icons.g_translate_outlined,
                        size: 18.0.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      spaceX(10),
                      coloredText(
                        color: const Color(0xff919191),
                        text: "language".tr,
                      ),
                    ],
                  ),
                  color: const Color(0xffE9E9E9),
                ),
                spaceY(20),
                primaryBorderedButton(
                  onTap: () {
                    Get.to(
                      () => const PasswordChangePage(),
                    );
                  },
                  width: 100.w,
                  text: Row(
                    children: [
                      spaceX(10),
                      Icon(
                        Icons.lock_outline,
                        size: 18.0.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      spaceX(10),
                      coloredText(
                        color: const Color(0xff919191),
                        text: "change_password".tr,
                      ),
                    ],
                  ),
                  color: const Color(0xffE9E9E9),
                ),
                spaceY(20),
                primaryBorderedButton(
                  onTap: () {
                    Utils.customDialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: coloredText(
                            fontSize: 15.sp,
                            textAlign: TextAlign.center,
                            text: "protect_with_fingerprint".tr,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      context: context,
                      actions: [
                        primaryButton(
                          onTap: () async {
                            Get.back();

                            await Utils.saveFingerprint(fingerpring: "active");
                            Utils.doneDialog(context: context);
                          },
                          text: coloredText(
                            text: "active".tr,
                            color: Colors.white,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        primaryBorderedButton(
                          onTap: () async {
                            Get.back();

                            await Utils.deleteFingerprint();
                            Utils.doneDialog(context: context);
                          },
                          text: coloredText(
                            text: "disable".tr,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    );
                  },
                  width: 100.w,
                  text: Row(
                    children: [
                      spaceX(10),
                      Icon(
                        Icons.fingerprint,
                        size: 18.0.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      spaceX(10),
                      coloredText(
                        color: const Color(0xff919191),
                        text: "fingerprint".tr,
                      ),
                    ],
                  ),
                  color: const Color(0xffE9E9E9),
                ),
                if (_globalController.me.userType == 'user') spaceY(20),
                if (_globalController.me.userType == 'user')
                  primaryBorderedButton(
                    onTap: () {
                      Utils.showDialogBox(
                          context: context,
                          actions: [
                            primaryButton(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                Get.back();
                              },
                              width: 40.0.w,
                              height: 50,
                              radius: 10.w,
                              color: Colors.black,
                              text: coloredText(
                                text: "save".tr,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              coloredText(text: "currency".tr),
                              spaceY(5.sp),
                              CustomDropDownMenuButtonV2(
                                hintPadding: 0,
                                focusNode: FocusNode(),
                                value: _globalController.currencySymbol.key,
                                fillColor: const Color(0xffF8F8F8),
                                filled: true,
                                width: 100.w,
                                items: _globalController.currencySymbols
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e.key,
                                        child: coloredText(
                                            text: e.value, color: Colors.black),
                                      ),
                                    )
                                    .toList(),
                                border: null,
                                onChanged: (p0) {
                                  _globalController.convertCurrency(
                                      from: "KWD", to: p0!, amount: "1");
                                },
                                borderRadius: 10,
                              ),
                            ],
                          ));
                    },
                    width: 100.w,
                    text: Row(
                      children: [
                        spaceX(10),
                        Icon(
                          Icons.currency_exchange_rounded,
                          size: 18.0.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        spaceX(10),
                        coloredText(
                          color: const Color(0xff919191),
                          text: "currency".tr,
                        ),
                      ],
                    ),
                    color: const Color(0xffE9E9E9),
                  ),
                if (_globalController.me.userType == 'company') spaceY(20),
                if (_globalController.me.userType == 'company')
                  primaryBorderedButton(
                    onTap: () {
                      Get.to(() => const CompanyDocsPage(
                            readOnly: true,
                          ));
                    },
                    width: 100.w,
                    text: Row(
                      children: [
                        spaceX(10),
                        Icon(
                          EvaIcons.fileOutline,
                          size: 18.0.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        spaceX(10),
                        coloredText(
                          color: const Color(0xff919191),
                          text: "contracts".tr,
                        ),
                      ],
                    ),
                    color: const Color(0xffE9E9E9),
                  ),
                if (widget.userType != "admin") spaceY(20),
                if (widget.userType != "admin")
                  primaryBorderedButton(
                    onTap: () {
                      Get.to(() => ContactUsPage());
                    },
                    width: 100.w,
                    text: Row(
                      children: [
                        spaceX(10),
                        Icon(
                          EvaIcons.messageCircleOutline,
                          size: 18.0.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        spaceX(10),
                        coloredText(
                          color: const Color(0xff919191),
                          text: "contact".tr,
                        ),
                      ],
                    ),
                    color: const Color(0xffE9E9E9),
                  ),
                if (widget.userType != "admin") spaceY(20),
                if (widget.userType != "admin")
                  primaryBorderedButton(
                    onTap: () {
                      Get.to(() => AboutPage());
                    },
                    width: 100.w,
                    text: Row(
                      children: [
                        spaceX(10),
                        Icon(
                          Icons.info_outline,
                          size: 18.0.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        spaceX(10),
                        coloredText(
                          color: const Color(0xff919191),
                          text: "about_app".tr,
                        ),
                      ],
                    ),
                    color: const Color(0xffE9E9E9),
                  ),
                if (widget.userType != "admin") spaceY(20),
                if (widget.userType != "admin")
                  primaryBorderedButton(
                    onTap: () async {
                      await Utils.deleteToken();
                      await Utils.deleteRemmemberMe();
                      await Utils.deleteFBToken();
                      Get.offAll(() => const LoginPage());
                      AuthController _authController = Get.find();
                      _authController.handleSignOut();
                    },
                    width: 100.w,
                    text: Row(
                      children: [
                        spaceX(10),
                        Icon(
                          EvaIcons.logOut,
                          size: 18.0.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        spaceX(10),
                        coloredText(
                          color: const Color(0xff919191),
                          text: "logout".tr,
                        ),
                      ],
                    ),
                    color: const Color(0xffE9E9E9),
                  ),
                if (widget.userType != "admin") spaceY(20),
                if (widget.userType != "admin")
                  primaryBorderedButton(
                    onTap: () async {
                      Utils.showDialogBox(
                        context: context,
                        title: Center(
                          child: coloredText(
                            fontSize: 19.sp,
                            // fontWeight: FontWeight.w600,
                            text: "are_you_sure".tr,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        actions: [
                          primaryButton(
                            onTap: () async {
                              bool b = await _globalController.deleteAccount();
                              if (b) {
                                Get.back();
                                await Utils.deleteToken();
                                await Utils.deleteRemmemberMe();
                                await Utils.deleteFBToken();
                                Get.offAll(() => const LoginPage());
                                AuthController _authController = Get.find();
                                _authController.handleSignOut();
                              }
                            },
                            text: coloredText(
                              text: "yes".tr,
                              color: Colors.white,
                            ),
                            color: Colors.red.shade400,
                          ),
                          spaceY(10.sp),
                          primaryBorderedButton(
                            onTap: () async {
                              Get.back();
                            },
                            text: coloredText(
                              text: "no".tr,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      );
                    },
                    width: 100.w,
                    text: Row(
                      children: [
                        spaceX(10),
                        Icon(
                          EvaIcons.trash2,
                          size: 18.0.sp,
                          color: Colors.red.shade400,
                        ),
                        spaceX(10),
                        coloredText(
                          color: Colors.red.shade400,
                          text: "delete_account".tr,
                        ),
                      ],
                    ),
                    color: Colors.red.shade400,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
