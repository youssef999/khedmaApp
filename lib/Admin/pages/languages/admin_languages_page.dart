import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/categories/admin_categories_page.dart';
import 'package:khedma/Admin/pages/languages/controller/languages_controller.dart';
import 'package:khedma/Admin/pages/languages/models/language_model.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:sizer/sizer.dart';

class AdminLanguagesPage extends StatefulWidget {
  const AdminLanguagesPage({super.key});

  @override
  State<AdminLanguagesPage> createState() => _AdminLanguagesPageState();
}

class _AdminLanguagesPageState extends State<AdminLanguagesPage> {
  LanguagesController _languagesController = Get.find();
  @override
  void initState() {
    _languagesController.getlanguages();
    super.initState();
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
                    text: "langs".tr,
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
                child: tab1(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tab1() => GetBuilder<LanguagesController>(builder: (c) {
        return Column(
          children: [
            primaryBorderedButton(
                onTap: () {
                  LanguageModel lang = LanguageModel();
                  Utils.showDialogBox(
                    context: context,
                    actions: [
                      primaryButton(
                        onTap: () async {
                          Get.back();
                          bool b = await c.createlanguage(
                            language: lang,
                          );
                          if (b) {
                            Utils.doneDialog(context: context);
                          }
                        },
                        color: Colors.black,
                        width: 50.w,
                        height: 40.sp,
                        text: coloredText(text: "edit".tr, color: Colors.white),
                      ),
                    ],
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(text: "name_ar".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 40.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: lang.nameAr,
                              onChanged: (value) {
                                lang.nameAr = value;
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
                                fillColor: Color(0xffF5F5F5),
                              ),
                            ),
                          ),
                          spaceY(10.sp),
                          coloredText(text: "name_en".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 40.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: lang.nameEn,
                              onChanged: (value) {
                                lang.nameEn = value;
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
                                fillColor: Color(0xffF5F5F5),
                              ),
                            ),
                          ),
                          spaceY(10.sp),
                          coloredText(text: "short_name".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 40.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: lang.shortName,
                              onChanged: (value) {
                                lang.shortName = value;
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
                                fillColor: Color(0xffF5F5F5),
                              ),
                            ),
                          ),
                          spaceY(10.sp),
                          coloredText(text: "slug"),
                          spaceY(5.sp),
                          SizedBox(
                            height: 40.sp,
                            child: TextFormField(
                              // maxLines: 1,

                              initialValue: lang.slug,
                              onChanged: (value) {
                                lang.slug = value;
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
                                fillColor: Color(0xffF5F5F5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            EvaIcons.close,
                          ),
                        )
                      ],
                    ),
                  );
                },
                width: 100.w,
                text: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(EvaIcons.plus, color: Colors.black, size: 20.sp),
                    spaceX(10.sp),
                    coloredText(text: "create_new".tr),
                  ],
                ),
                color: Colors.black),
            spaceY(20.sp),
            Expanded(
              child: c.getlanguagesFlag
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => AdminItemCard(
                            noIcon: true,
                            name:
                                "${c.languages[index].nameEn!} - ${c.languages[index].nameAr!}",
                            margin: const EdgeInsets.only(bottom: 10),
                            trailing: Theme(
                              data: ThemeData(primaryColor: Colors.white),
                              child: PopupMenuButton(
                                constraints: BoxConstraints(
                                  minWidth: 2.0 * 56.0,
                                  maxWidth: MediaQuery.of(context).size.width,
                                ),
                                itemBuilder: (BuildContext cc) => [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Row(
                                      children: [
                                        Icon(EvaIcons.editOutline, size: 15.sp),
                                        spaceX(5.sp),
                                        coloredText(
                                            text: 'edit'.tr, fontSize: 12.0.sp),
                                      ],
                                    ),
                                    onTap: () {
                                      LanguageModel lang =
                                          LanguageModel.fromJson(
                                              c.languages[index].toJson());
                                      Utils.showDialogBox(
                                        context: context,
                                        actions: [
                                          primaryButton(
                                            onTap: () async {
                                              Get.back();
                                              bool b = await c.updatelanguage(
                                                language: lang,
                                              );
                                              if (b) {
                                                Utils.doneDialog(
                                                    context: context);
                                              }
                                            },
                                            color: Colors.black,
                                            width: 50.w,
                                            height: 40.sp,
                                            text: coloredText(
                                                text: "edit".tr,
                                                color: Colors.white),
                                          ),
                                        ],
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              coloredText(text: "name_ar".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 40.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue: lang.nameAr,
                                                  onChanged: (value) {
                                                    lang.nameAr = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    // hintText: "write_your_notes".tr,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffF5F5F5),
                                                  ),
                                                ),
                                              ),
                                              spaceY(10.sp),
                                              coloredText(text: "name_en".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 40.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue: lang.nameEn,
                                                  onChanged: (value) {
                                                    lang.nameEn = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    // hintText: "write_your_notes".tr,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffF5F5F5),
                                                  ),
                                                ),
                                              ),
                                              spaceY(10.sp),
                                              coloredText(
                                                  text: "short_name".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 40.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue: lang.shortName,
                                                  onChanged: (value) {
                                                    lang.shortName = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    // hintText: "write_your_notes".tr,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffF5F5F5),
                                                  ),
                                                ),
                                              ),
                                              spaceY(10.sp),
                                              coloredText(text: "slug"),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 40.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,

                                                  initialValue: lang.slug,
                                                  onChanged: (value) {
                                                    lang.slug = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    // hintText: "write_your_notes".tr,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffF5F5F5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: const Icon(
                                                EvaIcons.close,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Icon(EvaIcons.trash2Outline,
                                            size: 15.sp),
                                        spaceX(5.sp),
                                        coloredText(
                                            text: 'delete'.tr,
                                            fontSize: 12.0.sp),
                                      ],
                                    ),
                                    onTap: () async {
                                      bool b = await c.deletelanguage(
                                        language: c.languages[index],
                                      );
                                      if (b) {
                                        Utils.doneDialog(context: context);
                                      }
                                    },
                                  ),
                                ],
                                child: const Icon(
                                  EvaIcons.moreVertical,
                                ),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => spaceY(10.sp),
                      itemCount: c.languages.length),
            )
          ],
        );
      });
}
