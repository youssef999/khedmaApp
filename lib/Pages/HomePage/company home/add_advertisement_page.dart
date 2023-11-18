// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart' as db;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Pages/HomePage/company%20home/company_home_page.dart';
import 'package:khedma/Pages/HomePage/controllers/advertisment_controller.dart';
import 'package:khedma/Pages/HomePage/models/advertisment_model.dart';
import 'package:khedma/Themes/themes.dart';
import 'package:khedma/web_view_container.dart';
import 'package:khedma/widgets/radio_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class AddAdvertismentPage extends StatefulWidget {
  const AddAdvertismentPage({super.key, this.advertismentToEdit});
  final AdvertismentModel? advertismentToEdit;
  @override
  State<AddAdvertismentPage> createState() => _AddAdvertismentPageState();
}

class _AddAdvertismentPageState extends State<AddAdvertismentPage> {
  AdvertismentController _advertismentController = Get.find();
  AdvertismentModel advertismentToCreate = AdvertismentModel();
  AdminController _adminController = Get.find();
  double price = 0;
  int durationRadio = 0;
  int promotionRadio = 1;
  int durationCounter = 0;

  String uploadButtontext = "${"upload".tr} ${"photo".tr}";
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  @override
  void initState() {
    if (widget.advertismentToEdit != null) {
      _dateController.text = DateFormat('y/MM/dd')
          .format(DateTime.parse(widget.advertismentToEdit!.startDate!));
      durationCounter = widget.advertismentToEdit!.durationByDay!;
      price = double.parse(widget.advertismentToEdit!.amount!);
      uploadButtontext = widget.advertismentToEdit!.image.toString().substring(
          widget.advertismentToEdit!.image.toString().lastIndexOf("/") + 1);
      promotionRadio = widget.advertismentToEdit!.promotionType!;
      if (promotionRadio == 2) {
        linkController.text = widget.advertismentToEdit!.externalLink!;
      }
    }
    super.initState();
  }

