import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/categories/admin_categories_page.dart';
import 'package:khedma/Admin/pages/dropdowns/controller/dropdown_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/certificate_.dart';
import 'package:khedma/models/complexion.dart';
import 'package:khedma/models/marital_status.dart';
import 'package:khedma/models/relegion.dart';
import 'package:sizer/sizer.dart';

class AdminDropDownsPage extends StatefulWidget {
  const AdminDropDownsPage({super.key});

  @override
  State<AdminDropDownsPage> createState() => _AdminDropDownsPageState();
}

class _AdminDropDownsPageState extends State<AdminDropDownsPage>
    with SingleTickerProviderStateMixin {
  // GlobalController _globalController = Get.find();
  // dropdownsController _adressControllerController = Get.find();
  List<String> tabs = [
    "religion",
    "complexion",
    "marital_status",
    "educational_certificates",
  ];
  late TabController tabController;
  int selectedTabIndex = 0;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);

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
                    text: "drop_downs".tr,
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
                child: Column(
                  children: [
                    spaceY(10.sp),
                    TabBar(
                        dividerColor: Colors.grey,
                        // indicatorColor: Colors.black,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        )),
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        controller: tabController,
                        onTap: (value) {
                          selectedTabIndex = value;
                          setState(() {});
                        },
                        tabs: List<Widget>.generate(
                          tabController.length,
                          (index) => Tab(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: coloredText(
                                  fontSize: 11.sp,
                                  text: tabs[index].tr,
                                  color: selectedTabIndex == index
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                          ),
                        )),
                    Expanded(
                        child: TabBarView(
                      controller: tabController,
                      children: [
                        tab1(),
                        tab2(),
                        tab3(),
                        tab4(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tab1() => GetBuilder<GlobalController>(builder: (globalController) {
        return GetBuilder<DropDownsController>(builder: (dropdownsController) {
          return Column(
            children: [
              spaceY(20.sp),
              primaryBorderedButton(
                  onTap: () {
                    RelegionModel relegion = RelegionModel();
                    Utils.showDialogBox(
                      context: context,
                      actions: [
                        primaryButton(
                          onTap: () async {
                            Get.back();
                            bool b = await dropdownsController.createReligion(
                                relegionModel: relegion);
                            // ignore: use_build_context_synchronously
                            if (b) Utils.doneDialog(context: context);
                          },
                          color: Colors.black,
                          width: 50.w,
                          height: 40.sp,
                          text: coloredText(
                              text: "create".tr, color: Colors.white),
                        ),
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(text: "name_ar".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: relegion.nameAr,
                              onChanged: (value) {
                                relegion.nameAr = value;
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
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: relegion.nameEn,
                              onChanged: (value) {
                                relegion.nameEn = value;
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
              spaceY(10.sp),
              Expanded(
                child: globalController.getRelegionsFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AdminItemCard(
                              noIcon: true,
                              name:
                                  "${globalController.relegions[index].nameEn!} - ${globalController.relegions[index].nameAr!}",
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
                                          Icon(EvaIcons.editOutline,
                                              size: 15.sp),
                                          spaceX(5.sp),
                                          coloredText(
                                              text: 'edit'.tr,
                                              fontSize: 12.0.sp),
                                        ],
                                      ),
                                      onTap: () {
                                        RelegionModel relegionModel =
                                            RelegionModel.fromJson(
                                                globalController
                                                    .relegions[index]
                                                    .toJson());
                                        Utils.showDialogBox(
                                          context: context,
                                          actions: [
                                            primaryButton(
                                              onTap: () async {
                                                Get.back();
                                                bool b =
                                                    await dropdownsController
                                                        .updateRelegion(
                                                            relegionModel:
                                                                relegionModel);
                                                // ignore: use_build_context_synchronously
                                                if (b)
                                                  Utils.doneDialog(
                                                      context: context);
                                              },
                                              color: Colors.black,
                                              width: 50.w,
                                              height: 40.sp,
                                              text: coloredText(
                                                  text: "create".tr,
                                                  color: Colors.white),
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              coloredText(text: "name_ar".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      relegionModel.nameAr,
                                                  onChanged: (value) {
                                                    relegionModel.nameAr =
                                                        value;
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
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      relegionModel.nameEn,
                                                  onChanged: (value) {
                                                    relegionModel.nameEn =
                                                        value;
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

                                        //  Utils.doneDialog(context: context);
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
                                        bool b = await dropdownsController
                                            .deleteRelegion(
                                          relegionModel:
                                              globalController.relegions[index],
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
                        itemCount: globalController.relegions.length),
              )
            ],
          );
        });
      });
  Widget tab2() => GetBuilder<GlobalController>(builder: (globalController) {
        return GetBuilder<DropDownsController>(builder: (dropdownsController) {
          return Column(
            children: [
              spaceY(20.sp),
              primaryBorderedButton(
                  onTap: () {
                    ComplexionModel complexion = ComplexionModel();
                    Utils.showDialogBox(
                      context: context,
                      actions: [
                        primaryButton(
                          onTap: () async {
                            Get.back();
                            bool b = await dropdownsController.createComplexion(
                                complexionModel: complexion);
                            // ignore: use_build_context_synchronously
                            if (b) Utils.doneDialog(context: context);
                          },
                          color: Colors.black,
                          width: 50.w,
                          height: 40.sp,
                          text: coloredText(
                              text: "create".tr, color: Colors.white),
                        ),
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(text: "name_ar".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: complexion.nameAr,
                              onChanged: (value) {
                                complexion.nameAr = value;
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
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: complexion.nameEn,
                              onChanged: (value) {
                                complexion.nameEn = value;
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
              spaceY(10.sp),
              Expanded(
                child: globalController.getComplexionFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AdminItemCard(
                              noIcon: true,
                              name:
                                  "${globalController.complexionList[index].nameEn!} - ${globalController.complexionList[index].nameAr!}",
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
                                          Icon(EvaIcons.editOutline,
                                              size: 15.sp),
                                          spaceX(5.sp),
                                          coloredText(
                                              text: 'edit'.tr,
                                              fontSize: 12.0.sp),
                                        ],
                                      ),
                                      onTap: () {
                                        ComplexionModel complexionModel =
                                            ComplexionModel.fromJson(
                                                globalController
                                                    .complexionList[index]
                                                    .toJson());
                                        Utils.showDialogBox(
                                          context: context,
                                          actions: [
                                            primaryButton(
                                              onTap: () async {
                                                Get.back();
                                                bool b =
                                                    await dropdownsController
                                                        .updateComplexion(
                                                            complexionModel:
                                                                complexionModel);
                                                // ignore: use_build_context_synchronously
                                                if (b)
                                                  Utils.doneDialog(
                                                      context: context);
                                              },
                                              color: Colors.black,
                                              width: 50.w,
                                              height: 40.sp,
                                              text: coloredText(
                                                  text: "create".tr,
                                                  color: Colors.white),
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              coloredText(text: "name_ar".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      complexionModel.nameAr,
                                                  onChanged: (value) {
                                                    complexionModel.nameAr =
                                                        value;
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
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      complexionModel.nameEn,
                                                  onChanged: (value) {
                                                    complexionModel.nameEn =
                                                        value;
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

                                        //  Utils.doneDialog(context: context);
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
                                        bool b = await dropdownsController
                                            .deleteComplexion(
                                          complexionModel: globalController
                                              .complexionList[index],
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
                        itemCount: globalController.complexionList.length),
              )
            ],
          );
        });
      });

  Widget tab3() => GetBuilder<GlobalController>(builder: (globalController) {
        return GetBuilder<DropDownsController>(builder: (dropdownsController) {
          return Column(
            children: [
              spaceY(20.sp),
              primaryBorderedButton(
                  onTap: () {
                    MaritalStatusModel maritalModel = MaritalStatusModel();
                    Utils.showDialogBox(
                      context: context,
                      actions: [
                        primaryButton(
                          onTap: () async {
                            Get.back();
                            bool b = await dropdownsController.createMarital(
                                marital: maritalModel);
                            // ignore: use_build_context_synchronously
                            if (b) Utils.doneDialog(context: context);
                          },
                          color: Colors.black,
                          width: 50.w,
                          height: 40.sp,
                          text: coloredText(
                              text: "create".tr, color: Colors.white),
                        ),
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(text: "name_ar".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: maritalModel.nameAr,
                              onChanged: (value) {
                                maritalModel.nameAr = value;
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
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: maritalModel.nameEn,
                              onChanged: (value) {
                                maritalModel.nameEn = value;
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
              spaceY(10.sp),
              Expanded(
                child: globalController.getMaritalStatusFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AdminItemCard(
                              noIcon: true,
                              name:
                                  "${globalController.maritalStatusList[index].nameEn!} - ${globalController.maritalStatusList[index].nameAr!}",
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
                                          Icon(EvaIcons.editOutline,
                                              size: 15.sp),
                                          spaceX(5.sp),
                                          coloredText(
                                              text: 'edit'.tr,
                                              fontSize: 12.0.sp),
                                        ],
                                      ),
                                      onTap: () {
                                        MaritalStatusModel maritalModel =
                                            MaritalStatusModel.fromJson(
                                                globalController
                                                    .maritalStatusList[index]
                                                    .toJson());
                                        Utils.showDialogBox(
                                          context: context,
                                          actions: [
                                            primaryButton(
                                              onTap: () async {
                                                Get.back();
                                                bool b =
                                                    await dropdownsController
                                                        .updateMarital(
                                                            marital:
                                                                maritalModel);
                                                // ignore: use_build_context_synchronously
                                                if (b)
                                                  Utils.doneDialog(
                                                      context: context);
                                              },
                                              color: Colors.black,
                                              width: 50.w,
                                              height: 40.sp,
                                              text: coloredText(
                                                  text: "create".tr,
                                                  color: Colors.white),
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              coloredText(text: "name_ar".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      maritalModel.nameAr,
                                                  onChanged: (value) {
                                                    maritalModel.nameAr = value;
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
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      maritalModel.nameEn,
                                                  onChanged: (value) {
                                                    maritalModel.nameEn = value;
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

                                        //  Utils.doneDialog(context: context);
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
                                        bool b = await dropdownsController
                                            .deleteMarital(
                                          marital: globalController
                                              .maritalStatusList[index],
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
                        itemCount: globalController.maritalStatusList.length),
              )
            ],
          );
        });
      });
  Widget tab4() => GetBuilder<GlobalController>(builder: (globalController) {
        return GetBuilder<DropDownsController>(builder: (dropdownsController) {
          return Column(
            children: [
              spaceY(20.sp),
              primaryBorderedButton(
                  onTap: () {
                    CertificateModel certificate = CertificateModel();
                    Utils.showDialogBox(
                      context: context,
                      actions: [
                        primaryButton(
                          onTap: () async {
                            Get.back();
                            bool b =
                                await dropdownsController.createCertificate(
                                    certificateModel: certificate);
                            // ignore: use_build_context_synchronously
                            if (b) Utils.doneDialog(context: context);
                          },
                          color: Colors.black,
                          width: 50.w,
                          height: 40.sp,
                          text: coloredText(
                              text: "create".tr, color: Colors.white),
                        ),
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(text: "name_ar".tr),
                          spaceY(5.sp),
                          SizedBox(
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: certificate.nameAr,
                              onChanged: (value) {
                                certificate.nameAr = value;
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
                            height: 35.sp,
                            child: TextFormField(
                              // maxLines: 1,
                              initialValue: certificate.nameEn,
                              onChanged: (value) {
                                certificate.nameEn = value;
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
              spaceY(10.sp),
              Expanded(
                child: globalController.getCertificatesFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AdminItemCard(
                              noIcon: true,
                              name: Get.locale == const Locale("en", "US")
                                  ? globalController.certificates[index].nameEn!
                                  : globalController
                                      .certificates[index].nameAr!,
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
                                          Icon(EvaIcons.editOutline,
                                              size: 15.sp),
                                          spaceX(5.sp),
                                          coloredText(
                                              text: 'edit'.tr,
                                              fontSize: 12.0.sp),
                                        ],
                                      ),
                                      onTap: () {
                                        CertificateModel certificate =
                                            CertificateModel.fromJson(
                                                globalController
                                                    .certificates[index]
                                                    .toJson());
                                        Utils.showDialogBox(
                                          context: context,
                                          actions: [
                                            primaryButton(
                                              onTap: () async {
                                                Get.back();
                                                bool b =
                                                    await dropdownsController
                                                        .updateCertificate(
                                                            certificateModel:
                                                                certificate);
                                                // ignore: use_build_context_synchronously
                                                if (b)
                                                  Utils.doneDialog(
                                                      context: context);
                                              },
                                              color: Colors.black,
                                              width: 50.w,
                                              height: 40.sp,
                                              text: coloredText(
                                                  text: "create".tr,
                                                  color: Colors.white),
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              coloredText(text: "name_ar".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      certificate.nameAr,
                                                  onChanged: (value) {
                                                    certificate.nameAr = value;
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
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue:
                                                      certificate.nameEn,
                                                  onChanged: (value) {
                                                    certificate.nameEn = value;
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

                                        //  Utils.doneDialog(context: context);
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
                                        bool b = await dropdownsController
                                            .deleteCertificate(
                                          certificateModel: globalController
                                              .certificates[index],
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
                        itemCount: globalController.certificates.length),
              )
            ],
          );
        });
      });
}
