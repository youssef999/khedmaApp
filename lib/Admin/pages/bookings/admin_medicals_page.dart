import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/account%20statment/admin_account_statment_page.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

class AdminMedicalRequests extends StatefulWidget {
  const AdminMedicalRequests({super.key});

  @override
  State<AdminMedicalRequests> createState() => _AdminMedicalRequestsState();
}

class _AdminMedicalRequestsState extends State<AdminMedicalRequests> {
  AdminController _adminController = Get.find();
  @override
  void initState() {
    _adminController.getMedicals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ])),
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 15.h,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  coloredText(
                    text: "medical_exam".tr,
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                  spaceX(10)
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                width: 100.w,
                child: GetBuilder<AdminController>(builder: (c) {
                  return c.getmedicalsRequestsFlag
                      ? const Center(child: CircularProgressIndicator())
                      : c.medicalRequests.isEmpty
                          ? const NoItemsWidget()
                          : ListView.separated(
                              itemBuilder: (context, index) => Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffF8F8F8),
                                        ),
                                        child: Column(
                                          children: [
                                            depositLine(
                                                title: "applicant".tr,
                                                content: c
                                                    .medicalRequests[index]
                                                    .user!
                                                    .fullName!),
                                            spaceY(10.sp),
                                            GestureDetector(
                                              onTap: () async {
                                                if (Platform.isAndroid) {
                                                  var intent = AndroidIntent(
                                                    action:
                                                        'android.intent.action.SEND',
                                                    arguments: {
                                                      'android.intent.extra.SUBJECT':
                                                          'Medical Examination Request'
                                                    },
                                                    arrayArguments: {
                                                      'android.intent.extra.EMAIL':
                                                          [
                                                        c.medicalRequests[index]
                                                            .user!.email!
                                                      ],
                                                    },
                                                    package:
                                                        'com.google.android.gm',
                                                    type: 'message/rfc822',
                                                  );
                                                  intent.launch();
                                                }
                                              },
                                              child: depositLine(
                                                  title: "email".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  content: c
                                                      .medicalRequests[index]
                                                      .user!
                                                      .email!),
                                            ),
                                            spaceY(10.sp),
                                            depositLine(
                                              title: "date".tr,
                                              content: DateFormat(DateFormat
                                                      .YEAR_NUM_MONTH_DAY)
                                                  .format(
                                                DateTime.parse(
                                                  c.medicalRequests[index]
                                                      .createdAt!,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: 10,
                                        end: 5,
                                        child: Theme(
                                          data: ThemeData(
                                              primaryColor: Colors.white),
                                          child: PopupMenuButton(
                                            constraints: BoxConstraints(
                                              minWidth: 2.0 * 56.0,
                                              maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            itemBuilder: (BuildContext cc) => [
                                              PopupMenuItem<int>(
                                                value: 1,
                                                child: Row(
                                                  children: [
                                                    Icon(EvaIcons.trash2Outline,
                                                        size: 15.sp),
                                                    spaceX(5.sp),
                                                    coloredText(
                                                        text: 'delete'.tr,
                                                        fontSize: 12.0.sp),
                                                  ],
                                                ),
                                                onTap: () async {
                                                  bool b = await _adminController
                                                      .deleteMedical(
                                                          id: c
                                                              .medicalRequests[
                                                                  index]
                                                              .id!);
                                                  if (b) {
                                                    Utils.doneDialog(
                                                        context: context);
                                                  }
                                                },
                                              ),
                                            ],
                                            child: const Icon(
                                              EvaIcons.moreVertical,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                              separatorBuilder: (context, index) =>
                                  spaceY(10.sp),
                              itemCount: c.medicalRequests.length);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView tab1() => ListView(
        primary: false,
        children: [
          tabHeader(
              text1: "today".tr,
              text2: DateFormat('yyyy-MM-dd').format(DateTime.now())),
          spaceY(5.sp),
          tabBody(),
          spaceY(10.sp),
          tabHeader(
              text1: "yesterday".tr,
              text2: DateFormat('yyyy-MM-dd').format(DateTime.now())),
          spaceY(5.sp),
          tabBody(),
          spaceY(10.sp),
          tabHeader(
              text1: "before".tr,
              text2: DateFormat('yyyy-MM-dd').format(DateTime.now())),
          spaceY(5.sp),
          tabBody(),
          spaceY(10.sp),
        ],
      );

  ListView tabBody() => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List<Widget>.generate(
          3,
          (index) => Container(
            width: 100.w,
            height: 13.h,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60.w,
                  child: coloredText(
                      text: "Ahmed Khaled booked Sara Khaled for 2 years",
                      color: const Color(0xff707070),
                      fontSize: 12.sp),
                ),
                coloredText(
                  text: "500 KWD",
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      );

  Row tabHeader({
    required String text1,
    required String text2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        coloredText(text: text1, fontSize: 15.sp, fontWeight: FontWeight.w600),
        coloredText(text: text2),
      ],
    );
  }
}
