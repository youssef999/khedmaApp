// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:khedma/Pages/global_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../HomePage/user home/user_home_page.dart';

class InvoicePage extends StatefulWidget {
  InvoicePage({
    super.key,
    required this.invoiceId,
    required this.employeeName,
    required this.userName,
    required this.companyId,
    required this.contractDuration,
    required this.contractAmount,
    required this.isOffer,
    this.contractAmountAfterDiscount,
  });
  final String invoiceId;
  final String employeeName;
  final String userName;
  final int companyId;
  final int isOffer;
  final String contractDuration;
  final String contractAmount;
  int? contractAmountAfterDiscount;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  void initState() {
    super.initState();
  }

  GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 100.0.w,
          height: 100.0.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/invoice_background.png"),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      coloredText(
                        text: "invoice".tr,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 13.0.sp,
                      ),
                      Container(
                        width: 35.0.sp,
                        height: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ],
                  ),
                  //   spaceX(5),
                  //   primaryButton(
                  //       width: 32.0.w,
                  //       height: 45,
                  //       radius: 10,
                  //       color: const Color(0xffF5F5F5),
                  //       text: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(EvaIcons.shareOutline,
                  //               color: Theme.of(context).colorScheme.tertiary,
                  //               size: 15.0.sp),
                  //           spaceX(10),
                  //           coloredText(
                  //               text: "share".tr,
                  //               color: Theme.of(context).colorScheme.tertiary,
                  //               fontSize: 11.0.sp),
                  //         ],
                  //       )),
                  //   primaryButton(
                  //       width: 32.0.w,
                  //       height: 45,
                  //       radius: 10,
                  //       color: const Color(0xffF5F5F5),
                  //       text: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(EvaIcons.downloadOutline,
                  //               color: Theme.of(context).colorScheme.tertiary,
                  //               size: 15.0.sp),
                  //           spaceX(10),
                  //           coloredText(
                  //               text: "download".tr,
                  //               color: Theme.of(context).colorScheme.tertiary,
                  //               fontSize: 11.0.sp),
                  //         ],
                  //       )),
                ],
              ),
              spaceY(2.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        coloredText(
                            text: "ID:",
                            color: const Color(0xff919191),
                            fontSize: 12.0.sp),
                        coloredText(
                          text: widget.invoiceId,
                          fontSize: 13.0.sp,
                        )
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        coloredText(
                            text: "${"date".tr}: ",
                            color: const Color(0xff919191),
                            fontSize: 12.0.sp),
                        coloredText(
                          text: intl.DateFormat(intl.DateFormat.YEAR_MONTH_DAY)
                              .format(DateTime.now()),
                          fontSize: 13.0.sp,
                        )
                      ]),
                ],
              ),
              spaceY(3.0.h),
              Container(
                width: 100.0.w,
                height: 40.0.h,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(
                              text: "${"name".tr}:",
                              color: const Color(0xff919191),
                              fontSize: 12.0.sp),
                          spaceY(6),
                          coloredText(
                            text: widget.userName,
                            fontSize: 13.0.sp,
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(
                              text: "${"employee_name".tr}:",
                              color: const Color(0xff919191),
                              fontSize: 12.0.sp),
                          spaceY(6),
                          coloredText(
                            text: widget.employeeName,
                            fontSize: 13.0.sp,
                          )
                        ]),

                    //
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(
                              text: "${"contract_duration".tr}:",
                              color: const Color(0xff919191),
                              fontSize: 12.0.sp),
                          spaceY(6),
                          coloredText(
                            text: "${widget.contractDuration} ${"years".tr}",
                            fontSize: 13.0.sp,
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(
                              text: "${"pay_method".tr}:",
                              color: const Color(0xff919191),
                              fontSize: 12.0.sp),
                          spaceY(6),
                          coloredText(
                            text: "Myfatoorah",
                            fontSize: 13.0.sp,
                          )
                        ]),
                  ],
                ),
              ),
              spaceY(2.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  coloredText(
                    text: "${"price".tr} :",
                    fontSize: 13.0.sp,
                  ),
                  spaceX(10),
                  coloredText(
                      textDirection: TextDirection.ltr,
                      text:
                          "${widget.isOffer == 1 ? (widget.contractAmountAfterDiscount! * _globalController.currencyRate).toStringAsFixed(1) : (double.parse(widget.contractAmount) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key}",
                      fontSize: 13.0.sp,
                      color: Theme.of(context).colorScheme.secondary),
                ],
              ),
              spaceY(10.0.h),
              primaryButton(
                  onTap: () {
                    Get.offAll(() => const UserHomePage());
                  },
                  width: 80.0.w,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ]),
                  text: coloredText(
                    text: "done".tr,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