  ScreenshotController controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: GestureDetector(
            onTap: () {
              Utils.takeContainer(controller, "add_advertisment.png");
            },
            child: coloredText(
                text: widget.advertismentToEdit != null
                    ? "edit".tr
                    : "add_advertisment".tr,
                fontSize: 15.0.sp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            primary: false,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              db.DottedBorder(
                dashPattern: const [6, 6, 6, 6],
                padding: const EdgeInsets.all(1),
                radius: const Radius.circular(10),
                color: const Color(0xffAEAEAE),
                borderType: db.BorderType.RRect,
                child: primaryButton(
                  radius: 10,
                  onTap: () async {
                    XFile? image = await Utils().selectImageSheet();

                    if (image != null) {
                      setState(() {});

                      // double aspectRatio =
                      //     (decodedImage.width / decodedImage.height)
                      //         .toPrecision(1);
                      // if (aspectRatio == 1.8) {
                      File f = File(image.path);
                      var decodedImage =
                          await decodeImageFromList(f.readAsBytesSync());
                      if (decodedImage.width == 1920 &&
                          decodedImage.height == 1080) {
                        uploadButtontext =
                            image.name.substring(0, min(15, image.name.length));
                        if (widget.advertismentToEdit != null) {
                          widget.advertismentToEdit!.image = image;
                        } else {
                          advertismentToCreate.image = image;
                        }
                        setState(() {});
                      } else {
                        Utils.customDialog(
                            actions: [
                              primaryButton(
                                onTap: () => Get.back(),
                                text: coloredText(
                                  text: "close".tr,
                                  color: Colors.white,
                                ),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: coloredText(
                                  text: "image_ratio".tr,
                                  textAlign: TextAlign.center,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            context: context);
                      }
                    }
                  },
                  width: 100.0.w,
                  height: 15.h,
                  color: const Color(0xffAEAEAE).withOpacity(0.1),
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        EvaIcons.upload,
                        color: Colors.black,
                      ),
                      spaceX(10),
                      coloredText(
                        text: uploadButtontext,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              spaceY(10),
              Row(
                children: [
                  Icon(
                    EvaIcons.infoOutline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  spaceX(10),
                  coloredText(
                    text: "image_ratio".tr,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              spaceY(20),
              coloredText(text: "duration".tr, fontSize: 15.sp),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: 60.w,
                  height: 38.sp,
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      coloredText(
                        text: "$durationCounter ${"day".tr}",
                        color: const Color(0xff919191),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              durationCounter++;
                              price = double.parse(_adminController
                                      .settingAdmin.advertisementPrice!) *
                                  durationCounter;
                              if (widget.advertismentToEdit != null) {
                                widget.advertismentToEdit!.durationByDay =
                                    durationCounter;
                              } else {
                                advertismentToCreate.durationByDay =
                                    durationCounter;
                              }
                              setState(() {});
                            },
                            child: Icon(
                              EvaIcons.plusCircleOutline,
                              size: 16.sp,
                              color: Color(0xff919191),
                            ),
                          ),
                          spaceX(10),
                          GestureDetector(
                            onTap: () {
                              if (durationCounter > 0) {
                                durationCounter--;
                                price = double.parse(_adminController
                                        .settingAdmin.advertisementPrice!) *
                                    durationCounter;
                                if (widget.advertismentToEdit != null) {
                                  widget.advertismentToEdit!.durationByDay =
                                      durationCounter;
                                } else {
                                  advertismentToCreate.durationByDay =
                                      durationCounter;
                                }
                              }
                              setState(() {});
                            },
                            child: Icon(
                              EvaIcons.minusCircleOutline,
                              size: 16.sp,
                              color: Color(0xff919191),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              spaceY(20),
              coloredText(text: "promotion_url".tr, fontSize: 15.sp),
              Column(
                children: [
                  MyRadioButton(
                    color: Colors.black,
                    text: "company_page".tr,
                    groupValue: promotionRadio,
                    value: 1,
                    onChanged: (p0) {
                      setState(() {
                        promotionRadio = 1;
                        if (widget.advertismentToEdit != null) {
                          widget.advertismentToEdit!.promotionType =
                              promotionRadio;
                          widget.advertismentToEdit!.externalLink = null;
                        } else {
                          advertismentToCreate.promotionType = promotionRadio;
                          advertismentToCreate.externalLink = null;
                        }

                        setState(() {});
                      });
                    },
                  ),
                  spaceY(5),
                  MyRadioButton(
                    color: Colors.black,
                    text: "external_link".tr,
                    groupValue: promotionRadio,
                    value: 2,
                    onChanged: (p0) {
                      setState(() {
                        promotionRadio = 2;
                        if (widget.advertismentToEdit != null) {
                          widget.advertismentToEdit!.promotionType =
                              promotionRadio;
                        } else {
                          advertismentToCreate.promotionType = promotionRadio;
                        }

                        setState(() {});
                      });
                    },
                  )
                ],
              ),
              spaceY(20),
              promotionRadio == 1
                  ? Container()
                  : SendMessageTextField(
                      borderRadius: 10,
                      fillColor: const Color(0xffF3F2F2),
                      autovalidateMode: AutovalidateMode.always,
                      controller: linkController,
                      onchanged: (s) {
                        if (widget.advertismentToEdit != null) {
                          widget.advertismentToEdit!.externalLink = s;
                        } else {
                          advertismentToCreate.externalLink = s;
                        }
                      },
                      validator: (s) {
                        var urlPattern =
                            r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                        bool validURL = RegExp(urlPattern, caseSensitive: false)
                            .hasMatch(s!);

                        if (!validURL && s.isNotEmpty) {
                          return "must be a valid link";
                        }
                        return null;
                      },
                      focusNode: FocusNode(),
                    ),
              promotionRadio == 1 ? Container() : spaceY(20),
              coloredText(text: "start_date".tr, fontSize: 15.sp),
              // CustomDropDownMenuButton(
              //   height: 38.sp,
              //   items: ["item", "item2"]
              //       .map(
              //         (e) => DropdownMenuItem<String>(
              //           value: e,
              //           child: coloredText(text: e, color: Colors.black),
              //         ),
              //       )
              //       .toList(),
              //   onChanged: (p0) {},
              //   fillColor: const Color(0xffF3F2F2),
              //   borderc: Border.all(color: const Color(0xffF3F2F2)),
              //   borderRadius: BorderRadius.circular(8),
              //   padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
              // ),
              SendMessageTextField(
                onTap: () async {
                  DateTime? x = await showDatePicker(
                    builder: (context, child) => Theme(
                      data: ThemeData(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: AppThemes.colorCustom,
                        ),
                      ),
                      child: child!,
                    ),
                    context: context,
                    initialDate: DateTime.now().add(
                      const Duration(days: 2),
                    ),
                    firstDate: DateTime.now().add(
                      const Duration(days: 2),
                    ),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365 * 15),
                    ),
                  );
                  if (x != null) {
                    _dateController.text = DateFormat('y/MM/dd').format(x);
                  }
                },
                focusNode: FocusNode(),
                hintText: 'YYYY/MM/DD',
                fillColor: const Color(0xffF8F8F8),
                borderRadius: 10,
                controller: _dateController,
                readOnly: true,
              ),

              spaceY(20),
              Row(
                children: [
                  coloredText(text: "${"price".tr} :", fontSize: 15.sp),
                  spaceX(50),
                  primaryButton(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1),
                    width: 35.0.w,
                    height: 45,
                    radius: 8,
                    text: coloredText(
                        text: "$price ${'kwd'.tr}",
                        fontSize: 13.0.sp,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              spaceY(40),
              primaryButton(
                  onTap: () async {
                    if (widget.advertismentToEdit != null) {
                      widget.advertismentToEdit!.startDate =
                          _dateController.text;
                      widget.advertismentToEdit!.promotionType = promotionRadio;
                      widget.advertismentToEdit!.amount = (int.parse(
                                  _adminController
                                      .settingAdmin.advertisementPrice!) *
                              durationCounter)
                          .toString();
                      bool b = await _advertismentController.updateAdvertisment(
                          advertisment: widget.advertismentToEdit!);
                      if (b) {
                        Utils.doneDialog(
                          context: context,
                          onTap: () {
                            Get.to(() => CompanyHomePage());
                          },
                        );
                      }
                    } else {
                      advertismentToCreate.startDate = _dateController.text;
                      advertismentToCreate.promotionType = promotionRadio;
                      advertismentToCreate.amount = (int.parse(_adminController
                                  .settingAdmin.advertisementPrice!) *
                              durationCounter)
                          .toString();

                      String? b =
                          await _advertismentController.createAdvertisment(
                              advertisment: advertismentToCreate);
                      if (b != null) {
                        Get.to(() => WebViewContainer(
                                  url: b,
                                ))!
                            .then((value) {
                          Utils.customDialog(
                              actions: [
                                primaryButton(
                                  onTap: () async {
                                    Get.back();
                                    Get.back();

                                    // Uri url = Uri.parse(b);
                                    // await launchUrl(url,
                                    //     mode: LaunchMode.externalApplication);

                                    // await Future.delayed(
                                    //     Duration(milliseconds: 100));
                                    // while (WidgetsBinding.instance.lifecycleState !=
                                    //     AppLifecycleState.resumed) {
                                    //   await Future.delayed(
                                    //       Duration(milliseconds: 100));
                                    // }
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 40.sp,
                                    ),
                                    spaceY(20),
                                    coloredText(
                                        text: "your_advertisment_has_added".tr,
                                        fontSize: 12.0.sp),
                                    coloredText(
                                      text: "successfully".tr,
                                      fontSize: 14.0.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ],
                                ),
                              ));
                        });
                      }
                    }
                  },
                  width: 50.0.w,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ]),
                  text: coloredText(
                    text: widget.advertismentToEdit != null
                        ? "edit".tr
                        : "add".tr,
                    color: Colors.white,
                  )),
              spaceY(20),
            ],
          ),
        ),
      ),
    );
  }
}
