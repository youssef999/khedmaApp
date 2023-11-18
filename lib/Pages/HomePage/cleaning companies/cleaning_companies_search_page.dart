// ignore_for_file: must_be_immutable, unused_field

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/recruitment-companies/recruitment_companies_search_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class CleaningCompaniesSearchPage extends StatefulWidget {
  const CleaningCompaniesSearchPage({super.key});

  @override
  State<CleaningCompaniesSearchPage> createState() =>
      _RecruitmentCompaniesPageSSearchtate();
}

class _RecruitmentCompaniesPageSSearchtate
    extends State<CleaningCompaniesSearchPage> {
  final CompaniesController _companiesController = Get.find();
  final GlobalController _globalController = Get.find();
  final CompanyTypesController _companyTypesController = Get.find();

  @override
  void initState() {
    _companiesController.getCleaningCompanies();
    super.initState();
  }

  String search = "";
  String city = "";
  String companyType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "cl_com".tr, fontSize: 15.0.sp),
      ),
      body: GetBuilder<CompaniesController>(builder: (c) {
        return Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Column(
            children: [
              SearchTextField(
                onchanged: (s) {
                  c.handleCleanCompaniesSearch(
                    name: s!,
                    city: city,
                    companyType: companyType,
                  );
                  search = s;
                },
                hintText: "${"search".tr} ...",
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
              ),
              spaceY(2.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CustomDropDownMenuButton(
                  //   width: 40.0.w,
                  //   items: ["item", "item2"]
                  //       .map(
                  //         (e) => DropdownMenuItem<String>(
                  //           value: e,
                  //           child: coloredText(text: e, color: Colors.black),
                  //         ),
                  //       )
                  //       .toList(),
                  //   onChanged: (p0) {},
                  //   hint: "country".tr,
                  //   borderc: Border.all(color: const Color(0xffE3E3E3)),
                  //   borderRadius: BorderRadius.circular(8),
                  //   padding:
                  //       const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  // ),

                  CustomDropDownMenuButton(
                    width: 42.0.w,
                    items: _globalController.cities
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: Get.locale == const Locale('en', 'US')
                                ? e.nameEn!
                                : e.nameAr!,
                            child: coloredText(
                                text: Get.locale == const Locale('en', 'US')
                                    ? e.nameEn!
                                    : e.nameAr!,
                                color: Colors.black),
                          ),
                        )
                        .toList(),
                    onChanged: (p0) {
                      city = p0!;
                      c.handleCleanCompaniesSearch(
                        name: search,
                        city: city,
                        companyType: companyType,
                      );
                    },
                    hint: "city".tr,
                    borderc: Border.all(color: const Color(0xffE3E3E3)),
                    borderRadius: BorderRadius.circular(8),
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  ),
                  CustomDropDownMenuButton(
                    width: 42.0.w,
                    items: _companyTypesController.companyTypes
                        .where((element) => element.uniqueName != "recruitment")
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e.uniqueName,
                            child: coloredText(
                                text: Get.locale == const Locale('en', 'US')
                                    ? e.nameEn!
                                    : e.nameAr!,
                                color: Colors.black),
                          ),
                        )
                        .toList(),
                    onChanged: (p0) {
                      companyType = p0!;
                      c.handleCleanCompaniesSearch(
                        name: search,
                        city: city,
                        companyType: companyType,
                      );
                    },
                    hint: "type".tr,
                    borderc: Border.all(color: const Color(0xffE3E3E3)),
                    borderRadius: BorderRadius.circular(8),
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  ),
                ],
              ),
              spaceY(2.0.h),
              Expanded(
                child: c.getCleanCompaniesFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : c.cleanCompaniesToShow.isEmpty
                        ? const NoItemsWidget()
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            itemBuilder: (context, index) => CompanyCard(
                              company: c.cleanCompaniesToShow[index],
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
                            itemCount: c.cleanCompaniesToShow.length,
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}
