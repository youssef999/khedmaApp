import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/models/company_type.dart';
import 'package:khedma/Admin/pages/account%20statment/admin_account_statment_page.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

class AdminCompanyTypesPage extends StatefulWidget {
  const AdminCompanyTypesPage({super.key});

  @override
  State<AdminCompanyTypesPage> createState() => _AdminCompanyTypesPageState();
}

class _AdminCompanyTypesPageState extends State<AdminCompanyTypesPage> {
  CompanyTypesController _companyTypesController = Get.find();
  @override
  void initState() {
    _companyTypesController.getCompanyTypes();
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
                    text: "company_types".tr,
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
                    // SearchTextField(
                    //   onchanged: (s) {
                    //     // if (s != null)
                    //       // _adminController.handleAccountStatmentSearch(name: s);
                    //   },
                    //   hintText: "${"search".tr} ...",
                    //   prefixIcon: const Icon(
                    //     EvaIcons.search,
                    //     color: Color(0xffAFAFAF),
                    //   ),
                    //   suffixIcon: GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => AccountStatmentFilterPage());
                    //     },
                    //     child: const Image(
                    //       width: 15,
                    //       height: 15,
                    //       image: AssetImage("assets/images/filter-icon.png"),
                    //     ),
                    //   ),
                    // ),
                    // spaceY(10.sp),
                    GetBuilder<CompanyTypesController>(builder: (c) {
                      return Expanded(
                        child: c.getCompanyTypesFlag
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : c.companyTypes.isEmpty
                                ? NoItemsWidget()
                                : ListView.separated(
                                    itemBuilder: (context, index) => Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  depositLine(
                                                      width: 40.w,
                                                      title: "name_en".tr,
                                                      content: c
                                                          .companyTypes[index]
                                                          .nameEn!),
                                                  spaceY(10.sp),
                                                  depositLine(
                                                      width: 40.w,
                                                      title: "name_ar".tr,
                                                      content: c
                                                          .companyTypes[index]
                                                          .nameAr!),
                                                  spaceY(10.sp),
                                                  depositLine(
                                                      width: 40.w,
                                                      title: "unique_name".tr,
                                                      content: c
                                                          .companyTypes[index]
                                                          .uniqueName!),
                                                  spaceY(10.sp),
                                                  c.companyTypes[index]
                                                              .isParent ==
                                                          1
                                                      ? Container()
                                                      : depositLine(
                                                          width: 40.w,
                                                          title: "parent".tr,
                                                          content: c
                                                              .companyTypes[
                                                                  index]
                                                              .companyTypeId
                                                              .toString()),
                                                ],
                                              ),
                                            ),
                                            PositionedDirectional(
                                              end: 10,
                                              top: 10,
                                              child: Theme(
                                                data: ThemeData(
                                                    primaryColor: Colors.white),
                                                child: PopupMenuButton(
                                                  constraints: BoxConstraints(
                                                    minWidth: 2.0 * 56.0,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext cc) => [
                                                    PopupMenuItem<int>(
                                                      value: 0,
                                                      child: Row(
                                                        children: [
                                                          Icon(EvaIcons.edit,
                                                              size: 15.sp),
                                                          spaceX(5.sp),
                                                          coloredText(
                                                              text: "edit".tr,
                                                              fontSize:
                                                                  12.0.sp),
                                                        ],
                                                      ),
                                                      onTap: () async {
                                                        CompanyType
                                                            companyType =
                                                            CompanyType.fromJson(
                                                                c.companyTypes[
                                                                        index]
                                                                    .toJson());
                                                        Utils.showDialogBox(
                                                          context: context,
                                                          actions: [
                                                            primaryButton(
                                                              onTap: () async {
                                                                Get.back();
                                                                bool b = await c
                                                                    .updateCompanyType(
                                                                        companyType:
                                                                            companyType);
                                                                if (b)
                                                                  Utils.doneDialog(
                                                                      context:
                                                                          context);
                                                              },
                                                              color:
                                                                  Colors.black,
                                                              width: 50.w,
                                                              height: 40.sp,
                                                              text: coloredText(
                                                                  text:
                                                                      "edit".tr,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              coloredText(
                                                                  text:
                                                                      "name_ar"
                                                                          .tr),
                                                              spaceY(5.sp),
                                                              SizedBox(
                                                                height: 35.sp,
                                                                child:
                                                                    TextFormField(
                                                                  // maxLines: 1,
                                                                  initialValue:
                                                                      companyType
                                                                          .nameAr,
                                                                  onChanged:
                                                                      (value) {
                                                                    companyType
                                                                            .nameAr =
                                                                        value;
                                                                  },
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    // hintText: "write_your_notes".tr,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10),
                                                                      ),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Color(
                                                                            0xffF5F5F5),
                                                                  ),
                                                                ),
                                                              ),
                                                              spaceY(10.sp),
                                                              coloredText(
                                                                  text:
                                                                      "name_en"
                                                                          .tr),
                                                              spaceY(5.sp),
                                                              SizedBox(
                                                                height: 35.sp,
                                                                child:
                                                                    TextFormField(
                                                                  // maxLines: 1,
                                                                  initialValue:
                                                                      companyType
                                                                          .nameEn,
                                                                  onChanged:
                                                                      (value) {
                                                                    companyType
                                                                            .nameEn =
                                                                        value;
                                                                  },
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    // hintText: "write_your_notes".tr,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10),
                                                                      ),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Color(
                                                                            0xffF5F5F5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () =>
                                                                    Get.back(),
                                                                child:
                                                                    const Icon(
                                                                  EvaIcons
                                                                      .close,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                  child: const Icon(
                                                    EvaIcons.moreVertical,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        spaceY(15.sp),
                                    itemCount: c.companyTypes.length),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
