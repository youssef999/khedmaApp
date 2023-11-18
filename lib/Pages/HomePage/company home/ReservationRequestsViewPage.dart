// ignore_for_file: use_build_context_synchronously

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/emloyee_details.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/models/reservation_model.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class ReservationRequestFilesPage extends StatefulWidget {
  const ReservationRequestFilesPage(
      {super.key, required this.reservationExtintionModel});
  final ReservationExtintionModel reservationExtintionModel;
  @override
  State<ReservationRequestFilesPage> createState() =>
      _ReservationRequestFilesPageState();
}

class _ReservationRequestFilesPageState
    extends State<ReservationRequestFilesPage> {
  final EmployeesController _employeesController = Get.find();
  final GlobalController _globalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(text: "show_files".tr, fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 85.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    spaceY(2.h),
                    GestureDetector(
                      onTap: () async {
                        Uri x =
                            Uri.parse(widget.reservationExtintionModel.file);
                        await launchUrl(x,
                            mode: LaunchMode.externalApplication);
                      },
                      child: Image(
                        image:
                            NetworkImage(widget.reservationExtintionModel.file),
                        width: 150.sp,
                        height: 150.sp,
                        fit: BoxFit.contain,
                      ),
                    ),
                    spaceY(10.sp),
                    coloredText(
                        text: widget.reservationExtintionModel.user!.fullName!,
                        fontSize: 14.sp),
                    // spaceY(.sp),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${"reason".tr}: ${widget.reservationExtintionModel.reason}\n",
                            style: coloredText(
                                    text: "finished_procedure_of".tr,
                                    fontSize: 12.sp,
                                    color: const Color(0xff919191))
                                .style,
                          ),
                          TextSpan(
                            text: _employeesController.companyEmployees
                                .where((element) =>
                                    element.id ==
                                    widget
                                        .reservationExtintionModel.employee!.id)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn
                                        : e.nameAr)
                                .first,
                            style: coloredText(
                                    text: "Sara Fady",
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline)
                                .style,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                EmployeeModel? em = await _employeesController
                                    .showCompanyEmployee(
                                        id: widget.reservationExtintionModel
                                            .employee!.id!,
                                        indicator: true);
                                if (em != null) {
                                  Get.to(() => EmployeeDetailsPage(
                                        employee: em,
                                      ));
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    primaryButton(
                      onTap: () async {
                        bool b =
                            await _globalController.approveReservationExtension(
                                approve: 1,
                                id: widget.reservationExtintionModel.id!);
                        if (b) Utils.doneDialog(context: context, backTimes: 2);
                      },
                      color: Colors.black,
                      width: 43.w,
                      height: 50,
                      text: coloredText(text: "accept".tr, color: Colors.white),
                    ),
                    primaryButton(
                      onTap: () async {
                        String desc = "";
                        Utils.showDialogBox(
                          context: context,
                          actions: [
                            primaryButton(
                              onTap: () async {
                                Get.back();
                                bool b = await _globalController
                                    .approveReservationExtension(
                                        approve: 0,
                                        id: widget
                                            .reservationExtintionModel.id!,
                                        desc: desc);
                                if (b) {
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
                                          color: Colors.black,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                text: "your_note_have_been_sent"
                                                    .tr,
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
                              color: Colors.black,
                              width: 45.w,
                              height: 50,
                              text: coloredText(
                                  text: "submit".tr, color: Colors.white),
                            ),
                          ],
                          content: TextFormField(
                            onChanged: (value) {
                              desc = value;
                            },
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "write_your_notes".tr,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xffF5F5F5),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  EvaIcons.close,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      width: 43.w,
                      height: 50,
                      color: const Color(0xffEEEEEE),
                      text: coloredText(
                        text: "refuse".tr,
                        color: const Color(0xff919191),
                      ),
                    )
                  ],
                ),
                spaceY(2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
