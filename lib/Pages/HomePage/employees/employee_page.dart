// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart' as db;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/emloyee_details.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/invooice/invoice_page.dart';
import 'package:khedma/Pages/personal%20page/submit_files_page.dart';
import 'package:khedma/web_view_container.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class EmployeePage extends StatefulWidget {
  EmployeePage({
    super.key,
    required this.employeeModel,
  });
  EmployeeModel employeeModel;
  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  // List<JobModel?> jobs = [];
  GlobalController _globalController = Get.find();
  EmployeesController _employeesController = Get.find();
  String invoiceId = "12314";
  bool contractFlag = false;
  File? file;
  String uploadText = "";

  @override
  void initState() {
    // jobs = widget.employeeModel.jobs!;

    if (widget.employeeModel.status != null &&
        widget.employeeModel.status!.status == "pending") contractFlag = true;
    super.initState();
  }

  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
          body: Column(
        children: [
          ClipPath(
            // clipper: OvalBottomBorderClipper(),
            clipper: Clipp(),
            child: Container(
              padding: EdgeInsetsDirectional.only(
                  start: 8.0.sp, end: 8.0.sp, top: 25.0.sp, bottom: 8.0.sp),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: AlignmentDirectional.bottomStart,
                end: AlignmentDirectional.topEnd,
                stops: [0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1],
                colors: [
                  Color(0xff225153),
                  Color(0xff24615E),
                  Color(0xff257169),
                  Color(0xff278274),
                  Color(0xff28927E),
                  Color(0xff2AA289),
                  Color(0xff2BB294),
                ],
              )),
              width: 100.0.w,
              // height: contractFlag ? 48.0.h : 40.0.h,
              height: 240.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22.0.sp,
                        ),
                      ),
                      widget.employeeModel.status != null &&
                              (widget.employeeModel.status!.status ==
                                      "booked" ||
                                  widget.employeeModel.status!.status ==
                                      "pending")
                          ? Theme(
                              data: ThemeData(primaryColor: Colors.white),
                              child: PopupMenuButton(
                                constraints: BoxConstraints(
                                  minWidth: 2.0 * 56.0,
                                  maxWidth: MediaQuery.of(context).size.width,
                                ),
                                itemBuilder: (BuildContext ctx) => [
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: coloredText(
                                        text: 'invoice'.tr, fontSize: 11.0.sp),
                                    onTap: () {
                                      Future(
                                        () => Get.to(
                                          () => InvoicePage(
                                            invoiceId: invoiceId,
                                            companyId: widget
                                                .employeeModel.company!.id!,
                                            employeeName: Get.locale ==
                                                    const Locale('en', 'US')
                                                ? widget.employeeModel.nameEn!
                                                : widget.employeeModel.nameAr!,
                                            contractDuration: widget
                                                .employeeModel
                                                .contractDuration!,
                                            contractAmount: widget
                                                .employeeModel.contractAmount!,
                                            isOffer:
                                                widget.employeeModel.isOffer!,
                                            contractAmountAfterDiscount:
                                                widget.employeeModel.isOffer ==
                                                        1
                                                    ? widget.employeeModel
                                                        .amountAfterDiscount!
                                                    : -1,
                                            userName:
                                                _globalController.me.fullName!,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: coloredText(
                                        text: 'passport'.tr, fontSize: 11.0.sp),
                                    onTap: () async {
                                      await _prepareSaveDir();

                                      await FlutterDownloader.enqueue(
                                        url: widget.employeeModel.passportImege,
                                        fileName:
                                            "${widget.employeeModel.nameEn!} passport",
                                        savedDir: _localPath,
                                        saveInPublicStorage: true,
                                        showNotification:
                                            true, // show download progress in status bar (for Android)
                                        openFileFromNotification:
                                            true, // click on notification to open downloaded file (for Android)
                                      );
                                    },
                                  ),
                                  PopupMenuItem<int>(
                                    value: 3,
                                    child: coloredText(
                                        text: 'final_contract'.tr,
                                        fontSize: 12.0.sp),
                                    onTap: () async {
                                      String? token = await Utils.readToken();

                                      Utils.circularIndicator();
                                      var res = await Dio().get(
                                        widget.employeeModel.finalContract ??
                                            'https://www.google.com',
                                        options: Options(
                                          headers: {
                                            "Accept": "application/json",
                                            "Authorization": "Bearer $token"
                                          },
                                        ),
                                      );
                                      Get.back();
                                      await Printing.layoutPdf(
                                          format: PdfPageFormat.a3,
                                          name:
                                              "${widget.employeeModel.nameEn!} Triple recruitment contract",
                                          onLayout:
                                              (PdfPageFormat format) async =>
                                                  await Printing.convertHtml(
                                                    format: format,
                                                    html: res.data,
                                                  ));
                                    },
                                  ),
                                  PopupMenuItem<int>(
                                    value: 4,
                                    child: coloredText(
                                        text: 'contract'.tr, fontSize: 12.0.sp),
                                    onTap: () async {
                                      String? token = await Utils.readToken();
                                      logSuccess(widget
                                          .employeeModel.residenceContract!);
                                      logSuccess(token!);
                                      Utils.circularIndicator();
                                      var res = await Dio().get(
                                        widget.employeeModel.residenceContract!,
                                        options: Options(
                                          headers: {
                                            "Accept": "application/json",
                                            "Authorization": "Bearer $token"
                                          },
                                        ),
                                      );
                                      Get.back();
                                      await Printing.layoutPdf(
                                          format: PdfPageFormat.a3,
                                          name:
                                              "${widget.employeeModel.nameEn!} Ministry of Interior contract",
                                          onLayout:
                                              (PdfPageFormat format) async =>
                                                  await Printing.convertHtml(
                                                    format: format,
                                                    html: res.data,
                                                  ));
                                    },
                                  ),
                                  if (contractFlag)
                                    PopupMenuItem<int>(
                                      value: 4,
                                      child: coloredText(
                                          text: 'refund'.tr, fontSize: 12.0.sp),
                                      onTap: () async {
                                        String desc = "";
                                        Utils.customDialog(
                                            context: context,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: StatefulBuilder(
                                                  builder: (c, s) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () =>
                                                              Get.back(),
                                                          child: const Icon(
                                                            EvaIcons.close,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    coloredText(
                                                        text: "desc".tr,
                                                        fontSize: 12.0.sp),
                                                    spaceY(20),
                                                    SendMessageTextField(
                                                      maxLength: 150,
                                                      focusNode: FocusNode(),
                                                      fillColor:
                                                          Colors.transparent,
                                                      wholeBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xffC7C7C7),
                                                        ),
                                                      ),
                                                      onchanged: (s) {
                                                        if (s != null) desc = s;
                                                      },
                                                    ),
                                                    spaceY(20),
                                                    db.DottedBorder(
                                                      dashPattern: const [
                                                        8,
                                                        8,
                                                        8,
                                                        8
                                                      ],
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      radius:
                                                          const Radius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xffC7C7C7),
                                                      borderType:
                                                          db.BorderType.RRect,
                                                      child: primaryButton(
                                                        radius: 10,
                                                        onTap: () async {
                                                          FilePickerResult?
                                                              result =
                                                              await FilePicker
                                                                  .platform
                                                                  .pickFiles(
                                                                      allowMultiple:
                                                                          false);

                                                          // XFile? image = await Utils()
                                                          //     .selectImageSheet();

                                                          // if (image != null) {
                                                          //   file = image;
                                                          //   uploadText = image.name;

                                                          //   s(() {});
                                                          //   setState(() {});
                                                          // }

                                                          if (result != null) {
                                                            file = File(result
                                                                .files
                                                                .single
                                                                .path!);

                                                            uploadText = result
                                                                .files
                                                                .single
                                                                .name;

                                                            s(() {});
                                                            setState(() {});
                                                          }
                                                        },
                                                        width: 100.0.w,
                                                        height: 15.h,
                                                        color: const Color(
                                                                0xffC7C7C7)
                                                            .withOpacity(0.1),
                                                        text: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              EvaIcons
                                                                  .cloudUploadOutline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              size: 40.sp,
                                                            ),
                                                            if (uploadText !=
                                                                "")
                                                              spaceY(10),
                                                            if (uploadText !=
                                                                "")
                                                              Align(
                                                                child:
                                                                    coloredText(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text: uploadText
                                                                              .length >
                                                                          15
                                                                      ? "${uploadText.substring(0, 15)}..."
                                                                      : uploadText,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    spaceY(20),
                                                    primaryButton(
                                                      onTap: () async {
                                                        DesFile tmp =
                                                            DesFile(desc, file);
                                                        Get.back();
                                                        file = null;
                                                        uploadText = "";

                                                        bool b = await _globalController
                                                            .requestRefund(
                                                                desFile: tmp,
                                                                employeeID: widget
                                                                    .employeeModel
                                                                    .id!);

                                                        if (b) {
                                                          Utils.doneDialog(
                                                              context: context);
                                                        }
                                                        s(() {});
                                                        setState(() {});
                                                      },
                                                      width: 40.0.w,
                                                      radius: 10.w,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      text: coloredText(
                                                        text: "submit".tr,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ));
                                      },
                                    ),
                                ],
                                child: const Icon(
                                  EvaIcons.moreVertical,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  spaceY(1.0.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Utils.takeContainer(controller, "employee_page.png");
                        },
                        child: Container(
                          width: 75.0.sp,
                          height: 75.0.sp,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0.w),
                            image: DecorationImage(
                              image: NetworkImage(widget.employeeModel.image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      spaceX(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            coloredText(
                                text: Get.locale == const Locale('en', 'US')
                                    ? widget.employeeModel.nameEn!
                                    : widget.employeeModel.nameAr!,
                                color: Colors.white,
                                fontSize: 15.0.sp),
                            spaceY(5.sp),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff020404).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: coloredText(
                                  textDirection: TextDirection.ltr,
                                  text: widget.employeeModel.isOffer != 1
                                      ? "${(double.parse(widget.employeeModel.contractAmount!) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key} /${"${widget.employeeModel.contractDuration!} years"}"
                                      : "${(widget.employeeModel.amountAfterDiscount! * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key} /${"${widget.employeeModel.contractDuration!} ${"year".tr}"}",
                                  color: Colors.white,
                                  fontSize: 9.0.sp),
                            ),
                            spaceY(5.sp),
                            // SizedBox(
                            //   height: 25,
                            //   child: ListView.separated(
                            //     shrinkWrap: true,
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (BuildContext context, int index) =>
                            //         Container(
                            //       padding: const EdgeInsets.symmetric(
                            //           vertical: 2, horizontal: 20),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(15),
                            //         // color: const Color(0xffF8F8F8),
                            //         border: Border.all(
                            //           color: const Color(0xffE8E8E8),
                            //         ),
                            //       ),
                            //       child: coloredText(
                            //         text: Get.locale == const Locale('en', 'US')
                            //             ? jobs[index]!.nameEn!
                            //             : jobs[index]!.nameAr!,
                            //         color: const Color(0xffE8E8E8),
                            //         fontSize: 11.0.sp,
                            //       ),
                            //     ),
                            //     itemCount: jobs.length,
                            //     separatorBuilder:
                            //         (BuildContext context, int index) =>
                            //             spaceX(5),
                            //   ),
                            // ),
                            // spaceY(5.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  EvaIcons.pin,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 13.0.sp,
                                ),
                                spaceX(3),
                                coloredText(
                                  text: Get.locale == const Locale('en', 'US')
                                      ? _globalController.countries
                                          .where((element) =>
                                              element.id ==
                                              widget
                                                  .employeeModel.nationalityId!)
                                          .first
                                          .nameEn!
                                      : _globalController.countries
                                          .where((element) =>
                                              element.id ==
                                              widget
                                                  .employeeModel.nationalityId!)
                                          .first
                                          .nameAr!,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12.0.sp,
                                ),
                              ],
                            ),
                            spaceY(5.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  EvaIcons.heart,
                                  color: const Color(0xffD4D4D4),
                                  size: 13.0.sp,
                                ),
                                spaceX(5),
                                coloredText(
                                  text: Get.locale == const Locale('en', 'US')
                                      ? _globalController.maritalStatusList
                                          .where((element) =>
                                              element.id ==
                                              widget
                                                  .employeeModel.maritalStatus!)
                                          .first
                                          .nameEn!
                                      : _globalController.maritalStatusList
                                          .where((element) =>
                                              element.id ==
                                              widget
                                                  .employeeModel.maritalStatus!)
                                          .first
                                          .nameAr!,
                                  fontSize: 12.0.sp,
                                  color: const Color(0xffD4D4D4),
                                ),
                              ],
                            ),
                            spaceY(5.sp),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Icon(
                            //       Icons.g_translate_rounded,
                            //       color: const Color(0xffD4D4D4),
                            //       size: 13.0.sp,
                            //     ),
                            //     spaceX(5),
                            //     coloredText(
                            //       text: widget.employeeModel.languages!
                            //           .map((e) =>
                            //               Get.locale == const Locale('en', 'US')
                            //                   ? e.nameEn!
                            //                   : e.nameAr!)
                            //           .toList()
                            //           .join(", "),
                            //       fontSize: 12.0.sp,
                            //       color: const Color(0xffD4D4D4),
                            //     ),
                            //   ],
                            // ),
                            // spaceY(5.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  EvaIcons.person,
                                  color: const Color(0xffD4D4D4),
                                  size: 13.0.sp,
                                ),
                                spaceX(5),
                                coloredText(
                                  text:
                                      "${Utils.age(DateTime.now(), DateTime.parse(widget.employeeModel.dateOfBirth!))} ${"years".tr}",
                                  fontSize: 12.0.sp,
                                  color: const Color(0xffD4D4D4),
                                ),
                              ],
                            ),
                            spaceY(15),
                            widget.employeeModel.status != null &&
                                    widget.employeeModel.status!.status ==
                                        "booked"
                                ? Container()
                                : widget.employeeModel.status != null &&
                                        widget.employeeModel.status!.status ==
                                            "pending"
                                    ? primaryButton(
                                        onTap: widget.employeeModel.document ==
                                                    null ||
                                                widget.employeeModel.document!
                                                        .approve ==
                                                    null ||
                                                widget.employeeModel.document!
                                                        .approve ==
                                                    0
                                            ? null
                                            : () async {
                                                Map<String, String>? x =
                                                    await _employeesController
                                                        .bookEmployee(
                                                            id: widget
                                                                .employeeModel
                                                                .document!
                                                                .id!);
                                                if (x != null) {
                                                  invoiceId = x.keys.first;
                                                  Get.to(() => WebViewContainer(
                                                            url: x.values.first,
                                                          ))!
                                                      .then((value) async {
                                                    EmployeeModel? b =
                                                        await _employeesController
                                                            .showMyEmployee(
                                                                id: widget
                                                                    .employeeModel
                                                                    .id!,
                                                                indicator:
                                                                    true);
                                                    if (b != null) {
                                                      widget.employeeModel = b;
                                                      if (widget.employeeModel
                                                                  .status !=
                                                              null &&
                                                          widget
                                                                  .employeeModel
                                                                  .status!
                                                                  .status ==
                                                              "pending") {
                                                        contractFlag = true;
                                                      } else {
                                                        contractFlag = false;
                                                      }
                                                      setState(() {});
                                                      Utils.doneDialog(
                                                          context: context);
                                                      await _globalController
                                                          .getMe();
                                                    }
                                                  });

                                                  // Uri url =
                                                  //     Uri.parse(x.values.first);
                                                  // logSuccess(x);
                                                  // await launchUrl(url,
                                                  //     mode: LaunchMode
                                                  //         .externalApplication);

                                                  // await Future.delayed(Duration(
                                                  //     milliseconds: 100));
                                                  // while (WidgetsBinding.instance
                                                  //         .lifecycleState !=
                                                  //     AppLifecycleState.resumed) {
                                                  //   await Future.delayed(Duration(
                                                  //       milliseconds: 100));
                                                  // }
                                                }

                                                // Get.to(() => PayPage(),
                                                //     );

                                                // else {
                                                //   Get.to(() => const FillingDataPage(),
                                                //       transition: Transition.downToUp);
                                                // }
                                              },
                                        text: coloredText(
                                            text: "pay".tr,
                                            color: Colors.white,
                                            fontSize: 12.0.sp),
                                        color: widget.employeeModel.document ==
                                                    null ||
                                                widget.employeeModel.document!
                                                        .approve ==
                                                    null ||
                                                widget.employeeModel.document!
                                                        .approve ==
                                                    0
                                            ? Colors.grey
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        width: 40.0.w,
                                        height: 30.0.sp,
                                        radius: 20,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                      )
                                    : primaryButton(
                                        onTap: () async {
                                          if (_globalController.guest) {
                                            Utils.loginFirstDialoge(
                                                context: context);
                                          } else {
                                            String? x =
                                                await _employeesController
                                                    .pendingEmployee(
                                                        id: widget
                                                            .employeeModel.id!);
                                            if (x != null) {
                                              Get.to(() => WebViewContainer(
                                                        url: x,
                                                      ))!
                                                  .then((value) async {
                                                EmployeeModel? b =
                                                    await _employeesController
                                                        .showMyEmployee(
                                                            id: widget
                                                                .employeeModel
                                                                .id!,
                                                            indicator: true);
                                                if (b != null) {
                                                  widget.employeeModel = b;
                                                  if (widget.employeeModel
                                                              .status !=
                                                          null &&
                                                      widget.employeeModel
                                                              .status!.status ==
                                                          "pending") {
                                                    contractFlag = true;
                                                  } else {
                                                    contractFlag = false;
                                                  }
                                                  Utils.doneDialog(
                                                      context: context);
                                                  _globalController.getMe();
                                                  _globalController
                                                      .getUserHomePage();
                                                  Utils().rateDialoge(
                                                      context: context,
                                                      companyId: widget
                                                          .employeeModel
                                                          .companyId!);
                                                  setState(() {});
                                                }
                                              });
                                              // Uri url = Uri.parse(x);
                                              // logSuccess(x);
                                              // await launchUrl(url,
                                              //     mode: LaunchMode
                                              //         .externalApplication);

                                              // await Future.delayed(
                                              //     Duration(milliseconds: 100));
                                              // while (WidgetsBinding
                                              //         .instance.lifecycleState !=
                                              //     AppLifecycleState.resumed) {
                                              //   await Future.delayed(
                                              //       Duration(milliseconds: 100));
                                              // }
                                            }
                                          }
                                        },
                                        text: coloredText(
                                            text: "book".tr,
                                            color: Colors.white,
                                            fontSize: 12.0.sp),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 40.0.w,
                                        height: 30.0.sp,
                                        radius: 20,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                      ),
                            // Container(
                            //   width: 40.0.w,
                            //   height: 40,
                            //   margin: EdgeInsets.symmetric(horizontal: 1.0.w),
                            //   decoration: BoxDecoration(
                            //       color: Theme.of(context).colorScheme.secondary,
                            //       borderRadius: BorderRadius.circular(20),
                            //       border: Border.all(
                            //         color: Colors.transparent,
                            //       )),
                            //   child: Center(
                            //     child: coloredText(
                            //         text: "Book",
                            //         color: Colors.white,
                            //         fontSize: 12.0.sp),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // !contractFlag ? Container() : spaceY(10.sp),
                  // !contractFlag
                  //     ? Container()
                  //     : Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           primaryButton(
                  //             onTap: () async {
                  //               await _prepareSaveDir();

                  //               await FlutterDownloader.enqueue(
                  //                 url: widget.employeeModel.passportImege,
                  //                 fileName:
                  //                     "${widget.employeeModel.nameEn!} passport",
                  //                 savedDir: _localPath,
                  //                 saveInPublicStorage: true,
                  //                 showNotification:
                  //                     true, // show download progress in status bar (for Android)
                  //                 openFileFromNotification:
                  //                     true, // click on notification to open downloaded file (for Android)
                  //               );
                  //             },
                  //             text: coloredText(
                  //                 text: "passport".tr,
                  //                 color: Colors.white,
                  //                 fontSize: 12.0.sp),
                  //             color: Theme.of(context).colorScheme.secondary,
                  //             width: 40.0.w,
                  //             height: 30.0.sp,
                  //             radius: 20,
                  //             alignment: AlignmentDirectional.centerStart,
                  //           ),
                  //           primaryButton(
                  //             onTap: () async {
                  //               String? token = await Utils.readToken();

                  //               Utils.circularIndicator();
                  //               var res = await Dio().get(
                  //                 widget.employeeModel.residenceContract!,
                  //                 options: Options(
                  //                   headers: {
                  //                     "Accept": "application/json",
                  //                     "Authorization": "Bearer $token"
                  //                   },
                  //                 ),
                  //               );
                  //               Get.back();
                  //               await Printing.layoutPdf(
                  //                   format: PdfPageFormat.a3,
                  //                   name:
                  //                       "${widget.employeeModel.nameEn!} contract",
                  //                   onLayout: (PdfPageFormat format) async =>
                  //                       await Printing.convertHtml(
                  //                         format: format,
                  //                         html: res.data,
                  //                       ));
                  //             },
                  //             text: coloredText(
                  //                 text: "contract".tr,
                  //                 color: Colors.white,
                  //                 fontSize: 12.0.sp),
                  //             color: Theme.of(context).colorScheme.secondary,
                  //             width: 40.0.w,
                  //             height: 30.0.sp,
                  //             radius: 20,
                  //             alignment: AlignmentDirectional.centerStart,
                  //           ),
                  //         ],
                  //       ),
                ],
              ),
            ),
          ),
          // spaceY(1.0.h),
          Expanded(
            child: ListView(
              primary: false,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              children: [
                coloredText(
                  text: (Get.locale == const Locale('en', 'US')
                          ? "${widget.employeeModel.nameEn!} ${"data".tr}"
                          : "${"data".tr} ${widget.employeeModel.nameAr!}")
                      .tr,
                  fontWeight: FontWeight.bold,
                ),
                const Divider(
                  color: Color(0xffDBDBDB),
                ),
                coloredText(
                  text: "passport_data".tr,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
                spaceY(10.sp),
                DetailsItemWidget(
                  title1: "passport_number".tr,
                  subTitle1: widget.employeeModel.passportNum,
                  title2: "issue_date".tr,
                  subTitle2: widget.employeeModel.passportIssueDate,
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  title1: "issue_place".tr,
                  subTitle1: _globalController.countries
                      .where((element) =>
                          element.id ==
                          widget.employeeModel.passportPlaceOfIssue)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                  title2: "expiry_date".tr,
                  subTitle2: widget.employeeModel.passportExpiryDate,
                ),
                spaceY(10.sp),
                Divider(),
                coloredText(
                  text: "personal_info".tr,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
                spaceY(10.sp),
                DetailsItemWidget(
                  title1: "living_town".tr,
                  subTitle1: _globalController.countries
                      .where((element) =>
                          element.id == widget.employeeModel.livingTown)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                  title2: "no_of_children".tr,
                  subTitle2: widget.employeeModel.numOfChildren.toString(),
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  title1: "nationality".tr,
                  subTitle1: _globalController.countries
                      .where((element) =>
                          element.id == widget.employeeModel.nationalityId)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                  title2: "religion".tr,
                  subTitle2: _globalController.relegions
                      .where((element) =>
                          element.id == widget.employeeModel.religionId)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  title1: "date_of_birth".tr,
                  subTitle1: widget.employeeModel.dateOfBirth,
                  title2: "birth_place".tr,
                  subTitle2: _globalController.countries
                      .where((element) =>
                          element.id == widget.employeeModel.birthPlace)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  title1: "weight".tr,
                  subTitle1: "${widget.employeeModel.weight} kg",
                  title2: "height".tr,
                  subTitle2: "${widget.employeeModel.hight} cm",
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  title1: "complexion".tr,
                  subTitle1: _globalController.complexionList
                      .where((element) =>
                          element.id == widget.employeeModel.complexionId)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                ),
                spaceY(10.sp),
                Divider(),
                coloredText(
                  text: "work_info".tr,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
                spaceY(10.sp),
                DetailsItemWidget(
                  width1: 80.w,
                  title1: "job".tr,
                  subTitle1: widget.employeeModel.jobs!
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .toList()
                      .join(", "),
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  title1: "contract_duration".tr,
                  subTitle1:
                      "${widget.employeeModel.contractDuration} ${"years".tr}",
                  title2: "monthly_salery".tr,
                  subTitle2:
                      "${widget.employeeModel.salaryMonth != null ? (double.parse(widget.employeeModel.salaryMonth!) * _globalController.currencyRate).toStringAsFixed(1) : 0} ${_globalController.currencySymbol.key}",
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  width1: 80.w,
                  title1: "previous_work_abroad".tr,
                  subTitle1: widget.employeeModel.previousWorkAbroad == 1
                      ? "yes".tr
                      : "no".tr,
                ),
                widget.employeeModel.previousWorkAbroad == 0
                    ? Container()
                    : spaceY(12.sp),
                widget.employeeModel.previousWorkAbroad == 0
                    ? Container()
                    : DetailsItemWidget(
                        width1: 80.w,
                        title1: "duration_of_employment".tr,
                        subTitle1:
                            "${widget.employeeModel.durationOfEmployment} ${"years".tr}",
                      ),
                spaceY(12.sp),
                Divider(),

                coloredText(
                  text: "other_data".tr,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
                spaceY(10.sp),
                DetailsItemWidget(
                  width1: 80.w,
                  title1: "educational_certificates".tr,
                  subTitle1: _globalController.certificates
                      .where((element) =>
                          element.id ==
                          widget.employeeModel.educationCertification)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                ),
                spaceY(12.sp),
                DetailsItemWidget(
                  width1: 80.w,
                  title1: "knowledge_of_languages".tr,
                  subTitle1: widget.employeeModel.languages!
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .toList()
                      .join(", "),
                ),

                widget.employeeModel.desc == null ? Container() : spaceY(10.sp),
                widget.employeeModel.desc == null
                    ? Container()
                    : DetailsItemWidget(
                        width1: 80.w,
                        title1: "more_details".tr,
                        subTitle1: widget.employeeModel.desc),

                spaceY(10.sp),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Icon(EvaIcons.briefcaseOutline, color: Colors.grey),
                //     spaceX(10.sp),
                //     Expanded(
                //       child: coloredText(
                //           text: widget.employeeModel.previousWorkAbroad == 0
                //               ? "did_not_work_abroad".tr
                //               : "${"previous_work_abroad".tr} ${widget.employeeModel.durationOfEmployment} ${"years".tr}",
                //           color: Colors.grey,
                //           fontSize: 12.sp),
                //     )
                //   ],
                // ),
                // spaceY(10.sp),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(FontAwesomeIcons.graduationCap,
                //         size: 15.sp, color: Colors.grey),
                //     spaceX(10.sp),
                //     Expanded(
                //       child: coloredText(
                //           text:
                //               "${"educational_certificates".tr}: ${Get.locale == const Locale('en', 'US') ? _globalController.certificates.where((element) => element.id == widget.employeeModel.educationCertification!).first.nameEn! : _globalController.certificates.where((element) => element.id == widget.employeeModel.educationCertification!).first.nameAr!}",
                //           color: Colors.grey,
                //           fontSize: 12.sp),
                //     )
                //   ],
                // ),
              ],
            ),
          )
        ],
      )),
    );
  }

  late String _localPath;

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      // var dir = (await _dirsOnIOS)[0]; // temporary
      // var dir = (await _dirsOnIOS)[1]; // applicationSupport
      // var dir = (await _dirsOnIOS)[2]; // library
      var dir = (await _dirsOnIOS)[3]; // applicationDocuments
      // var dir = (await _dirsOnIOS)[4]; // downloads

      dir ??= await getApplicationDocumentsDirectory();
      externalStorageDirPath = dir.absolute.path;
    }

    return externalStorageDirPath;
  }

  Future<List<Directory?>> get _dirsOnIOS async {
    final temporary = await getTemporaryDirectory();
    final applicationSupport = await getApplicationSupportDirectory();
    final library = await getLibraryDirectory();
    final applicationDocuments = await getApplicationDocumentsDirectory();
    final downloads = await getDownloadsDirectory();

    final dirs = [
      temporary,
      applicationSupport,
      library,
      applicationDocuments,
      downloads
    ];

    return dirs;
  }
}
