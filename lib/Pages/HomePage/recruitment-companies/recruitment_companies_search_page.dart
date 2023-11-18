// ignore_for_file: must_be_immutable

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Pages/HomePage/cleaning%20companies/cleaning_company.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/Pages/HomePage/recruitment-companies/recruitment_company.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class RecruitmentCompaniesSearchPage extends StatefulWidget {
  const RecruitmentCompaniesSearchPage({super.key});

  @override
  State<RecruitmentCompaniesSearchPage> createState() =>
      _RecruitmentCompaniesPageSSearchtate();
}

class _RecruitmentCompaniesPageSSearchtate
    extends State<RecruitmentCompaniesSearchPage> {
  final CompaniesController _companiesController = Get.find();
  final GlobalController _globalController = Get.find();

  @override
  void initState() {
    _companiesController.getRecruitmentCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: coloredText(text: "rec_com".tr, fontSize: 15.0.sp),
      ),
      body: GetBuilder<CompaniesController>(builder: (c) {
        return Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Column(
            children: [
              SearchTextField(
                hintText: "${"search".tr} ...",
                onchanged: (s) {
                  _companiesController.handleRecruitmentCompaniesSearch(
                      name: s!);
                },
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
              ),
              spaceY(2.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropDownMenuButton(
                    width: 50.0.w,
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
                      _companiesController.filterRecruitmentCompaniesByCity(
                          city: p0!);
                    },
                    hint: "city".tr,
                    borderc: Border.all(color: const Color(0xffE3E3E3)),
                    borderRadius: BorderRadius.circular(8),
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  ),
                ],
              ),
              // ChipsChoice<String>.multiple(
              //   scrollphysics: const NeverScrollableScrollPhysics(),
              //   padding: EdgeInsets.zero,
              //   value: tags,
              //   onChanged: (val) {},
              //   choiceItems: C2Choice.listFrom<String, String>(
              //     source: options,
              //     value: (i, v) => v,
              //     label: (i, v) => v,
              //   ),
              //   // choiceStyle: C2ChipStyle.outlined(),
              //   choiceCheckmark: true,

              //   choiceBuilder: (item, i) => GestureDetector(
              //     onTap: () {
              //       if (!tags.contains(item.label)) {
              //         tags = [];
              //         tags.add(item.label);
              //       }
              //       setState(() {});
              //     },
              //     child: Container(
              //       width: 28.0.w,
              //       height: 40,
              //       margin: EdgeInsets.symmetric(horizontal: 1.0.w),
              //       decoration: BoxDecoration(
              //           color: !tags.contains(item.label)
              //               ? const Color(0xffE8E8E8).withOpacity(0)
              //               : Theme.of(context)
              //                   .colorScheme
              //                   .secondary
              //                   .withOpacity(0.06),
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(
              //             color: !tags.contains(item.label)
              //                 ? const Color(0xffE8E8E8)
              //                 : Theme.of(context).colorScheme.secondary,
              //           )),
              //       child: Center(
              //         child: coloredText(
              //             text: item.label.tr,
              //             color: !tags.contains(item.label)
              //                 ? const Color(0xff919191)
              //                 : Theme.of(context).colorScheme.secondary,
              //             fontSize: 12.0.sp),
              //       ),
              //     ),
              //   ),
              // ),
              spaceY(2.0.h),
              Expanded(
                child: c.getRecruitmentCompaniesFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : c.recruitmentCompaniesToShow.isEmpty
                        ? const NoItemsWidget()
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            itemBuilder: (context, index) => CompanyCard(
                                company: c.recruitmentCompaniesToShow[index]),
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
                            itemCount: c.recruitmentCompaniesToShow.length,
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class CompanyCard extends StatelessWidget {
  CompanyCard({
    super.key,
    required this.company,
    this.deleteFlag = false,
    this.deleteId = 0,
  });
  final CompaniesController _companiesController = Get.find();
  final GlobalController _globalController = Get.find();
  final CompanyTypesController _companyTypesController = Get.find();
  final CompanyModel company;
  bool deleteFlag = false;
  int deleteId = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            if (company.companyInformation!.busy != null &&
                company.companyInformation!.busy == 1) {
            } else {
              CompanyModel? x = await _companiesController.showCompany(
                  indicator: true, id: company.id!);

              if (x != null) {
                if (x.companyInformation != null) {
                  if (x.companyInformation!.companyType == "cleaning") {
                    Get.to(
                      () => CleaningCompany(cleaningCompany: x),
                    );
                  } else {
                    Get.to(
                      () => RecruitmentCompany(company: x),
                    );
                  }
                }
              }
            }
          },
          child: Stack(
            children: [
              Container(
                width: 50.0.sp,
                height: 50.0.sp,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffEEEEEE)),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:
                        NetworkImage(company.companyInformation!.companyLogo!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              if (company.companyInformation!.busy == 1)
                Container(
                  width: 50.0.sp,
                  height: 50.0.sp,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(15 / 360),
                      child: coloredText(
                        text: "busy",
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        spaceX(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  coloredText(
                    text: company.fullName!,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (deleteFlag) {
                        await _globalController.deleteFavourite(
                          detect: 1,
                          id: deleteId,
                        );
                      } else if (company.favouriteCompany != null &&
                          company.favouriteCompany!.userId ==
                              _globalController.me.id &&
                          company.favouriteCompany!.type == 1) {
                        await _globalController.deleteFavourite(
                          detect: 1,
                          id: company.favouriteCompany!.id!,
                        );
                      } else {
                        await _globalController.storeFavourite(
                            typeId: company.id!, type: 1);
                      }
                    },
                    child: Icon(
                      EvaIcons.heart,
                      color: deleteFlag
                          ? Colors.red
                          : company.favouriteCompany != null &&
                                  company.favouriteCompany!.userId ==
                                      _globalController.me.id &&
                                  company.favouriteCompany!.type == 1
                              ? Colors.red
                              : const Color(0xffD4D4D4),
                    ),
                  )
                ],
              ),
              spaceY(10),
              coloredText(
                  text: _companyTypesController.companyTypes
                      .where((element) =>
                          element.uniqueName ==
                          company.companyInformation!.companyType!)
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .first,
                  fontSize: 11.0.sp,
                  color: Colors.grey),
              spaceY(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    EvaIcons.pin,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 15.0.sp,
                  ),
                  spaceX(3),
                  coloredText(
                    text: Get.locale == const Locale('en', 'US')
                        ? _globalController.cities
                            .where((element) =>
                                element.id ==
                                company.companyInformation!.cityId)
                            .first
                            .nameEn!
                        : _globalController.cities
                            .where((element) =>
                                element.id ==
                                company.companyInformation!.cityId)
                            .first
                            .nameAr!,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13.0.sp,
                  ),
                ],
              ),
              spaceY(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(EvaIcons.star, color: Colors.yellow),
                  spaceX(5),
                  coloredText(
                    text: (company.reviewCompanySumReviewValue ?? 0).toString(),
                    fontSize: 13.0.sp,
                    color: Colors.black,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
