import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/HomePage/employees/models/employees_filter.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/models/company_service_model.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

class CompanyServicesPage extends StatefulWidget {
  const CompanyServicesPage({super.key});

  @override
  State<CompanyServicesPage> createState() => _CompanyServicesPageState();
}

class _CompanyServicesPageState extends State<CompanyServicesPage> {
  final EmployeesController _employeesController = Get.find();
  final CompaniesController _companiesController = Get.find();
  final GlobalController _globalController = Get.find();
  int genderGroupValue = 0;
  String nationality = "";
  String status = "";
  List<String> jobs = [];
  List<String> selectedJobs = [];
  @override
  void initState() {
    _employeesController.employeesFilter = EmployeesFilter();
    _employeesController.employeesFilter.maritalStatus = 1;
    _employeesController.employeesFilter.maritalStatus = 1;
    _companiesController.geCompanyPrice(companyId: _globalController.me.id!);
    _globalController.getCompanyServices();
    jobs = _globalController.jobs
        .map((e) =>
            Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: coloredText(
            text: "services".tr,
            fontSize: 14.0.sp,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          scrolledUnderElevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      int price = 0;
                      int serviceId = 0;
                      Utils.showDialogBox(
                          context: context,
                          actions: [
                            primaryButton(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                bool b = await _globalController
                                    .createCompanyService(
                                        id: serviceId, price: price);
                                if (b)
                                  Utils.doneDialog(
                                      context: context, backTimes: 2);
                              },
                              width: 40.0.w,
                              height: 50,
                              radius: 10.w,
                              color: Colors.black,
                              text: coloredText(
                                text: "submit".tr,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              coloredText(text: "choose_service".tr),
                              spaceY(5.sp),
                              GetBuilder<CompanyTypesController>(builder: (c) {
                                return CustomDropDownMenuButtonV2(
                                  hintPadding: 0,
                                  focusNode: FocusNode(),
                                  fillColor: const Color(0xffF8F8F8),
                                  filled: true,
                                  width: 100.w,
                                  items: _globalController.cleanDropdownServices
                                      .where((element) =>
                                          element.companyTypeID ==
                                          c.companyTypes
                                              .where((element) =>
                                                  element.uniqueName ==
                                                  _globalController
                                                      .me
                                                      .companyInformation!
                                                      .companyType!
                                                      .toLowerCase())
                                              .first
                                              .id)
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          value: Get.locale ==
                                                  const Locale('en', 'US')
                                              ? e.nameEn!
                                              : e.nameAr!,
                                          child: coloredText(
                                              text: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                              color: Colors.black),
                                        ),
                                      )
                                      .toList(),
                                  border: null,
                                  onChanged: (p0) {
                                    serviceId = _globalController.categories
                                        .where((element) =>
                                            element.nameAr == p0 ||
                                            element.nameEn == p0)
                                        .first
                                        .id!;
                                  },
                                  borderRadius: 10,
                                );
                              }),
                              coloredText(text: "price".tr),
                              spaceY(5.sp),
                              SendMessageTextField(
                                suffixIcon: Utils.kwdSuffix("kwd".tr),
                                borderRadius: 5,
                                keyBoardType: TextInputType.number,
                                focusNode: FocusNode(),
                                onchanged: (s) {
                                  if (s != null && s != "")
                                    price = int.parse(s);
                                },
                              )
                            ],
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          EvaIcons.gridOutline,
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
                  GestureDetector(
                    onTap: () {
                      int price = 0;
                      Utils.showDialogBox(
                          context: context,
                          actions: [
                            primaryButton(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                bool b = await _companiesController
                                    .updateCompanyPrice(
                                        price: price,
                                        companyId: _globalController.me.id!);
                                if (b)
                                  Utils.doneDialog(
                                      context: context, backTimes: 2);
                              },
                              width: 40.0.w,
                              height: 50,
                              radius: 10.w,
                              color: Colors.black,
                              text: coloredText(
                                text: "submit".tr,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              coloredText(text: "price".tr),
                              spaceY(5.sp),
                              SendMessageTextField(
                                borderRadius: 5,
                                initialValue: _companiesController.companyPrice,
                                keyBoardType: TextInputType.number,
                                suffixIcon: Utils.kwdSuffix("kwd".tr),
                                focusNode: FocusNode(),
                                onchanged: (s) {
                                  if (s != null && s != "")
                                    price = int.parse(s);
                                },
                              )
                            ],
                          ));
                    },
                    child: coloredText(
                      text: "cleaning_price".tr,
                      fontSize: 13.0.sp,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<GlobalController>(builder: (c) {
              return Expanded(
                child: c.getCompanyServicesFlag
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : c.companyServices.isEmpty
                        ? NoItemsWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) =>
                                CompanyServicesWidget2(
                                  price: _globalController
                                      .companyServices[index].price!,
                                  service:
                                      _globalController.companyServices[index],
                                ),
                            separatorBuilder: (context, index) => spaceY(20.sp),
                            itemCount:
                                _globalController.companyServices.length),
              );
            }),
          ],
        ));
  }
}

class CompanyServicesWidget2 extends StatefulWidget {
  const CompanyServicesWidget2({
    super.key,
    required this.service,
    required this.price,
  });

  final CompanyServiceModel service;
  final String price;

  @override
  State<CompanyServicesWidget2> createState() => _CompanyServicesWidget2State();
}

class _CompanyServicesWidget2State extends State<CompanyServicesWidget2> {
  int val = 0;
  final GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 35.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(widget.service.adminService!.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          spaceX(10.sp),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(
                  text: Get.locale == const Locale("en", "US")
                      ? widget.service.adminService!.nameEn!
                      : widget.service.adminService!.nameAr!),
              spaceY(5.sp),
              coloredText(
                  text: "${"price".tr}: ${widget.price} ${'kwd'.tr}",
                  color: Colors.grey),
              spaceY(5.sp),
              primaryButton(
                  onTap: () async {
                    bool b = await _globalController.deleteCompanyService(
                        id: widget.service.id!);
                    if (b) Utils.doneDialog(context: context);
                  },
                  alignment: AlignmentDirectional.centerStart,
                  width: 35.w,
                  height: 30.sp,
                  text: coloredText(
                    text: "delete".tr,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).colorScheme.primary)
            ],
          ))
        ],
      ),
    );
  }
}
