import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/models/reservation_model.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class ReservationExtensionRequestPage extends StatefulWidget {
  const ReservationExtensionRequestPage({super.key, required this.employeeId});
  final int employeeId;
  @override
  State<ReservationExtensionRequestPage> createState() =>
      _ReservationExtensionRequestPageState();
}

class _ReservationExtensionRequestPageState
    extends State<ReservationExtensionRequestPage> {
  late ReservationExtintionModel reservationExtintionModel;
  final GlobalController _globalController = Get.find();
  @override
  void initState() {
    reservationExtintionModel =
        ReservationExtintionModel(employeeId: widget.employeeId);
    super.initState();
  }

  String button1Text = "upload_docs".tr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(text: "reservation_request".tr, fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(
                text: "${"days_required".tr}:",
              ),
              spaceY(10),
              Row(
                children: [
                  SizedBox(
                      width: 25.0.w,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value != "") {
                            reservationExtintionModel.days = int.parse(value);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "2",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xffE3E3E3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xffE3E3E3),
                            ),
                          ),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        ),
                      )),
                  spaceX(15),
                  coloredText(text: "day".tr, fontSize: 15.0.sp)
                  // SizedBox(
                  //   width: 35.0.w,
                  //   child: DropdownButtonFormField2<String>(
                  //     value: items[0],
                  //     isExpanded: true,
                  //     decoration: InputDecoration(
                  //       isDense: true,
                  //       // Add Horizontal padding using menuItemStyleData.padding so it matches
                  //       // the menu padding when button's width is not specified.
                  //       contentPadding: const EdgeInsets.fromLTRB(5, 20, 5, 0),

                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: const BorderSide(
                  //           color: Color(0xffE3E3E3),
                  //         ),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: const BorderSide(
                  //           color: Color(0xffE3E3E3),
                  //         ),
                  //       ),
                  //       // Add more decoration..
                  //     ),
                  //     items: items
                  //         .map((item) => DropdownMenuItem<String>(
                  //               value: item,
                  //               child: coloredText(text: item, fontSize: 15),
                  //             ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       //Do something when selected item is changed.
                  //     },
                  //     buttonStyleData: const ButtonStyleData(
                  //       padding: EdgeInsets.only(right: 8),
                  //     ),
                  //     iconStyleData: const IconStyleData(
                  //       icon: Icon(
                  //         Icons.arrow_drop_down,
                  //         color: Colors.black45,
                  //       ),
                  //       iconSize: 24,
                  //     ),
                  //     dropdownStyleData: DropdownStyleData(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //     ),
                  //     menuItemStyleData: const MenuItemStyleData(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              spaceY(10.sp),
              coloredText(
                text: "${"reason".tr}:",
              ),
              spaceY(10.sp),
              TextField(
                maxLines: 3,
                onChanged: (value) {
                  reservationExtintionModel.reason = value;
                },
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
              spaceY(10.sp),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                  onTap: () async {
                    XFile? image = await Utils().selectImageSheet();

                    if (image != null) {
                      setState(() {});

                      button1Text =
                          image.name.substring(0, min(15, image.name.length));
                      reservationExtintionModel.file = image;
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.13),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.upload,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 13.0.sp,
                        ),
                        spaceX(10.0.sp),
                        coloredText(
                            text: button1Text,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 13.0.sp)
                      ],
                    ),
                  ),
                ),
              ),
              // spaceY(10.sp),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     coloredText(
              //       text: "${"total".tr} :",
              //       fontSize: 13.0.sp,
              //     ),
              //     spaceX(10),
              //     primaryButton(
              //       color: Theme.of(context)
              //           .colorScheme
              //           .secondary
              //           .withOpacity(0.1),
              //       width: 30.0.w,
              //       height: 45,
              //       radius: 8,
              //       text: coloredText(
              //           text: "30 KWD",
              //           fontSize: 13.0.sp,
              //           color: Theme.of(context).colorScheme.secondary),
              //     ),
              //   ],
              // ),

              spaceY(5.0.h),
              primaryButton(
                  onTap: reservationExtintionModel.file == null &&
                          reservationExtintionModel.reason == null &&
                          reservationExtintionModel.days == null
                      ? null
                      : () async {
                          bool b = await _globalController
                              .requestReservationExtension(
                                  reservationExtintionModel:
                                      reservationExtintionModel);
                          if (b) {
                            Utils.doneDialog(context: context, backTimes: 2);
                          }
                        },
                  width: 100.0.w,
                  color: reservationExtintionModel.file == null &&
                          reservationExtintionModel.reason == null &&
                          reservationExtintionModel.days == null
                      ? Colors.grey
                      : null,
                  gradient: reservationExtintionModel.file == null &&
                          reservationExtintionModel.reason == null &&
                          reservationExtintionModel.days == null
                      ? null
                      : LinearGradient(colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ]),
                  text: coloredText(
                      text: "submit".tr,
                      color: Colors.white,
                      fontSize: 14.0.sp))
            ],
          ),
        ),
      ),
    );
  }
}
