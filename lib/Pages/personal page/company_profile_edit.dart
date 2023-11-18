import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/models/me.dart';
import 'package:khedma/widgets/radio_button.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../../widgets/dropdown_menu_button.dart';
import '../../widgets/underline_text_field.dart';

class CompanyProfileEditPage extends StatefulWidget {
  const CompanyProfileEditPage({
    super.key,
  });

  @override
  State<CompanyProfileEditPage> createState() => _CompanyProfileEditPageState();
}

String logobuttonText = "upload_company_logo".tr;

class _CompanyProfileEditPageState extends State<CompanyProfileEditPage> {
  String region = "";
  String city = "";
  var errors = {};
  int busyGroup = 0;
  String commerciallicenseButton = "commercial_license".tr;
  String articlesOfAssociationButton = "articles_of_association".tr;
  String signitureAuthButton = "signiture_auth".tr;
  String signitureButton = "signiture".tr;
  File? signature;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  final TextEditingController _companyPhoneNumberController =
      TextEditingController();
  final TextEditingController _pieceNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _adnController = TextEditingController();
  bool canEditFiles = false;
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
  late CompanyInformation companyInformation;
  @override
  void initState() {
    companyInformation = _globalController.me.companyInformation!;
    busyGroup = companyInformation.busy!;
    if (companyInformation.approveAdmin == null ||
        companyInformation.approveAdmin == 0) {
      if (companyInformation.verifyContract == 0) {
        canEditFiles = true;
      }
    }
    _companyPhoneNumberController.text = companyInformation.phone!;
    {
      city = Get.locale == const Locale('en', 'US')
          ? _globalController.cities
              .where((element) => element.id == companyInformation.cityId)
              .first
              .nameEn!
          : _globalController.cities
              .where((element) => element.id == companyInformation.cityId)
              .first
              .nameAr!;
      // region = Get.locale == const Locale('en', 'US')
      //     ? _globalController.regions
      //         .where((element) => element.id == companyInformation.regionId)
      //         .first
      //         .nameEn!
      // : _globalController.regions
      //     .where((element) => element.id == companyInformation.regionId)
      //     .first
      //     .nameAr!;
    }

    commerciallicenseButton = basename(companyInformation.commercialLicense);
    articlesOfAssociationButton =
        basename(companyInformation.articlesOfAssociation);
    signitureAuthButton = basename(companyInformation.signatureAuthorization);
    signitureButton = basename(companyInformation.signatureOfficial);
    _pieceNumberController.text = companyInformation.pieceNumber!;
    _streetController.text = companyInformation.street!;
    _buildingController.text = companyInformation.building!;
    _adnController.text = companyInformation.automatedAddressNumber!;
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
            spaceY(10.0.sp), coloredText(text: "phone_number".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[0],
              controller: _companyPhoneNumberController,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              onchanged: (s) {
                errors['phone'] = null;
                setState(() {});
                companyInformation.phone = s!;
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
            spaceY(15.0.sp),

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
            // spaceY(15.0.sp),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //todo:langs needs to be fixed
            coloredText(text: "city".tr),
            SearchableDropDown(
              hintPadding: 10,
              hint: "city".tr,
              border: const UnderlineInputBorder(),
              // width: 40.0.w,
              value: city == "" ? null : city,
              items: _globalController.cities
                  .map((e) => DropDownValueModel(
                        value: Get.locale == const Locale('en', 'US')
                            ? e.nameEn!
                            : e.nameAr,
                        name: Get.locale == const Locale('en', 'US')
                            ? e.nameEn!
                            : e.nameAr!,
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
                DropDownValueModel d = p0;
                city = d.name;
                errors["city_id"] = null;
                setState(() {});
                companyInformation.cityId = _globalController.cities
                    .where((element) =>
                        element.nameEn == d.name || element.nameAr == d.name)
                    .first
                    .id;
              },
            ),
            //todo:langs need to be fixed
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     coloredText(text: "region".tr),
            //     CustomDropDownMenuButton(
            //       hint: "region".tr,
            //       border: const UnderlineInputBorder(),
            //       width: 40.0.w,
            //       hintPadding: 0,
            //       value: region == "" ? null : region,
            //       items: _globalController.regions
            //           .map((e) => DropdownMenuItem<String>(
            //                 value: Get.locale == const Locale('en', 'US')
            //                     ? e.nameEn!
            //                     : e.nameAr,
            //                 child: coloredText(
            //                   text: Get.locale == const Locale('en', 'US')
            //                       ? e.nameEn!
            //                       : e.nameAr!,
            //                   fontSize: 17,
            //                 ),
            //               ))
            //           .toList(),
            //       autovalidateMode: AutovalidateMode.always,
            //       validator: (String? value) {
            //         if (errors['region_id'] != null) {
            //           String tmp = "";
            //           tmp = errors['region_id'].join("\n");

            //           return tmp;
            //         }
            //         return null;
            //       },
            //       onChanged: (p0) {
            //         region = p0!;
            //         errors["region_id"] = null;
            //         setState(() {});
            //         companyInformation.regionId = _globalController.regions
            //             .where((element) =>
            //                 element.nameEn == p0 || element.nameAr == p0)
            //             .first
            //             .id!;
            //         ;
            //       },
            //     ),
            //   ],
            // ),
            //   ],
            // ),
            spaceY(15.0.sp), coloredText(text: "piece_num".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[3],
              controller: _pieceNumberController,
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
                companyInformation.pieceNumber = s;
              },
            ),
            spaceY(15.0.sp), coloredText(text: "street".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[4],
              controller: _streetController,
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
                companyInformation.street = s;
              },
            ),
            spaceY(15.0.sp), coloredText(text: "building".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[5],
              controller: _buildingController,
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
                companyInformation.building = s;
              },
            ),
            spaceY(15.0.sp), coloredText(text: "adn".tr),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[6],
              controller: _adnController,
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
                companyInformation.automatedAddressNumber = s;
              },
            ),

            spaceY(10.sp),
            coloredText(fontSize: 14.0.sp, text: "busy".tr),
            spaceY(5.sp),
            Row(
              children: [
                MyRadioButton(
                  text: "no".tr,
                  value: 0,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  groupValue: busyGroup,
                  onChanged: (p0) {
                    busyGroup = p0;
                    companyInformation.busy = p0;
                    setState(() {});
                  },
                ),
                spaceX(10.sp),
                MyRadioButton(
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  text: "yes".tr,
                  value: 1,
                  groupValue: busyGroup,
                  onChanged: (p0) {
                    busyGroup = p0;
                    companyInformation.busy = p0;
                    setState(() {});
                  },
                ),
              ],
            ),
            !canEditFiles ? Container() : spaceY(10.0.sp),
            !canEditFiles
                ? Container()
                : primaryButton(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
                      if (result != null) {
                        companyInformation.commercialLicense =
                            result.files.single;

                        commerciallicenseButton = result.files.single.name;

                        setState(() {});
                      }
                    },
                    color: const Color(0xffF5F5F5),
                    width: 100.0.w,
                    height: 55,
                    radius: 10,
                    text: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            spaceX(10),
                            Icon(
                              EvaIcons.fileOutline,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18.0.sp,
                            ),
                            spaceX(10),
                            SizedBox(
                              width: 65.w,
                              child: coloredText(
                                overflow: TextOverflow.ellipsis,
                                text: commerciallicenseButton,
                                color: const Color(0xff919191),
                                fontSize: 13.0.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0.sp,
                            ),
                            spaceX(10),
                          ],
                        ),
                      ],
                    )),
            !canEditFiles ? Container() : spaceY(10.0.sp),
            !canEditFiles
                ? Container()
                : primaryButton(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
                      if (result != null) {
                        companyInformation.articlesOfAssociation =
                            result.files.single;

                        articlesOfAssociationButton = result.files.single.name;

                        setState(() {});
                      }
                    },
                    color: const Color(0xffF5F5F5),
                    width: 100.0.w,
                    height: 55,
                    radius: 10,
                    text: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            spaceX(10),
                            Icon(
                              EvaIcons.fileOutline,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18.0.sp,
                            ),
                            spaceX(10),
                            SizedBox(
                              width: 65.w,
                              child: coloredText(
                                overflow: TextOverflow.ellipsis,
                                text: articlesOfAssociationButton,
                                color: const Color(0xff919191),
                                fontSize: 13.0.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0.sp,
                            ),
                            spaceX(10),
                          ],
                        ),
                      ],
                    )),
            !canEditFiles ? Container() : spaceY(10.0.sp),
            !canEditFiles
                ? Container()
                : primaryButton(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
                      if (result != null) {
                        companyInformation.signatureAuthorization =
                            result.files.single;

                        signitureAuthButton = result.files.single.name;

                        setState(() {});
                      }
                    },
                    color: const Color(0xffF5F5F5),
                    width: 100.0.w,
                    height: 55,
                    radius: 10,
                    text: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            spaceX(10),
                            Icon(
                              EvaIcons.fileOutline,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18.0.sp,
                            ),
                            spaceX(10),
                            SizedBox(
                              width: 65.w,
                              child: coloredText(
                                overflow: TextOverflow.ellipsis,
                                text: signitureAuthButton,
                                color: const Color(0xff919191),
                                fontSize: 13.0.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0.sp,
                            ),
                            spaceX(10),
                          ],
                        ),
                      ],
                    )),
            !canEditFiles ? Container() : spaceY(10.0.sp),
            !canEditFiles
                ? Container()
                : primaryButton(
                    onTap: () async {
                      // XFile? image;
                      Utils.customDialog(
                          actions: [
                            primaryButton(
                              onTap: () async {
                                var image = await _controller.toPngBytes();
                                Directory tmp = await getTemporaryDirectory();
                                String path =
                                    "${tmp.path}com_sig${DateTime.now().millisecondsSinceEpoch}.png";
                                logSuccess(await File(path).exists());

                                if (await File(path).exists()) {
                                  await File(path).delete();
                                  logSuccess(await File(path).exists());
                                }
                                signature = await File(path).writeAsBytes(
                                  image!,
                                  mode: FileMode.writeOnly,
                                );
                                companyInformation.signatureOfficial =
                                    signature;
                                setState(() {});
                                Get.back();
                              },
                              color: Theme.of(context).colorScheme.primary,
                              text: coloredText(
                                  text: "accept".tr, color: Colors.white),
                            ),
                            primaryButton(
                              onTap: () async {
                                _controller.clear();
                                setState(() {});
                              },
                              color: Theme.of(context).colorScheme.primary,
                              text: coloredText(
                                  text: "clear".tr, color: Colors.white),
                            )
                          ],
                          onClose: (p0) {},
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              child: Signature(
                                controller: _controller,
                                height: 50.h,
                                // width: 100.w,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          context: context);
                    },
                    color: const Color(0xffF5F5F5),
                    width: 100.0.w,
                    height: 55,
                    radius: 10,
                    text: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            spaceX(10),
                            Icon(
                              Icons.fingerprint,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18.0.sp,
                            ),
                            spaceX(10),
                            SizedBox(
                              width: 65.w,
                              child: coloredText(
                                overflow: TextOverflow.ellipsis,
                                text: signitureButton,
                                color: const Color(0xff919191),
                                fontSize: 13.0.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0.sp,
                            ),
                            spaceX(10),
                          ],
                        ),
                      ],
                    )),
            spaceY(40.0.sp),
            primaryButton(
              onTap: () async {
                FocusScope.of(context).unfocus();

                var x = await _globalController.updateCompanyProfile(
                    companyInformation: companyInformation);
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
