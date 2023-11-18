// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Utils/utils.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _textEditingController = TextEditingController();
  AdminController _adminController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: coloredText(text: "contact".tr, fontSize: 15.0.sp),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          children: [
            // spaceY(10.sp),
            coloredText(
              text: "contact".tr,
            ),
            spaceY(3.sp),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () {
                  if (_adminController.contactModel != null) {
                    launchUrlString(
                        "tel://+965${_adminController.contactModel!.phoneNumber!}");
                  }
                },
                child: coloredText(
                  textDirection: TextDirection.ltr,
                  text:
                      "+965${_adminController.contactModel != null ? _adminController.contactModel!.phoneNumber! : ""}",
                  fontSize: 12.sp,
                  color: Colors.grey,
                  // textAlign: TextAlign.justify,
                ),
              ),
            ),
            spaceY(3.sp),
            GestureDetector(
              onTap: () {
                if (_adminController.contactModel != null)
                  launchUrlString(
                      "mailto:${_adminController.contactModel!.email!}?subject=Khedmah%20Feedback");
              },
              child: coloredText(
                text:
                    "${_adminController.contactModel != null ? _adminController.contactModel!.email! : ""}",
                fontSize: 12.sp,
                color: Colors.grey,
                // textAlign: TextAlign.justify,
              ),
            ),
            spaceY(10.sp),
            GestureDetector(
              onTap: () {
                whatsapp();
              },
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                  spaceX(10.sp),
                  coloredText(
                      text: "whatsapp".tr,
                      fontSize: 15.sp,
                      textAlign: TextAlign.center,
                      color: Colors.green)
                ],
              ),
            ),
            spaceY(10.sp),
            coloredText(
              text: "send_message".tr,
              // fontSize: 14.sp,
              // textAlign: TextAlign.justify,/
            ),
            spaceY(5.sp),
            SizedBox(
              height: 30.h,
              child: TextFormField(
                maxLines: 10,
                controller: _textEditingController,
                onChanged: (value) {
                  // aboutModel.about = value;
                },
                decoration: const InputDecoration(
                  // hintText: "write_your_notes".tr,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xffF8F8F8),
                ),
              ),
            ),
            spaceY(10.sp),

            primaryButton(
              onTap: () async {
                FocusScope.of(context).unfocus();
                bool x = await _adminController.storeMessage(
                    message: _textEditingController.text);
                if (x) {
                  Utils.doneDialog(context: context, backTimes: 2);
                }
              },
              text: coloredText(text: "send".tr, color: Colors.white),
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ));
  }

  whatsapp() async {
    var contact = "+905519971930";
    var url = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    // var iosUrl =
    //     "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      // if (Platform.isIOS) {
      //   await launchUrl(Uri.parse(iosUrl));
      // } else {
      await launchUrl(Uri.parse(url));
      // }
    } on Exception {}
  }
}
