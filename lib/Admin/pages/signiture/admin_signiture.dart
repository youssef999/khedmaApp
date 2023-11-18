import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Pages/global_controller.dart';
// import 'package:khedma/Admin/controlle rs/admin_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/send_items_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';

class AdminSigniturePage extends StatefulWidget {
  const AdminSigniturePage({super.key});

  @override
  State<AdminSigniturePage> createState() => _AdminSigniturePageState();
}

class _AdminSigniturePageState extends State<AdminSigniturePage> {
  // AdminController _adminController = Get.find();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  File? signature;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                    text: "signiture".tr,
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
                child: GetBuilder<GlobalController>(builder: (c) {
                  return Column(
                    children: [
                      Container(
                        // width: 100.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(c.me.signatureOfficial ?? ""),
                          ),
                        ),
                      ),
                      spaceY(10.sp),
                      primaryButton(
                        color: Theme.of(context).colorScheme.primary,
                        text: coloredText(text: "edit".tr, color: Colors.white),
                        onTap: () async {
                          XFile? image;
                          _controller.clear();
                          List<SendMenuItems> menuItems = [
                            SendMenuItems(
                              text: "draw".tr,
                              icons: EvaIcons.edit2,
                              color: Colors.red,
                              onTap: () async {
                                Get.back();
                                Utils.customDialog(
                                    actions: [
                                      primaryButton(
                                        onTap: () async {
                                          var image =
                                              await _controller.toPngBytes();
                                          Directory tmp =
                                              await getTemporaryDirectory();
                                          String path =
                                              "${tmp.path}admin_sig${DateTime.now().millisecondsSinceEpoch}.png";
                                          logSuccess(await File(path).exists());

                                          if (await File(path).exists()) {
                                            await File(path).delete();
                                            logSuccess(
                                                await File(path).exists());
                                          }
                                          signature =
                                              await File(path).writeAsBytes(
                                            image!,
                                            mode: FileMode.writeOnly,
                                          );
                                          var x = await c.updateAdminProfile(
                                            signatureOfficial: signature,
                                            email: c.me.email,
                                            phone: c.me.phone,
                                            name: c.me.fullName,
                                          );
                                          if (x.runtimeType == bool) {
                                            Utils.doneDialog(
                                                context: context, backTimes: 2);
                                          }
                                          _controller.clear();
                                          setState(() {});
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        text: coloredText(
                                            text: "accept".tr,
                                            color: Colors.white),
                                      )
                                    ],
                                    onClose: (p0) {
                                      _controller.clear();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                            ),
                            SendMenuItems(
                              text: "gallery".tr,
                              icons: EvaIcons.image,
                              color: Colors.green,
                              onTap: () async {
                                bool b = await Utils.checkPermissionGallery();
                                if (b) {
                                  image = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 480,
                                      maxWidth: 640,
                                      imageQuality: 50);
                                }
                                Get.back();
                                File f = File(image!.path);
                                var x = await c.updateAdminProfile(
                                  signatureOfficial: f,
                                  email: c.me.email,
                                  phone: c.me.phone,
                                  name: c.me.fullName,
                                );
                                if (x.runtimeType == bool) {
                                  Utils.doneDialog(context: context);
                                }
                              },
                            )
                          ];

                          await showModalBottomSheet(
                              context: Get.context!,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  color: const Color(0xff737373),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        spaceY(16),
                                        Center(
                                          child: Container(
                                            height: 4,
                                            width: 50,
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                        spaceY(10),
                                        ListView.builder(
                                          itemCount: menuItems.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: ListTile(
                                                onTap: menuItems[index].onTap,
                                                leading: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: menuItems[index]
                                                        .color
                                                        .shade50,
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                  child: Icon(
                                                    menuItems[index].icons,
                                                    size: 20,
                                                    color: menuItems[index]
                                                        .color
                                                        .shade400,
                                                  ),
                                                ),
                                                title:
                                                    Text(menuItems[index].text),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
