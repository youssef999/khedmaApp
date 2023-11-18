// ignore_for_file: must_be_immutable

import 'package:chips_choice/chips_choice.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/HomePage/employees/employees_filter_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:khedma/widgets/user_profile_card.dart';
import 'package:sizer/sizer.dart';

class EmployeesSearchPage extends StatefulWidget {
  const EmployeesSearchPage({super.key});

  @override
  State<EmployeesSearchPage> createState() => _EmployeesSearchPageState();
}

class _EmployeesSearchPageState extends State<EmployeesSearchPage> {
  final EmployeesController _employeesController = Get.find();

  @override
  void initState() {
    _employeesController.getEmployees();
    super.initState();
  }

  List<String> tags = [];
  List<String> categories = ["per_hour".tr, "per_year".tr];
  String selectedCategory = "per_hour".tr;
  GlobalController _globalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "employees".tr, fontSize: 15.0.sp),
      ),
      body: GetBuilder<EmployeesController>(builder: (c) {
        return Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Column(
            children: [
              SearchTextField(
                onchanged: (s) {
                  if (s != null) {
                    _employeesController.handleEmployeesSearch(name: s);
                  }
                },
                hintText: "${'search'.tr} ...",
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => const EmployeesFilterPage(),
                    );
                  },
                  child: const Image(
                    width: 15,
                    height: 15,
                    image: AssetImage("assets/images/filter-icon.png"),
                  ),
                ),
              ),
              spaceY(2.0.h),
              // coloredText(
              //   text: "services".tr,
              //   fontSize: 13.0.sp,
              //   fontWeight: FontWeight.w500,
              // ),
              // spaceY(1.5.h),
              SizedBox(
                  height: 85.sp,
                  child: ChipsChoice<String>.multiple(
                    padding: EdgeInsets.zero,
                    value: tags,
                    onChanged: (val) {},
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: _globalController.jobs
                          .map((e) => Get.locale == const Locale('en', 'US')
                              ? e.nameEn!
                              : e.nameAr!)
                          .toList(),
                      value: (i, v) => i.toString(),
                      label: (i, v) => v,
                      avatarImage: (index, item) =>
                          NetworkImage(_globalController.jobs[index].icon),
                    ),
                    // choiceStyle: C2ChipStyle.outlined(),
                    choiceCheckmark: true,

                    choiceBuilder: (item, i) => GestureDetector(
                      onTap: () {
                        if (tags.contains(item.label)) {
                          tags.remove(item.label);
                        } else {
                          tags.add(item.label);
                        }
                        _employeesController.filterEmployeesByJobs(jobs: tags);
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(end: 15),
                        child: Column(
                          children: [
                            Container(
                              width: 60.0.sp,
                              height: 60.0.sp,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: !tags.contains(item.label)
                                        ? Colors.red.withOpacity(0)
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                  )),
                              child: Center(
                                child: Image(
                                  width: 35.0.sp,
                                  height: 35.0.sp,
                                  image: item.avatarImage!,
                                ),
                              ),
                            ),
                            spaceY(5),
                            coloredText(
                                text: item.label.tr,
                                color: Colors.black,
                                fontSize: 12.0.sp),
                          ],
                        ),
                      ),
                    ),
                  )),
              spaceY(10.0.sp),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     coloredText(
              //       text: "categories".tr,
              //       fontSize: 13.0.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     Theme(
              //       data: ThemeData(primaryColor: Colors.white),
              //       child: PopupMenuButton(
              //         itemBuilder: (BuildContext context) => [
              //           PopupMenuItem<int>(
              //             value: 0,
              //             child: coloredText(text: categories[0]),
              //             onTap: () {
              //               selectedCategory = categories[0];
              //               setState(() {});
              //             },
              //           ),
              //           PopupMenuItem<int>(
              //             value: 1,
              //             child: coloredText(text: categories[1]),
              //             onTap: () {
              //               selectedCategory = categories[1];
              //               setState(() {});
              //             },
              //           ),
              //         ],
              //         child: Container(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 15),
              //           width: 35.0.w,
              //           height: 40,
              //           decoration: BoxDecoration(
              //             color: const Color(0xffF8F8F8),
              //             border: Border.all(
              //               color: const Color(0xffE1E1E1),
              //             ),
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //           child: Row(
              //             mainAxisAlignment:
              //                 MainAxisAlignment.spaceEvenly,
              //             children: [
              //               coloredText(
              //                   text: selectedCategory,
              //                   color: Colors.black,
              //                   fontSize: 15),
              //               Padding(
              //                 padding:
              //                     const EdgeInsets.only(bottom: 5),
              //                 child: Icon(
              //                   FontAwesomeIcons.sortDown,
              //                   color: Colors.grey.shade700,
              //                   size: 15,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // spaceY(2.0.h),
              Expanded(
                child: c.getEmployeesFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : c.employeeToShow.isEmpty
                        ? const NoItemsWidget()
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            itemBuilder: (context, index) => UserProfileCard(
                              employeeModel: c.employeeToShow[index],
                              trailing: _globalController.guest
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () async {
                                        if (_employeesController
                                                    .employeeToShow[index]
                                                    .favourite !=
                                                null &&
                                            _employeesController
                                                    .employeeToShow[index]
                                                    .favourite!
                                                    .userId ==
                                                _globalController.me.id &&
                                            _employeesController
                                                    .employeeToShow[index]
                                                    .favourite!
                                                    .type ==
                                                0) {
                                          await _globalController
                                              .deleteFavourite(
                                            detect: 0,
                                            id: _employeesController
                                                .employeeToShow[index]
                                                .favourite!
                                                .id!,
                                          );
                                        } else {
                                          await _globalController
                                              .storeFavourite(
                                                  typeId: _employeesController
                                                      .employeeToShow[index]
                                                      .id!,
                                                  type: 0);
                                        }
                                      },
                                      child: Icon(
                                        EvaIcons.heart,
                                        color: _employeesController
                                                        .employeeToShow[index]
                                                        .favourite !=
                                                    null &&
                                                _employeesController
                                                        .employeeToShow[index]
                                                        .favourite!
                                                        .userId ==
                                                    _globalController.me.id &&
                                                _employeesController
                                                        .employeeToShow[index]
                                                        .favourite!
                                                        .type ==
                                                    0
                                            ? Colors.red
                                            : const Color(0xffD4D4D4),
                                        size: 13.0.sp,
                                      ),
                                    ),
                            ),
                            separatorBuilder: (context, index) => Column(
                              children: [
                                spaceY(1.0.h),
                                const Divider(
                                  color: Color(0xffEBEBEB),
                                  thickness: 1,
                                ),
                                spaceY(1.0.h),
                              ],
                            ),
                            itemCount: c.employeeToShow.length,
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}
