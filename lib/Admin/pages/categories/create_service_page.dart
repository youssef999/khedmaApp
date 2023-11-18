import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Admin/pages/categories/controller/categories_controller.dart';
import 'package:khedma/Admin/pages/categories/models/categories_model.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class AdminCreateService extends StatefulWidget {
  const AdminCreateService({super.key, this.categoryToEdit});
  final CategoryModel? categoryToEdit;
  @override
  State<AdminCreateService> createState() => _AdminCreateServiceState();
}

class _AdminCreateServiceState extends State<AdminCreateService> {
  String button1Text = "upload_service_icon".tr;
  CategoryModel categoryToCreate = CategoryModel();
  CategoriesController _categoriesController = Get.find();
  CompanyTypesController _companyTypesController = Get.find();
  String? selectedValue;
  String companyType = "";

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];
  @override
  void initState() {
    if (widget.categoryToEdit != null) {
      button1Text = widget.categoryToEdit!.image.toString().substring(
          widget.categoryToEdit!.image.toString().lastIndexOf("/") + 1);
      companyType = _companyTypesController.companyTypes
          .where(
              (element) => element.id == widget.categoryToEdit!.companyTypeID)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
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
            text:
                widget.categoryToEdit != null ? "edit".tr : "create_service".tr,
            fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          primary: false,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            coloredText(text: "name_ar".tr),
            spaceY(5.sp),
            SendMessageTextField(
              initialValue: widget.categoryToEdit != null
                  ? widget.categoryToEdit!.nameAr
                  : null,
              focusNode: _focusNodes[0],
              borderRadius: 10,
              onchanged: (s) {
                if (widget.categoryToEdit != null) {
                  widget.categoryToEdit!.nameAr = s;
                } else {
                  categoryToCreate.nameAr = s;
                }
              },
            ),
            spaceY(10.sp),
            coloredText(text: "name_en".tr),
            spaceY(5.sp),
            SendMessageTextField(
              initialValue: widget.categoryToEdit != null
                  ? widget.categoryToEdit!.nameEn
                  : null,
              focusNode: _focusNodes[1],
              onchanged: (s) {
                if (widget.categoryToEdit != null) {
                  widget.categoryToEdit!.nameEn = s;
                } else {
                  categoryToCreate.nameEn = s;
                }
              },
              borderRadius: 10,
            ),
            spaceY(10.sp),
            coloredText(text: "company_type".tr),
            spaceY(5.sp),
            GetBuilder<CompanyTypesController>(
                builder: (companyTypesController) {
              return CustomDropDownMenuButton(
                fillColor: const Color(0xffF5F5F5),
                padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
                // hintPadding: 5,
                width: 100.0.w,
                height: 38.sp,
                hint: "select".tr,
                borderRadius: BorderRadius.circular(10),
                value: companyType == "" ? null : companyType,
                items: companyTypesController.companyTypes
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: Get.locale == const Locale('en', 'US')
                            ? e.nameEn!
                            : e.nameAr!,
                        child: coloredText(
                            text: Get.locale == const Locale('en', 'US')
                                ? e.nameEn!
                                : e.nameAr!,
                            fontSize: 10.sp),
                      ),
                    )
                    .toList(),
                onChanged: (p0) {
                  companyType = p0!;
                  if (widget.categoryToEdit != null) {
                    widget.categoryToEdit!.companyTypeID =
                        companyTypesController.companyTypes
                            .where((element) =>
                                element.nameEn == p0 || element.nameAr == p0)
                            .single
                            .id;
                  } else {
                    categoryToCreate.companyTypeID = companyTypesController
                        .companyTypes
                        .where((element) =>
                            element.nameEn == p0 || element.nameAr == p0)
                        .single
                        .id;
                  }
                  // companyRegisterData.companyType = companyTypesController
                  //     .companyTypes
                  //     .where((element) => element.uniqueName == p0)
                  //     .map((e) => Get.locale == const Locale('en', 'US')
                  //         ? e.nameEn!
                  //         : e.nameAr!)
                  //     .single;
                },
              );
            }),
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
                    if (widget.categoryToEdit != null) {
                      widget.categoryToEdit!.image = image;
                    } else {
                      categoryToCreate.image = image;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  if (widget.categoryToEdit != null) {
                    b = await _categoriesController.updateCategory(
                        category: widget.categoryToEdit!);
                    logSuccess("edit");
                  } else {
                    b = await _categoriesController.createCategory(
                        category: categoryToCreate);
                    logSuccess("create");
                  }
                  // ignore: use_build_context_synchronously
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
    );
  }
}
