import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/add_employee_page.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class EmployeeDetailsPage extends StatelessWidget {
  EmployeeDetailsPage({super.key, required this.employee});
  final EmployeeModel employee;
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _expandable2Controller =
      ExpandableController(initialExpanded: false);
  final ExpandableController _expandable3Controller =
      ExpandableController(initialExpanded: false);
  final ExpandableController _expandable4Controller =
      ExpandableController(initialExpanded: false);

  final GlobalController _globalController = Get.find();
  final EmployeesController _employeesController = Get.find();
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
                        size: 30.sp,
                      ),
                    ),
                    employee.status != null
                        ? Container()
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  EmployeeModel? em = await _employeesController
                                      .showCompanyEmployee(
                                          id: employee.id!, indicator: true);
                                  if (em != null) {
                                    Get.to(() => AddEmployeePage(
                                          employeeToEdit: em,
                                        ));
                                  }
                                },
                                child: Container(
                                  width: 30.sp,
                                  height: 30.sp,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff919191)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(
                                    EvaIcons.edit,
                                    color: Color(0xff5D5D5D),
                                  ),
                                ),
                              ),
                              spaceX(10),
                              GestureDetector(
                                onTap: () async {
                                  bool x = await _employeesController
                                      .deleteEmployee(employee: employee);
                                  if (x) {
                                    Utils.doneDialog(
                                        context: context, backTimes: 2);
                                  }
                                },
                                child: Container(
                                  width: 30.sp,
                                  height: 30.sp,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff919191)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(
                                    EvaIcons.trash2,
                                    color: Color(0xff5D5D5D),
                                  ),
                                ),
                              ),
                            ],
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
                      image: NetworkImage(employee.image), fit: BoxFit.contain),
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
                            subTitle1: Get.locale == const Locale('en', 'US')
                                ? employee.nameEn!
                                : employee.nameAr!,
                            title2: "no_of_children".tr,
                            subTitle2: employee.numOfChildren.toString(),
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "nationality".tr,
                            subTitle1: _globalController.countries
                                .where((element) =>
                                    element.id == employee.nationalityId)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                            title2: "religion".tr,
                            subTitle2: _globalController.relegions
                                .where((element) =>
                                    element.id == employee.religionId)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "date_of_birth".tr,
                            subTitle1: employee.dateOfBirth,
                            title2: "birth_place".tr,
                            subTitle2: _globalController.countries
                                .where((element) =>
                                    element.id == employee.birthPlace)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "living_town".tr,
                            subTitle1: _globalController.countries
                                .where((element) =>
                                    element.id == employee.livingTown)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                            title2: "marital_status".tr,
                            subTitle2: _globalController.maritalStatusList
                                .where((element) =>
                                    element.id == employee.maritalStatus)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "weight".tr,
                            subTitle1: "${employee.weight} kg",
                            title2: "height".tr,
                            subTitle2: "${employee.hight} cm",
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "complexion".tr,
                            subTitle1: _globalController.complexionList
                                .where((element) =>
                                    element.id == employee.complexionId)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                          ),
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
                        text: "passport_data".tr,
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
                            title1: "passport_number".tr,
                            subTitle1: employee.passportNum,
                            title2: "issue_date".tr,
                            subTitle2: employee.passportIssueDate,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            title1: "issue_place".tr,
                            subTitle1: _globalController.countries
                                .where((element) =>
                                    element.id == employee.passportPlaceOfIssue)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                            title2: "expiry_date".tr,
                            subTitle2: employee.passportExpiryDate,
                          ),
                          spaceY(12.sp),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                coloredText(
                                    text: "passport".tr,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                                spaceY(5.sp),
                                Image(
                                  image: NetworkImage(employee.passportImege!),
                                  width: 50.w,
                                ),
                              ],
                            ),
                          )
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
                        text: "work_info".tr,
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
                            title1: "job".tr,
                            subTitle1: employee.jobs!
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .toList()
                                .join(", "),
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "contract_duration".tr,
                            subTitle1:
                                "${employee.contractDuration} ${"years".tr}",
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "previous_work_abroad".tr,
                            subTitle1: employee.previousWorkAbroad == 1
                                ? "yes".tr
                                : "no".tr,
                          ),
                          employee.previousWorkAbroad == 0
                              ? Container()
                              : spaceY(12.sp),
                          employee.previousWorkAbroad == 0
                              ? Container()
                              : DetailsItemWidget(
                                  width1: 80.w,
                                  title1: "duration_of_employment".tr,
                                  subTitle1:
                                      employee.durationOfEmployment.toString() +
                                          "years".tr,
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
                    controller: _expandable4Controller,
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(10),
                      child: coloredText(
                        text: "other_data".tr,
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
                            title1: "educational_certificates".tr,
                            subTitle1: _globalController.certificates
                                .where((element) =>
                                    element.id ==
                                    employee.educationCertification)
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .first,
                          ),
                          spaceY(12.sp),
                          DetailsItemWidget(
                            width1: 80.w,
                            title1: "knowledge_of_languages".tr,
                            subTitle1: employee.languages!
                                .map((e) =>
                                    Get.locale == const Locale('en', 'US')
                                        ? e.nameEn!
                                        : e.nameAr!)
                                .toList()
                                .join(", "),
                          ),
                          employee.desc == null ? Container() : spaceY(10.sp),
                          employee.desc == null
                              ? Container()
                              : DetailsItemWidget(
                                  width1: 80.w,
                                  title1: "more_details".tr,
                                  subTitle1: employee.desc),
                          spaceY(12.sp),
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

class DetailsItemWidget extends StatelessWidget {
  const DetailsItemWidget(
      {super.key,
      this.title1,
      this.title2,
      this.subTitle1,
      this.subTitle2,
      this.width1});
  final String? title1;
  final String? title2;
  final String? subTitle1;
  final String? subTitle2;
  final double? width1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width1 ?? 55.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(
                  text: title1 ?? "", color: Colors.black, fontSize: 13.sp),
              spaceY(5.sp),
              coloredText(
                text: subTitle1 ?? "",
                color: const Color(0xff919191),
                fontSize: 12.sp,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(
                  text: title2 ?? "", color: Colors.black, fontSize: 13.sp),
              spaceY(5.sp),
              coloredText(
                text: subTitle2 ?? "",
                color: const Color(0xff919191),
                fontSize: 12.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
