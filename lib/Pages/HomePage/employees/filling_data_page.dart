import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Themes/themes.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class FillingDataPage extends StatefulWidget {
  const FillingDataPage({super.key, required this.companyId});
  final int companyId;
  @override
  State<FillingDataPage> createState() => _FillingDataPageState();
}

class _FillingDataPageState extends State<FillingDataPage> {
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  CompaniesController _companiesController = Get.find();
  GlobalController _globalController = Get.find();
  AdminController _adminController = Get.find();
  List<String> tags = [
    "company_headquarters",
  ];

  List<String> options = [
    "company_headquarters",
    "representative_from_the_company",
    "representative_from_the_application",
  ];

  String? selectedValue;
  int diffPrice = 0;
  int reciptMethod = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(text: "filling_data".tr, fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          primary: false,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //       width: 40.w,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           spaceY(10.sp),
            //           coloredText(
            //             text: "${"start_date".tr}:",
            //           ),
            //           spaceY(5.sp),
            //           SizedBox(
            //             height: 40.sp,
            //             child: TextFormField(
            //               textAlign: TextAlign.center,
            //               onTap: () async {
            //                 DateTime? x = await showDatePicker(
            //                     builder: (context, child) => Theme(
            //                           data: ThemeData(
            //                             colorScheme: ColorScheme.fromSeed(
            //                               seedColor: AppThemes.colorCustom,
            //                             ),
            //                           ),
            //                           child: child!,
            //                         ),
            //                     context: context,
            //                     initialDate: DateTime.now(),
            //                     firstDate: DateTime.now(),
            //                     lastDate: DateTime.now()
            //                         .add(const Duration(days: 30)));
            //                 if (x != null) {
            //                   dateTimeController.text =
            //                       DateFormat('y/MM/dd').format(x);
            //                 }
            //               },
            //               // maxLines: 3,
            //               controller: dateTimeController,
            //               readOnly: true,

            //               decoration: InputDecoration(
            //                 hintText: 'YYYY/MM/DD',
            //                 enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: const BorderSide(
            //                     color: Color(0xffE3E3E3),
            //                   ),
            //                 ),
            //                 focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: const BorderSide(
            //                     color: Color(0xffE3E3E3),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       width: 40.w,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           spaceY(10.sp),
            //           coloredText(
            //             text: "${"end_date".tr}:",
            //           ),
            //           spaceY(5.sp),
            //           SizedBox(
            //             height: 40.sp,
            //             child: TextFormField(
            //               textAlign: TextAlign.center,
            //               onTap: () async {
            //                 DateTime? x = await showDatePicker(
            //                     builder: (context, child) => Theme(
            //                           data: ThemeData(
            //                             colorScheme: ColorScheme.fromSeed(
            //                               seedColor: AppThemes.colorCustom,
            //                             ),
            //                           ),
            //                           child: child!,
            //                         ),
            //                     context: context,
            //                     initialDate: DateTime.now(),
            //                     firstDate: DateTime.now(),
            //                     lastDate: DateTime.now()
            //                         .add(const Duration(days: 30)));
            //                 if (x != null) {
            //                   endDateController.text =
            //                       DateFormat('y/MM/dd').format(x);
            //                 }
            //               },
            //               // maxLines: 3,
            //               controller: endDateController,
            //               readOnly: true,

            //               decoration: InputDecoration(
            //                 hintText: 'YYYY/MM/DD',
            //                 enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: const BorderSide(
            //                     color: Color(0xffE3E3E3),
            //                   ),
            //                 ),
            //                 focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: const BorderSide(
            //                     color: Color(0xffE3E3E3),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            SizedBox(
              // height: 40.sp,
              child: TextFormField(
                textAlign: TextAlign.center,
                onTap: () async {
                  DateTime? x = await showOmniDateTimePicker(
                      theme: ThemeData(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: AppThemes.colorCustom,
                        ),
                      ),
                      is24HourMode: false,
                      isShowSeconds: false,
                      minutesInterval: 1,
                      secondsInterval: 1,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      constraints: const BoxConstraints(
                        maxWidth: 350,
                        maxHeight: 650,
                      ),
                      transitionBuilder: (context, anim1, anim2, child) {
                        return FadeTransition(
                          opacity: anim1.drive(
                            Tween(
                              begin: 0,
                              end: 1,
                            ),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      selectableDayPredicate: (dateTime) {
                        // Disable 25th Feb 2023
                        if (dateTime == DateTime(2023, 2, 25)) {
                          return false;
                        } else {
                          return true;
                        }
                      },
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)));
                  if (x != null) {
                    dateTimeController.text =
                        DateFormat('yyyy/M/dd hh:mm:ss').format(x);
                  }
                },
                // maxLines: 3,
                controller: dateTimeController,
                readOnly: true,

                decoration: InputDecoration(
                  hintText: 'YYYY/MM/DD HH:MM',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffE3E3E3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffE3E3E3),
                    ),
                  ),
                ),
              ),
            ),

            spaceY(10.sp),
            // Row(
            //   children: [
            //     Icon(
            //       EvaIcons.info,
            //       color: Theme.of(context).colorScheme.secondary,
            //     ),
            //     spaceX(5.sp),
            //     coloredText(
            //       text: "Work hours per day is 8 max",
            //       fontSize: 11.sp,
            //       color: Theme.of(context).colorScheme.secondary,
            //     )
            //   ],
            // ),
            // spaceY(10.sp),
            coloredText(
              text: "receipt_method".tr,
            ),
            ChipsChoice<String>.multiple(
              padding: EdgeInsets.zero,
              value: tags,
              onChanged: (val) {}, direction: Axis.vertical,
              choiceItems: C2Choice.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              // choiceStyle: C2ChipStyle.outlined(),
              choiceCheckmark: true,

              choiceBuilder: (item, i) => GestureDetector(
                onTap: () {
                  if (!tags.contains(item.label)) {
                    tags = [];
                    tags.add(item.label);
                    if (item.label == "company_headquarters") {
                      diffPrice = 0;
                      reciptMethod = 0;
                    } else if (item.label ==
                        "representative_from_the_application") {
                      diffPrice =
                          int.parse(_adminController.settingAdmin.khedmaPrice!);
                      reciptMethod = 2;
                    } else {
                      diffPrice = int.parse(_companiesController.companyPrice);
                      reciptMethod = 1;
                    }
                  }

                  setState(() {});
                },
                child: Container(
                  width: 100.0.w,
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: !tags.contains(item.label)
                            ? const Color(0xff919191)
                            : Theme.of(context).colorScheme.secondary,
                      )),
                  child: Center(
                    child: coloredText(
                        text: item.label.tr,
                        color: !tags.contains(item.label)
                            ? const Color(0xff919191)
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: 12.0.sp),
                  ),
                ),
              ),
            ),
            spaceY(10.sp),
            coloredText(
              text: "${"address".tr}:",
            ),
            spaceY(5.sp),
            SizedBox(
              height: 40.sp,
              child: TextFormField(
                // maxLines: 3,
                controller: addressController,

                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffE3E3E3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffE3E3E3),
                    ),
                  ),
                ),
              ),
            ),
            spaceY(10.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    coloredText(text: "${"total".tr}:"),
                    coloredText(
                        text:
                            "${((_companiesController.getCartTotal() + diffPrice) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key}",
                        color: Theme.of(context).colorScheme.secondary),
                  ],
                ),
                primaryButton(
                    onTap: () async {
                      bool? x = await _companiesController.checkOut(
                        id: widget.companyId,
                        startDate: dateTimeController.text,
                        endDate: endDateController.text,
                        address: addressController.text,
                        receiptMethod: reciptMethod,
                      );
                      if (x != null) {
                        //String invoiceId = x.keys.first;
                        // Uri url = Uri.parse(x.values.first);

                        // await launchUrl(url,
                        //     mode: LaunchMode.externalApplication);

                        // await Future.delayed(const Duration(milliseconds: 100));
                        // while (WidgetsBinding.instance.lifecycleState !=
                        //     AppLifecycleState.resumed) {
                        //   await Future.delayed(
                        //       const Duration(milliseconds: 100));
                        // }
                        Utils.doneDialog(context: context, backTimes: 4);
                      }
                    },
                    width: 60.0.w,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ]),
                    text: coloredText(
                      text: "done".tr,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
