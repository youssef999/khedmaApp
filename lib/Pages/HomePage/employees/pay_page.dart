import 'package:chips_choice/chips_choice.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/underline_text_field.dart';

class PayPage extends StatefulWidget {
  const PayPage({
    super.key,
  });
  // final EmployeeType employeeType;
  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List<String> tags = [
    "mf",
  ];
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _ccvController = TextEditingController();
  final TextEditingController _mmyyController = TextEditingController();

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  List<String> options = [
    "mf",
    "g_pay",
    "knet",
  ];

  @override
  void initState() {
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
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
        title: coloredText(text: "payment".tr, fontSize: 15.0.sp),
      ),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              child: ChipsChoice<String>.multiple(
                padding: EdgeInsets.zero,
                value: tags,
                onChanged: (val) {},
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
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 23.0.w,
                    height: 50,
                    margin: EdgeInsetsDirectional.only(end: 7.0.w),
                    decoration: BoxDecoration(
                        boxShadow: tags.contains(item.label)
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ]
                            : null,
                        color: !tags.contains(item.label)
                            ? const Color(0xffF6F6F6)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: !tags.contains(item.label)
                              ? const Color(0xffF1F1F1)
                              : Colors.transparent,
                        )),
                    child: Center(
                      child: Container(
                        width: 15.0.w,
                        height: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/${item.label}.png"),
                          fit: BoxFit.contain,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          spaceY(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    coloredText(text: "Support: "),
                    spaceX(10),
                    Image(
                        width: 10.0.w,
                        image: const AssetImage("assets/images/visa.png")),
                    spaceX(10),
                    Image(
                        width: 10.0.w,
                        image: const AssetImage("assets/images/ms_card.png")),
                    // spaceX(10),
                    Image(
                        width: 20.0.w,
                        image: const AssetImage("assets/images/apple_pay.png")),
                  ],
                ),
                spaceY(20),
                UnderlinedCustomTextField(
                  focusNode: _focusNodes[0],
                  hintText: "Card Number",
                  controller: _cardNumberController,
                  keyBoardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CustomInputFormatter(),
                    LengthLimitingTextInputFormatter(19),
                  ],
                  // maxLength: 16,
                ),
                spaceY(10.0.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UnderlinedCustomTextField(
                      width: 38.0.w,
                      focusNode: _focusNodes[1],
                      hintText: "CCV",
                      controller: _ccvController,
                      keyBoardType: TextInputType.number,
                      inputFormatters: [CreditCardCvcInputFormatter()],
                    ),
                    UnderlinedCustomTextField(
                      width: 38.0.w,
                      focusNode: _focusNodes[2],
                      hintText: "MM/YY",
                      keyBoardType: TextInputType.number,
                      inputFormatters: [CreditCardExpirationDateFormatter()],
                      controller: _mmyyController,
                    ),
                  ],
                ),
                spaceY(30),
                primaryButton(
                    width: 100.0.w,
                    radius: 10,
                    onTap: () {
                      // if (widget.employeeType == EmployeeType.clean) {
                      //   Get.to(
                      //     () => InvoicePage(employeeType: widget.employeeType),
                      //     ,
                      //   );
                      // }
                      //  else {
                      Dialogs.materialDialog(
                          msg:
                              'The required procedures must be taken within 48 hours, except for holidays. The reservation will be canceled after 48 hours, unless a problem occurs. You can request an extension of the reservation.',
                          msgStyle: coloredText(
                                  text: "text",
                                  textAlign: TextAlign.start,
                                  color: const Color(0xff464646),
                                  fontSize: 12.0.sp)
                              .style,
                          customView: Container(
                            width: 22.0.w,
                            height: 22.0.w,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/warning.png"),
                              ),
                            ),
                          ),
                          color: Colors.white,
                          context: Get.context!,
                          actions: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: primaryButton(
                                onTap: () {
                                  Get.back();
                                  Dialogs.materialDialog(
                                      // barrierColor: Colors.red,
                                      titleStyle: coloredText(
                                              text: "text",
                                              textAlign: TextAlign.start,
                                              fontSize: 13.0.sp)
                                          .style!,
                                      customViewPosition:
                                          CustomViewPosition.BEFORE_MESSAGE,
                                      customView: Theme(
                                        data: ThemeData(
                                          useMaterial3: false,
                                        ),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 30),
                                          width: 45.0.w,
                                          height: 45.0.w,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                EvaIcons.folder,
                                                size: 30.0.w,
                                                color: const Color(0xff5E5E5E),
                                              ),
                                              coloredText(
                                                text: "contracts".tr,
                                                color: const Color(0xff5E5E5E),
                                              ),
                                              coloredText(
                                                text: "1.45 MB".tr,
                                                color: const Color(0xffA5A5A5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      title: "Download Documents",
                                      color: Colors.white,
                                      context: Get.context!,
                                      actions: [
                                        Container(
                                          child: primaryButton(
                                            onTap: () {
                                              Get.back();
                                              // if (widget.employeeType ==
                                              //     EmployeeType.recruitment) {
                                              // Get.to(
                                              // () => InvoicePage(),
                                              // );
                                              // }
                                            },
                                            width: 60.0.w,
                                            color: Colors.black,
                                            text: coloredText(
                                                text: "download".tr,
                                                color: Colors.white,
                                                fontSize: 15.0.sp),
                                          ),
                                        )
                                      ]);
                                },
                                width: 60.0.w,
                                color: Colors.black,
                                text: coloredText(
                                    text: "agree".tr,
                                    color: Colors.white,
                                    fontSize: 15.0.sp),
                              ),
                            )
                          ]);
                      // }
                    },
                    color: Colors.black,
                    text: coloredText(
                        text: "confirm".tr,
                        color: Colors.white,
                        fontSize: 15.0.sp))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
