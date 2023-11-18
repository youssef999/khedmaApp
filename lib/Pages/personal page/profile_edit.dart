import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/models/me.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../../widgets/dropdown_menu_button.dart';
import '../../widgets/underline_text_field.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key, required this.userType});
  final String userType;
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String nationality = "";
  String region = "";
  String city = "";
  var errors = {};

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _pieceNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _adnController = TextEditingController();

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  GlobalController _globalController = Get.find();
  late UserInformation userInformation;
  @override
  void initState() {
    userInformation = _globalController.me.userInformation!;
    _phoneNumberController.text = userInformation.phone!;
    {
      nationality = Get.locale == const Locale('en', 'US')
          ? _globalController.countries
              .where((element) => element.id == userInformation.nationalityId)
              .first
              .nameEn!
          : _globalController.countries
              .where((element) => element.id == userInformation.nationalityId)
              .first
              .nameAr!;
      city = Get.locale == const Locale('en', 'US')
          ? _globalController.cities
              .where((element) => element.id == userInformation.cityId)
              .first
              .nameEn!
          : _globalController.cities
              .where((element) => element.id == userInformation.cityId)
              .first
              .nameAr!;
      region = Get.locale == const Locale('en', 'US')
          ? _globalController.regions
              .where((element) => element.id == userInformation.regionId)
              .first
              .nameEn!
          : _globalController.regions
              .where((element) => element.id == userInformation.regionId)
              .first
              .nameAr!;
    }

    _jobNameController.text = userInformation.jobName!;
    _pieceNumberController.text = userInformation.pieceNumber!;
    _streetController.text = userInformation.street!;
    _buildingController.text = userInformation.building!;
    _adnController.text = userInformation.automatedAddressNumber!;
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  final key = GlobalKey<FormState>();
  bool valid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "edit_profile".tr, fontSize: 15.0.sp),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          primary: false,
          children: [
            spaceY(10.0.sp),
            coloredText(text: "phone_number".tr),
            // spaceY(5.sp),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[0],
              controller: _phoneNumberController,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              onchanged: (s) {
                errors['phone'] = null;
                setState(() {});
                userInformation.phone = s!;
              },
              validator: (String? value) {
                if (errors['phone'] != null) {
                  String tmp = "";
                  tmp = errors['phone'].join("\n");

                  return tmp;
                } else if (value!.length < 7 && value.isNotEmpty) {
                  return "phone must be 7 numbers at least";
                }
                return null;
              },
              prefixIcon: Container(
                margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      EvaIcons.phoneOutline,
                      size: 15.0.sp,
                    ),
                    spaceX(5.sp),
                    coloredText(text: "+965", color: Colors.black)
                    // CustomDropDownMenuButton(
                    //   value: "+963",
                    //   width: 65.sp,
                    //   hintPadding: 13,
                    //   items: [
                    //     "+963",
                    //     "+954",
                    //     "+94",
                    //   ]
                    //       .map((e) => DropdownMenuItem<String>(
                    //             value: e,
                    //             child: coloredText(
                    //               text: e,
                    //               fontSize: 17,
                    //             ),
                    //           ))
                    //       .toList(),
                    //   onChanged: (p0) {},
                    // ),
                  ],
                ),
              ),
              //
            ),
            spaceY(15.0.sp), coloredText(text: "nationality".tr),
            CustomDropDownMenuButton(
              hintPadding: 0, focusNode: _focusNodes[3],
              value: nationality == "" ? null : nationality,
              hint: "${"nationality".tr} (${"optional".tr})",
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (errors['nationality_id'] != null) {
                  String tmp = "";
                  tmp = errors['nationality_id'].join("\n");

                  return tmp;
                }
                return null;
              },
              onChanged: (p0) {
                nationality = p0!;
                errors['nationality_id'] = null;
                setState(() {});
                userInformation.nationalityId = _globalController.countries
                    .where((element) =>
                        element.nameEn == p0 || element.nameAr == p0)
                    .first
                    .id;
              },
              width: 100.w,
              items: _globalController.countries
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr,
                      child: coloredText(
                          text: Get.locale == const Locale('en', 'US')
                              ? e.nameEn!
                              : e.nameAr!,
                          color: Colors.black),
                    ),
                  )
                  .toList(),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: _focusNodes[4].hasFocus
                      ? Theme.of(context).colorScheme.secondary
                      : const Color(0xffBDC1C8),
                ),
              ),

              prefixIcon: Icon(
                EvaIcons.globe2Outline,
                size: 20.0.sp,
              ),
              // borderc: Border.all(color: const Color(0xffE3E3E3)),
              borderRadius: BorderRadius.circular(8),
              // padding:
              //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),

            // UnderlinedCustomTextField(
            //   focusNode: _focusNodes[1],
            //   keyBoardType: TextInputType.text,
            //   controller: _nationallityController,
            //   readOnly: true,
            //   prefixIcon: Icon(
            //     EvaIcons.globe2Outline,
            //     size: 15.0.sp,
            //   ),
            // ),
            spaceY(15.0.sp), coloredText(text: "job".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[2],
              hintText: "job".tr,
              controller: _jobNameController,
              keyBoardType: TextInputType.text,
              prefixIcon: Icon(
                EvaIcons.briefcaseOutline,
                size: 15.0.sp,
              ),
              onchanged: (s) {
                errors['job_name'] = null;
                setState(() {});
                userInformation.jobName = s;
              },
              validator: (String? value) {
                if (errors['job_name'] != null) {
                  String tmp = "";
                  tmp = errors['job_name'].join("\n");

                  return tmp;
                }
                return null;
              },
            ),
            spaceY(15.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //todo:langs needs to be fixed
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coloredText(text: "phone_number".tr),
                    CustomDropDownMenuButton(
                      hint: "city".tr,
                      value: city == "" ? null : city,
                      hintPadding: 0,
                      border: const UnderlineInputBorder(),
                      width: 40.0.w,
                      items: _globalController.cities
                          .map((e) => DropdownMenuItem<String>(
                                value: Get.locale == const Locale('en', 'US')
                                    ? e.nameEn!
                                    : e.nameAr,
                                child: coloredText(
                                  text: Get.locale == const Locale('en', 'US')
                                      ? e.nameEn!
                                      : e.nameAr!,
                                  fontSize: 17,
                                ),
                              ))
                          .toList(),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (String? value) {
                        if (errors['city_id'] != null) {
                          String tmp = "";
                          tmp = errors['city_id'].join("\n");

                          return tmp;
                        }
                        return null;
                      },
                      onChanged: (p0) {
                        city = p0!;
                        errors["city_id"] = null;
                        setState(() {});
                        userInformation.cityId = _globalController.cities
                            .where((element) =>
                                element.nameEn == p0 || element.nameAr == p0)
                            .first
                            .id!;
                      },
                    ),
                  ],
                ),
                //todo:langs need to be fixed
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coloredText(text: "region".tr),
                    CustomDropDownMenuButton(
                      hint: "region".tr,
                      border: const UnderlineInputBorder(),
                      width: 40.0.w,
                      hintPadding: 0,
                      value: region == "" ? null : region,
                      items: _globalController.regions
                          .map((e) => DropdownMenuItem<String>(
                                value: Get.locale == const Locale('en', 'US')
                                    ? e.nameEn!
                                    : e.nameAr,
                                child: coloredText(
                                  text: Get.locale == const Locale('en', 'US')
                                      ? e.nameEn!
                                      : e.nameAr!,
                                  fontSize: 17,
                                ),
                              ))
                          .toList(),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (String? value) {
                        if (errors['region_id'] != null) {
                          String tmp = "";
                          tmp = errors['region_id'].join("\n");

                          return tmp;
                        }
                        return null;
                      },
                      onChanged: (p0) {
                        region = p0!;
                        errors["region_id"] = null;
                        setState(() {});
                        userInformation.regionId = _globalController.regions
                            .where((element) =>
                                element.nameEn == p0 || element.nameAr == p0)
                            .first
                            .id!;
                        ;
                      },
                    ),
                  ],
                ),
              ],
            ),
            spaceY(15.0.sp), coloredText(text: "piece_num".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[3],
              controller: _pieceNumberController,
              hintText: "piece_num".tr,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (errors['piece_number'] != null) {
                  String tmp = "";
                  tmp = errors['piece_number'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors["piece_number"] = null;
                setState(() {});
                userInformation.pieceNumber = s;
              },
            ),
            spaceY(15.0.sp), coloredText(text: "street".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[4],
              controller: _streetController,
              hintText: "street".tr,
              keyBoardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (errors['street'] != null) {
                  String tmp = "";
                  tmp = errors['street'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors["street"] = null;
                setState(() {});
                userInformation.street = s;
              },
            ),
            spaceY(15.0.sp), coloredText(text: "building".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[5],
              controller: _buildingController,
              hintText: "building".tr,
              keyBoardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (errors['building'] != null) {
                  String tmp = "";
                  tmp = errors['building'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors["building"] = null;
                setState(() {});
                userInformation.building = s;
              },
            ),
            spaceY(15.0.sp), coloredText(text: "adn".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[6],
              controller: _adnController,
              hintText: "adn".tr,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (errors['automated_address_number'] != null) {
                  String tmp = "";
                  tmp = errors['automated_address_number'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors["automated_address_number"] = null;
                setState(() {});
                userInformation.automatedAddressNumber = s;
              },
            ),
            spaceY(40.0.sp),
            primaryButton(
              onTap: () async {
                FocusScope.of(context).unfocus();
                var x = await _globalController.updateUserProfile(
                    userInfo: userInformation);
                if (x == true) {
                  // ignore: use_build_context_synchronously
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
                          color: Theme.of(context).colorScheme.primary,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            spaceY(20),
                            Icon(
                              EvaIcons.checkmarkCircle,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 40.sp,
                            ),
                            spaceY(20),
                            coloredText(
                                text: "profile_edited".tr, fontSize: 12.0.sp),
                            coloredText(
                              text: "successfully".tr,
                              fontSize: 14.0.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                      ));
                } else if (x['message'] == "The given data was invalid.") {
                  errors = x['errors'];

                  setState(() {});
                }
              },
              text: coloredText(text: "apply".tr, color: Colors.white),
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            spaceY(10.sp)
          ],
        ),
      ),
    );
  }
}
