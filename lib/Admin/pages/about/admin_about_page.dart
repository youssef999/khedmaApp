import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/models/about_model.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:sizer/sizer.dart';

class AdminAboutPage extends StatefulWidget {
  const AdminAboutPage({super.key});

  @override
  State<AdminAboutPage> createState() => _AdminAddressesPageState();
}

class _AdminAddressesPageState extends State<AdminAboutPage> {
  AdminController _adminController = Get.find();
  AboutModel aboutModel = AboutModel();
  @override
  void initState() {
    if (_adminController.aboutModel != null) {
      _textEditingController.text = _adminController.aboutModel!.about!;
      aboutModel = AboutModel.fromJson(_adminController.aboutModel!.toJson());
    }
    super.initState();
  }

  TextEditingController _textEditingController = TextEditingController();

  bool editing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ])),
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 15.h,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  coloredText(
                    text: "about_app".tr,
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                  spaceX(10)
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                width: 100.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      spaceY(10.sp),
                      editing || _textEditingController.text == ""
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  child: TextFormField(
                                    maxLines: 10,
                                    controller: _textEditingController,
                                    onChanged: (value) {
                                      aboutModel.about = value;
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
                                spaceY(30.sp),
                                primaryButton(
                                    onTap: () async {
                                      bool b = await _adminController
                                          .updateAbout(about: aboutModel);
                                      if (b) {
                                        Utils.doneDialog(context: context);
                                        editing = false;
                                        setState(() {});
                                      } else {}
                                    },
                                    text: coloredText(
                                      text: "submit".tr,
                                      color: Colors.white,
                                    ),
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ]))
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 30.h,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF8F8F8),
                                  ),
                                  child: coloredText(
                                      text: _textEditingController.text,
                                      fontSize: 12.sp),
                                ),
                                spaceY(30.sp),
                                primaryButton(
                                    onTap: () {
                                      editing = true;
                                      setState(() {});
                                    },
                                    text: coloredText(
                                      text: "edit".tr,
                                      color: Colors.white,
                                    ),
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ]))
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
