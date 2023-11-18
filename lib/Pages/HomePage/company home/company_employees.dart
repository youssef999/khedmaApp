// ignore_for_file: must_be_immutable

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/add_employee_page.dart';
import 'package:khedma/Pages/HomePage/company%20home/company_employees_filter.dart';
import 'package:khedma/Pages/HomePage/company%20home/emloyee_details.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/company_employee_card.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

class CompanyEmployeesSearchPage extends StatefulWidget {
  const CompanyEmployeesSearchPage({super.key, this.filterStatus});
  final String? filterStatus;
  @override
  State<CompanyEmployeesSearchPage> createState() =>
      _CompanyEmployeesSearchPageState();
}

class _CompanyEmployeesSearchPageState
    extends State<CompanyEmployeesSearchPage> {
  EmployeesController _employeesController = Get.find();
  @override
  void initState() {
    _employeesController.getCompanyEmployees().then((value) {
      if (widget.filterStatus != null) {
        _employeesController.employeesFilter.status = widget.filterStatus;
        _employeesController.applyCompanyFilter();
      }
    });

    super.initState();
  }

  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: GestureDetector(
              onTap: () {
                Utils.takeContainer(controller, "employees.png");
              },
              child: coloredText(text: "employees".tr, fontSize: 15.0.sp)),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Column(
            children: [
              SearchTextField(
                hintText: "${"search".tr} ...",
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
                onchanged: (s) {
                  if (s != null) {
                    _employeesController.handleCompanyEmployeesSearch(name: s);
                  }
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.to(() => CompanyEmployeesFilterPage());
                  },
                  child: const Image(
                    width: 15,
                    height: 15,
                    image: AssetImage("assets/images/filter-icon.png"),
                  ),
                ),
              ),
              spaceY(2.0.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AddEmployeePage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      EvaIcons.personAddOutline,
                    ),
                    spaceX(10),
                    coloredText(
                      text: "create_new".tr,
                      fontSize: 13.0.sp,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              spaceY(2.0.h),
              Expanded(
                child: GetBuilder<EmployeesController>(builder: (c) {
                  return c.getCompanyEmployeesFlag
                      ? const Center(child: CircularProgressIndicator())
                      : c.companyEmployeeToShow.isEmpty
                          ? const NoItemsWidget()
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              primary: false,
                              itemBuilder: (context, index) =>
                                  CompanyEmployeeCard(
                                trailing: Theme(
                                  data: ThemeData(primaryColor: Colors.white),
                                  child: PopupMenuButton(
                                    constraints: BoxConstraints(
                                      minWidth: 2.0 * 56.0,
                                      maxWidth:
                                          MediaQuery.of(context).size.width,
                                    ),
                                    itemBuilder: (BuildContext ctx) => [
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: coloredText(
                                            text: 'more_details'.tr,
                                            fontSize: 11.0.sp),
                                        onTap: () async {
                                          EmployeeModel? em =
                                              await _employeesController
                                                  .showCompanyEmployee(
                                                      id: c
                                                          .companyEmployeeToShow[
                                                              index]
                                                          .id!,
                                                      indicator: true);
                                          if (em != null) {
                                            Get.to(() => EmployeeDetailsPage(
                                                  employee: em,
                                                ));
                                          }
                                        },
                                      ),
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: coloredText(
                                            text: 'edit'.tr, fontSize: 11.0.sp),
                                        onTap: c.companyEmployeeToShow[index]
                                                    .status !=
                                                null
                                            ? () {
                                                Utils.showToast(
                                                    message:
                                                        "can't_delete_employee"
                                                            .tr);
                                              }
                                            : () async {
                                                EmployeeModel? em =
                                                    await _employeesController
                                                        .showCompanyEmployee(
                                                            id: c
                                                                .companyEmployeeToShow[
                                                                    index]
                                                                .id!,
                                                            indicator: true);
                                                if (em != null) {
                                                  Get.to(() => AddEmployeePage(
                                                        employeeToEdit: em,
                                                      ));
                                                }
                                              },
                                      ),
                                      PopupMenuItem<int>(
                                        value: 2,
                                        onTap: c.companyEmployeeToShow[index]
                                                    .status !=
                                                null
                                            ? () {
                                                Utils.showToast(
                                                    message:
                                                        "can't_edit_employee"
                                                            .tr);
                                              }
                                            : () async {
                                                bool x = await _employeesController
                                                    .deleteEmployee(
                                                        employee:
                                                            c.companyEmployeeToShow[
                                                                index]);
                                                if (x) {
                                                  // ignore: use_build_context_synchronously
                                                  Utils.doneDialog(
                                                      context: context);
                                                }
                                              },
                                        child: coloredText(
                                            text: 'delete'.tr,
                                            fontSize: 12.0.sp),
                                      ),
                                    ],
                                    child: const Icon(
                                      EvaIcons.moreVertical,
                                    ),
                                  ),
                                ),
                                employee: _employeesController
                                    .companyEmployeeToShow[index],
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
                              itemCount: c.companyEmployeeToShow.length,
                            );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
