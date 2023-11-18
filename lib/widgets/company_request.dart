// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/ReservationRequestsViewPage.dart';
import 'package:khedma/Pages/HomePage/company%20home/emloyee_details.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/company%20home/request_files.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/company_request_model.dart';
import 'package:khedma/models/me.dart';
import 'package:khedma/models/reservation_model.dart';
import 'package:sizer/sizer.dart';

class CompanyRequestWidget extends StatelessWidget {
  CompanyRequestWidget(
      {super.key,
      required this.image,
      required this.userName,
      required this.employeeId,
      required this.docsId});
  final String image;
  final String userName;
  final int employeeId;
  final int docsId;
  final EmployeesController _employeesController = Get.find();
  final GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsetsDirectional.only(
          top: 20, bottom: 20, start: 20, end: 10),
      width: 100.w,
      // height: 42.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60.0.sp,
            height: 60.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            ),
          ),
          spaceX(10.sp),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(text: userName, fontSize: 14.sp),
              // spaceY(.sp),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${'finished_procedure_of'.tr} ",
                      style: coloredText(
                              text: "finished_procedure_of".tr,
                              fontSize: 13.sp,
                              color: const Color(0xff919191))
                          .style,
                    ),
                    TextSpan(
                      text: _employeesController.companyEmployees
                          .where((element) => element.id == employeeId)
                          .map((e) => Get.locale == const Locale('en', 'US')
                              ? e.nameEn!
                              : e.nameAr!)
                          .first,
                      style: coloredText(
                              text: "Sara Fady",
                              fontSize: 13.sp,
                              color: Theme.of(context).colorScheme.primary,
                              decoration: TextDecoration.underline)
                          .style,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          EmployeeModel? em =
                              await _employeesController.showCompanyEmployee(
                                  id: employeeId, indicator: true);
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
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     coloredText(
              //         text: "Finished the procedure of",
              //         fontSize: 13.sp,
              //         color: const Color(0xff919191)),
              //     coloredText(
              //         text: "Sara Fady",
              //         fontSize: 13.sp,
              //         color: Theme.of(context).colorScheme.primary,
              //         decoration: TextDecoration.underline),
              //   ],
              // ),

              spaceY(7.sp),
              primaryBorderedButton(
                onTap: () async {
                  DocumentModel? m = await _globalController.showDocs(
                      employeeId: employeeId, docsId: docsId);
                  if (m != null) {
                    Get.to(() => RequestFilesPage(documentModel: m));
                  }
                },
                alignment: AlignmentDirectional.centerStart,
                width: 25.w,
                height: 25.sp,
                radius: 20,
                text: coloredText(text: "view".tr, fontSize: 12.sp),
                color: const Color(0xff919191),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class ReservationRequestWidget extends StatelessWidget {
  ReservationRequestWidget({
    super.key,
    required this.reservationExtintionModel,
  });
  final ReservationExtintionModel reservationExtintionModel;
  final EmployeesController _employeesController = Get.find();
  final GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsetsDirectional.only(
          top: 20, bottom: 20, start: 20, end: 10),
      width: 100.w,
      // height: 42.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.0.sp,
            height: 40.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(reservationExtintionModel
                      .user!.userInformation!.personalPhoto!),
                  fit: BoxFit.cover),
            ),
          ),
          spaceX(10.sp),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                coloredText(
                    text: reservationExtintionModel.user!.fullName!,
                    fontSize: 14.sp),
                // spaceY(.sp),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${"reason".tr}: ${reservationExtintionModel.reason}\n",
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
                                reservationExtintionModel.employee!.id)
                            .map(
                              (e) => Get.locale == const Locale('en', 'US')
                                  ? e.nameEn!
                                  : e.nameAr!,
                            )
                            .first,
                        style: coloredText(
                                text: "Sara Fady",
                                fontSize: 13.sp,
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline)
                            .style,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            EmployeeModel? em =
                                await _employeesController.showCompanyEmployee(
                                    id: reservationExtintionModel.employee!.id!,
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
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     coloredText(
                //         text: "Finished the procedure of",
                //         fontSize: 13.sp,
                //         color: const Color(0xff919191)),
                //     coloredText(
                //         text: "Sara Fady",
                //         fontSize: 13.sp,
                //         color: Theme.of(context).colorScheme.primary,
                //         decoration: TextDecoration.underline),
                //   ],
                // ),

                spaceY(7.sp),
                primaryBorderedButton(
                  onTap: () async {
                    Get.to(() => ReservationRequestFilesPage(
                          reservationExtintionModel: reservationExtintionModel,
                        ));
                  },
                  alignment: AlignmentDirectional.centerStart,
                  width: 25.w,
                  height: 25.sp,
                  radius: 20,
                  text: coloredText(text: "view".tr, fontSize: 12.sp),
                  color: const Color(0xff919191),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CleanCompanyBookingWidget extends StatelessWidget {
  CleanCompanyBookingWidget({
    super.key,
    required this.cleaningBooking,
    this.approve = false,
  });
  final CleaningBooking cleaningBooking;
  final GlobalController _globalController = Get.find();
  final CompaniesController _companiesController = Get.find();
  bool approve = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsetsDirectional.only(
          top: 20, bottom: 20, start: 20, end: 10),
      width: 100.w,
      // height: 42.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.0.sp,
            height: 40.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      cleaningBooking.user!.userInformation!.personalPhoto!),
                  fit: BoxFit.cover),
            ),
          ),
          spaceX(10.sp),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(
                  text: cleaningBooking.user!.fullName!, fontSize: 14.sp),
              spaceY(5.sp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  coloredText(text: "${"order".tr}:", fontSize: 12.sp),
                  spaceX(5.sp),
                  Expanded(
                    child: coloredText(
                        text: cleaningBooking.order!
                            .map((e) =>
                                "${e.quantity} ${Get.locale == const Locale('en', 'US') ? e.services!.adminService!.nameEn! : e.services!.adminService!.nameAr!}")
                            .toList()
                            .join(", "),
                        fontSize: 11.sp),
                  ),
                ],
              ),
              spaceY(5.sp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  coloredText(text: "${"date".tr}:", fontSize: 12.sp),
                  spaceX(5.sp),
                  Expanded(
                    child: coloredText(
                        text: "${cleaningBooking.startDate} ", fontSize: 11.sp),
                  ),
                ],
              ),
              spaceY(5.sp),
              approve
                  ? Center(
                      child: coloredText(text: "approved", color: Colors.green),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        primaryBorderedButton(
                          onTap: () async {
                            bool b = await _globalController.approveCheckOut(
                                approve: 1, id: cleaningBooking.id!);
                            if (b) Utils.doneDialog(context: context);
                          },
                          alignment: AlignmentDirectional.centerStart,
                          width: 25.w,
                          height: 25.sp,
                          radius: 20,
                          text: coloredText(text: "accept".tr, fontSize: 12.sp),
                          color: const Color(0xff919191),
                        ),
                        primaryBorderedButton(
                          onTap: () async {
                            bool b = await _globalController.approveCheckOut(
                              approve: 0,
                              id: cleaningBooking.id!,
                            );
                            if (b) {
                              Utils.doneDialog(context: context);
                            }
                            // String desc = "";
                            // Utils.showDialogBox(
                            //   context: context,
                            //   actions: [
                            //     primaryButton(
                            //       onTap: () async {
                            //         Get.back();
                            //         bool b = await _globalController.approveCheckOut(
                            //           approve: 0,
                            //           id: cleaningBooking.id!,
                            //         );
                            //         if (b) {
                            //           Utils.doneDialog(context: context);
                            //           // ignore: use_build_context_synchronously
                            //           // Utils.customDialog(
                            //           //     actions: [
                            //           //       primaryButton(
                            //           //         onTap: () {
                            //           //           Get.back();
                            //           //           Get.back();
                            //           //         },
                            //           //         width: 40.0.w,
                            //           //         height: 50,
                            //           //         radius: 10.w,
                            //           //         color: Colors.black,
                            //           //         text: coloredText(
                            //           //           text: "ok".tr,
                            //           //           color: Colors.white,
                            //           //         ),
                            //           //       ),
                            //           //     ],
                            //           //     context: context,
                            //           //     child: Padding(
                            //           //       padding: const EdgeInsets.all(12.0),
                            //           //       child: Column(
                            //           //         crossAxisAlignment:
                            //           //             CrossAxisAlignment.center,
                            //           //         children: [
                            //           //           spaceY(20),
                            //           //           Icon(
                            //           //             EvaIcons.checkmarkCircle,
                            //           //             color: Theme.of(context)
                            //           //                 .colorScheme
                            //           //                 .secondary,
                            //           //             size: 40.sp,
                            //           //           ),
                            //           //           spaceY(20),
                            //           //           coloredText(
                            //           //               text:
                            //           //                   "your_note_have_been_sent".tr,
                            //           //               fontSize: 12.0.sp),
                            //           //           coloredText(
                            //           //             text: "successfully".tr,
                            //           //             fontSize: 14.0.sp,
                            //           //             color: Theme.of(context)
                            //           //                 .colorScheme
                            //           //                 .secondary,
                            //           //           ),
                            //           //         ],
                            //           //       ),
                            //           //     ));
                            //         }
                            //       },
                            //       color: Colors.black,
                            //       width: 45.w,
                            //       height: 50,
                            //       text: coloredText(
                            //           text: "submit".tr, color: Colors.white),
                            //     ),
                            //   ],
                            //   content: TextFormField(
                            //     onChanged: (value) {
                            //       desc = value;
                            //     },
                            //     maxLines: 5,
                            //     decoration: InputDecoration(
                            //       hintText: "write_your_notes".tr,
                            //       border: const OutlineInputBorder(
                            //         borderSide: BorderSide.none,
                            //         borderRadius: BorderRadius.all(
                            //           Radius.circular(10),
                            //         ),
                            //       ),
                            //       filled: true,
                            //       fillColor: Color(0xffF5F5F5),
                            //     ),
                            //   ),
                            //   title: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () => Get.back(),
                            //         child: const Icon(
                            //           EvaIcons.close,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // );
                          },
                          alignment: AlignmentDirectional.centerStart,
                          width: 25.w,
                          height: 25.sp,
                          radius: 20,
                          text: coloredText(text: "refuse".tr, fontSize: 12.sp),
                          color: const Color(0xff919191),
                        ),
                      ],
                    ),
            ],
          ))
        ],
      ),
    );
  }
}
