import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Admin/pages/Addressess/controller/addressess_controller.dart';
import 'package:khedma/models/country.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class AdminCreateCountry extends StatefulWidget {
  const AdminCreateCountry({super.key, this.countryToEdit});
  final Country? countryToEdit;
  @override
  State<AdminCreateCountry> createState() => _AdminCreateCountryState();
}

class _AdminCreateCountryState extends State<AdminCreateCountry> {
  String button1Text = "flag".tr;
  Country countryToCreate = Country();
  String? selectedValue;
  AddressessController _addressessController = Get.find();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  @override
  void initState() {
    if (widget.countryToEdit != null) {
      button1Text = widget.countryToEdit!.flag.toString().substring(
          widget.countryToEdit!.flag.toString().lastIndexOf("/") + 1);
    }
    for (var i in _focusNodes) {
      i.addListener(() {
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
        title: coloredText(
            text: widget.countryToEdit != null ? "edit".tr : "create_new".tr,
            fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(text: "name_ar".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.nameAr
                    : null,
                focusNode: _focusNodes[0],
                borderRadius: 10,
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.nameAr = s;
                  } else {
                    countryToCreate.nameAr = s;
                  }
                },
              ),
              spaceY(10.sp),
              coloredText(text: "name_en".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.nameEn
                    : null,
                focusNode: _focusNodes[1],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.nameEn = s;
                  } else {
                    countryToCreate.nameEn = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(10.sp),
              coloredText(text: "short_name".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.shortName
                    : null,
                focusNode: _focusNodes[7],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.shortName = s;
                  } else {
                    countryToCreate.shortName = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(10.sp),
              coloredText(text: "code".tr),
              spaceY(5.sp),
              SendMessageTextField(
                keyBoardType: TextInputType.phone,
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.code
                    : null,
                focusNode: _focusNodes[2],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.code = s;
                  } else {
                    countryToCreate.code = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(10.sp),
              coloredText(text: "nationality_ar".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.nationalityAr
                    : null,
                focusNode: _focusNodes[3],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.nationalityAr = s;
                  } else {
                    countryToCreate.nationalityAr = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(10.sp),
              coloredText(text: "nationality_en".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.nationalityEn
                    : null,
                focusNode: _focusNodes[4],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.nationalityEn = s;
                  } else {
                    countryToCreate.nationalityEn = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(10.sp),
              coloredText(text: "currency".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.currency
                    : null,
                focusNode: _focusNodes[5],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.currency = s;
                  } else {
                    countryToCreate.currency = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(10.sp),
              coloredText(text: "short_currency".tr),
              spaceY(5.sp),
              SendMessageTextField(
                initialValue: widget.countryToEdit != null
                    ? widget.countryToEdit!.shortCurrency
                    : null,
                focusNode: _focusNodes[6],
                onchanged: (s) {
                  if (widget.countryToEdit != null) {
                    widget.countryToEdit!.shortCurrency = s;
                  } else {
                    countryToCreate.shortCurrency = s;
                  }
                },
                borderRadius: 10,
              ),
              spaceY(20.sp),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                  onTap: () async {
                    XFile? image = await Utils().selectImageSheet();

                    if (image != null) {
                      setState(() {});
                      button1Text =
                          image.name.substring(0, min(15, image.name.length));
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.flag = image;
                      } else {
                        countryToCreate.flag = image;
                      }
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
              spaceY(10.0.h),
              primaryButton(
                  onTap: () async {
                    bool b = false;
                    FocusScope.of(context).unfocus();
                    if (widget.countryToEdit != null) {
                      b = await _addressessController.updateCountry(
                          country: widget.countryToEdit!);
                      // logSuccess("edit");
                    } else {
                      b = await _addressessController.createCountry(
                          country: countryToCreate);
                      // logSuccess("create");
                    }
                    if (b) Utils.doneDialog(context: context, backTimes: 2);
                  },
                  width: 80.0.w,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ]),
                  text: coloredText(
                    text: "apply".tr,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
