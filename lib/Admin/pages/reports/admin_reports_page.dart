import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/account%20statment/admin_account_statment_page.dart';
import 'package:khedma/Admin/pages/company%20profiles/admin_company_details.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/me.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({super.key});

  @override
  State<AdminReportsPage> createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> {
  GlobalController _globalController = Get.find();
  AdminController _adminController = Get.find();
  @override
  void initState() {
    _globalController.getreports();
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
                    text: "reports".tr,
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
                    // spaceY(10.sp),
                    // SearchTextField(
                    //   onchanged: (s) {
                    //     if (s != null)
                    //       _adminController.handlereportSearch(name: s);
                    //   },
                    //   hintText: "${"search".tr} ...",
                    //   prefixIcon: const Icon(
                    //     EvaIcons.search,
                    //     color: Color(0xffAFAFAF),
                    //   ),
                    //   suffixIcon: GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => reportFilterPage());
                    //     },
                    //     child: const Image(
                    //       width: 15,
                    //       height: 15,
                    //       image: AssetImage("assets/images/filter-icon.png"),
                    //     ),
                    //   ),
                    // ),
                    // spaceY(10.sp),
                    GetBuilder<GlobalController>(builder: (c) {
                      return Expanded(
                        child: c.getreportsFlag
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : c.reports.isEmpty
                                ? NoItemsWidget()
                                : ListView.separated(
                                    itemBuilder: (context, index) => Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF8F8F8),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                children: [
                                                  depositLine(
                                                      width: 20.w,
                                                      title: "report".tr,
                                                      content: c
                                                          .reports[index].docs!)
                                                ],
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: 10,
                                              end: 5,
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
                                                      value: 1,
                                                      child: Row(
                                                        children: [
                                                          coloredText(
                                                              text: 'delete'.tr,
                                                              fontSize:
                                                                  12.0.sp),
                                                        ],
                                                      ),
                                                      onTap: () async {
                                                        bool b =
                                                            await _globalController
                                                                .deleteReport(
                                                                    id: c
                                                                        .reports[
                                                                            index]
                                                                        .id!);
                                                        if (b) {
                                                          Utils.doneDialog(
                                                              context: context);
                                                        }
                                                      },
                                                    ),
                                                    PopupMenuItem<int>(
                                                      value: 0,
                                                      child: coloredText(
                                                          text: 'open'.tr,
                                                          fontSize: 12.0.sp),
                                                      onTap: () async {
                                                        Me? companyProfile =
                                                            await _adminController
                                                                .showAdminCompany(
                                                                    id: c
                                                                        .reports[
                                                                            index]
                                                                        .typeId!,
                                                                    indicator:
                                                                        true);
                                                        if (companyProfile !=
                                                            null) {
                                                          Get.to(() =>
                                                              AdminCompanyDetailsPage(
                                                                companyProfile:
                                                                    companyProfile,
                                                              ));
                                                        }
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
                                        spaceY(10.sp),
                                    itemCount: c.reports.length),
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
