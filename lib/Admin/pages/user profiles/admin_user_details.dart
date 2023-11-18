import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Pages/HomePage/company%20home/emloyee_details.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/me.dart';
import 'package:khedma/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class AdminUserDetailsPage extends StatefulWidget {
  AdminUserDetailsPage({super.key, required this.userProfile});
  final Me userProfile;

  @override
  State<AdminUserDetailsPage> createState() => _AdminUserDetailsPageState();
}

class _AdminUserDetailsPageState extends State<AdminUserDetailsPage> {
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: true);

  final ExpandableController _expandable2Controller =
      ExpandableController(initialExpanded: false);

  final ExpandableController _expandable3Controller =
      ExpandableController(initialExpanded: false);

  final AdminController _adminController = Get.find();
  final GlobalController _globalController = Get.find();
  int blocked = 0;
  @override
  void initState() {
    blocked = widget.userProfile.block!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZeroAppBar(
        color: Colors.white,
      ),
      body: ExpandableNotifier(
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.black,
            useInkWell: false,
          ),
          child: ListView(
            primary: false,
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        size: 25.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        bool b = await _adminController.blockProfile(
                          id: widget.userProfile.id!,
                          block: blocked == 0 ? 1 : 0,
                          userIndicator: 'user',
                        );
                        if (b) {
                          if (blocked == 0) {
                            blocked = 1;
                          } else {
                            blocked = 0;
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 30.sp,
                        height: 30.sp,
                        decoration: BoxDecoration(
                            color: blocked == 1
                                ? Colors.red.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          EvaIcons.slash,
                          color: blocked == 1 ? Colors.red : Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              spaceY(10.sp),
              Container(
                width: 100.0.sp,
                height: 100.0.sp,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.userProfile.userInformation!.personalPhoto),
                      fit: BoxFit.contain),
                ),
              ),
              spaceY(20.sp),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffEFEFEF)),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    controller: _expandableController,
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(10),
                      child: coloredText(
                        text: "personal_info".tr,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsItemWidget(
                            title1: "name".tr,
                            subTitle1: widget.userProfile.fullName,
                            width1: 80.w,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "email".tr,
                            subTitle1: widget.userProfile.email,
                            width1: 80.w,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "phone_number".tr,
                            subTitle1:
                                widget.userProfile.userInformation!.phone,
                            width1: 80.w,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "nationality".tr,
                            subTitle1: _globalController.countries
                                .where((element) =>
                                    element.id ==
                                    widget.userProfile.userInformation!
                                        .nationalityId)
                                .map((e) =>
                                    Get.locale == const Locale("en", "US")
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                            width1: 80.w,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "job".tr,
                            subTitle1:
                                widget.userProfile.userInformation!.jobName,
                            width1: 80.w,
                          ),
                          spaceY(12.sp),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              spaceY(10.sp),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffEFEFEF)),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    controller: _expandable2Controller,
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(10),
                      child: coloredText(
                        text: "address_info".tr,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsItemWidget(
                            title1: "city".tr,
                            subTitle1: _globalController.cities
                                .where((element) =>
                                    element.id ==
                                    widget.userProfile.userInformation!.cityId)
                                .map((e) =>
                                    Get.locale == const Locale("en", "US")
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                            // title2: "region".tr,
                            // subTitle2: _globalController.regions
                            //     .where((element) =>
                            //         element.id ==
                            //         widget
                            //             .userProfile.userInformation!.regionId)
                            //     .map((e) =>
                            //         Get.locale == const Locale("en", "US")
                            //             ? e.nameEn!
                            //             : e.nameAr!)
                            //     .first,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "piece_num".tr,
                            subTitle1:
                                widget.userProfile.userInformation!.pieceNumber,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "street".tr,
                            subTitle1:
                                widget.userProfile.userInformation!.street,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "building".tr,
                            subTitle1:
                                widget.userProfile.userInformation!.building,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "adn".tr,
                            subTitle1: widget.userProfile.userInformation!
                                .automatedAddressNumber,
                          ),
                          spaceY(12.sp),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              spaceY(10.sp),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffEFEFEF)),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    controller: _expandable3Controller,
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(10),
                      child: coloredText(
                        text: "id_proof".tr,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "id_number".tr,
                            subTitle1: widget.userProfile.userInformation!
                                .idNumberNationality,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "ref_number".tr,
                            subTitle1: widget.userProfile.userInformation!
                                    .referenceNumber ??
                                "No Refrence Number",
                          ),
                          spaceY(12.sp),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              coloredText(
                                  text: "id_photo".tr,
                                  color: Colors.black,
                                  fontSize: 13.sp),
                              spaceY(5.sp),
                              Image(
                                image: NetworkImage(widget.userProfile
                                    .userInformation!.idPhotoNationality!),
                                width: 50.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              spaceY(10.sp),
            ],
          ),
        ),
      ),
    );
  }
}
