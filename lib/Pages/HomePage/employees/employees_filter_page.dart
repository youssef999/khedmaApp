import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/HomePage/employees/models/employees_filter.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/dropdown_menu_button.dart';
import '../../../widgets/radio_button.dart';
import '../../../widgets/search_text_field.dart';

class EmployeesFilterPage extends StatefulWidget {
  const EmployeesFilterPage({super.key});

  @override
  State<EmployeesFilterPage> createState() => _EmployeesFilterPageState();
}

class _EmployeesFilterPageState extends State<EmployeesFilterPage> {
  final EmployeesController _employeesController = Get.find();
  final GlobalController _globalController = Get.find();
  SfRangeValues values = const SfRangeValues(20, 60);

  TextEditingController maxController = TextEditingController();

  TextEditingController minController = TextEditingController();
  int genderGroupValue = 0;

  int maritalGroupValue = 1;
  List<String> langs = [];
  List<String> selectedLangs = [];
  String nationality = "";
  @override
  void initState() {
    _employeesController.employeesFilter = EmployeesFilter();
    _employeesController.employeesFilter.maritalStatus = 1;
    // _employeesController.employeesFilter.gender = 0;
    if (_employeesController.employeesFilter.nationalityId != null) {
      nationality = Get.locale == const Locale('en', 'US')
          ? _globalController.countries
              .where((element) =>
                  element.id ==
                  _employeesController.employeesFilter.nationalityId)
              .first
              .nameEn!
          : _globalController.countries
              .where((element) =>
                  element.id ==
                  _employeesController.employeesFilter.nationalityId)
              .first
              .nameAr!;
    }
    langs = _globalController.languages
        .map((e) =>
            Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
        .toList();
    maxController.text = values.end.toString();
    minController.text = values.start.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: coloredText(
          text: "employee_filter_page".tr,
          fontSize: 14.0.sp,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onBackground),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        primary: false,
        children: [
          coloredText(
            fontSize: 14.0.sp,
            text: "nationality".tr,
          ),
          spaceY(10),
          CustomDropDownMenuButton(
            items: _globalController.countries
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
              nationality = p0!;
              _employeesController.employeesFilter.nationalityId =
                  _globalController
                      .countries
                      .where((element) =>
                          element.nameAr == p0 || element.nameEn == p0)
                      .first
                      .id;
            },
            value: nationality == "" ? null : nationality,
            borderc: Border.all(color: const Color(0xffE3E3E3)),
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          ),
          spaceY(20),
          coloredText(fontSize: 14.0.sp, text: "age".tr),
          Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: SfRangeSlider(
              values: values,
              onChanged: (value) {
                values = value;
                minController.text = values.start.toString().split(".")[0];
                maxController.text = values.end.toString().split(".")[0];
                _employeesController.employeesFilter.minAge =
                    int.parse(values.start.toString().split(".")[0]);
                _employeesController.employeesFilter.maxAge =
                    int.parse(values.end.toString().split(".")[0]);
                setState(() {});
              },
              min: 20,
              max: 60,

              interval: 10,
              activeColor: Theme.of(context).sliderTheme.activeTrackColor,

              // showTicks: true,
              showLabels: true,

              enableTooltip: true,
              showDividers: true,
              // shouldAlwaysShowTooltip: true,
              minorTicksPerInterval: 1,
              stepSize: 1,
            ),
          ),
          spaceY(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchTextField(
                textAlign: TextAlign.center,
                hintText: "Start Age",
                controller: minController,
                width: 40.0.w,
                height: 45,
                fillColor: Colors.transparent,
                border: Border.all(
                  color: const Color(0xffE3E3E3),
                ),
                keyBoardType: TextInputType.number,
                onchanged: (s) {
                  if (s != "" && int.parse(s!) >= 20 && int.parse(s) <= 60) {
                    values = SfRangeValues(int.parse(s), values.end);
                    _employeesController.employeesFilter.minAge =
                        int.parse(values.start.toString().split(".")[0]);
                    _employeesController.employeesFilter.maxAge =
                        int.parse(values.end.toString().split(".")[0]);
                    setState(() {});
                  }
                },
              ),
              SearchTextField(
                textAlign: TextAlign.center,
                hintText: "End Age",
                controller: maxController,
                width: 40.0.w,
                height: 45,
                fillColor: Colors.transparent,
                border: Border.all(
                  color: const Color(0xffE3E3E3),
                ),
                keyBoardType: TextInputType.number,
                onchanged: (s) {
                  if (s != "" && int.parse(s!) <= 60 && int.parse(s) >= 20) {
                    values = SfRangeValues(values.start, int.parse(s));
                    _employeesController.employeesFilter.minAge =
                        int.parse(values.start.toString().split(".")[0]);
                    _employeesController.employeesFilter.maxAge =
                        int.parse(values.end.toString().split(".")[0]);
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          spaceY(20),
          // coloredText(fontSize: 14.0.sp, text: "gender".tr),
          // Row(
          //   children: [
          //     MyRadioButton(
          //       text: "male".tr,
          //       value: 0,
          //       color: Theme.of(Get.context!).colorScheme.secondary,
          //       groupValue: genderGroupValue,
          //       onChanged: (p0) {
          //         genderGroupValue = p0;
          //         // _employeesController.employeesFilter.gender = 0;
          //         setState(() {});
          //       },
          //     ),
          //     spaceX(10),
          //     MyRadioButton(
          //       color: Theme.of(Get.context!).colorScheme.secondary,
          //       text: "female".tr,
          //       value: 1,
          //       groupValue: genderGroupValue,
          //       onChanged: (p0) {
          //         genderGroupValue = p0;
          //         // _employeesController.employeesFilter.gender = 1;
          //         setState(() {});
          //       },
          //     ),
          //   ],
          // ),
          // spaceY(20),

          coloredText(fontSize: 14.0.sp, text: "marital_status".tr),
          Row(
            children: [
              MyRadioButton(
                color: Theme.of(Get.context!).colorScheme.secondary,
                text: "single".tr,
                value: 1,
                groupValue: maritalGroupValue,
                onChanged: (p0) {
                  maritalGroupValue = p0;
                  _employeesController.employeesFilter.maritalStatus = 1;
                  setState(() {});
                },
              ),
              spaceX(10),
              MyRadioButton(
                color: Theme.of(Get.context!).colorScheme.secondary,
                text: "married".tr,
                value: 2,
                groupValue: maritalGroupValue,
                onChanged: (p0) {
                  maritalGroupValue = p0;
                  _employeesController.employeesFilter.maritalStatus = 2;
                  setState(() {});
                },
              ),
            ],
          ),
          spaceY(20),
          coloredText(fontSize: 14.0.sp, text: "s_languages".tr),
          spaceY(5),
          Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 5,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
            ),
            child: MultiSelectDialogField(
                buttonText: coloredText(
                    text: "choose".tr, color: Colors.grey, fontSize: 15),
                items: langs.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.CHIP,
                // selectedColor: Theme.of(context).colorScheme.secondary,
                // backgroundColor: Colors.white,
                selectedItemsTextStyle: coloredText(
                        text: "text",
                        color: Theme.of(context).colorScheme.secondary)
                    .style,
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                buttonIcon: Icon(
                  FontAwesomeIcons.sortDown,
                  color: Colors.grey.shade700,
                  size: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE3E3E3),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                chipDisplay: MultiSelectChipDisplay<String>.none(),
                // (
                //   chipColor:
                //       Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   onTap: (p0) {
                //     selectedLangs.rfemove(p0);
                //     setState(() {});
                //   },
                //   textStyle: coloredText(
                //           text: "text",
                //           color: Theme.of(context).colorScheme.secondary)
                //       .style,
                // ),
                onConfirm: (values) {
                  selectedLangs = values;

                  setState(() {});
                }),
          ),
          spaceY(5.sp),
          selectedLangs.isEmpty
              ? Container()
              : SizedBox(
                  height: 28.sp,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selectedLangs.removeAt(index);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.05),
                              ),
                              child: Center(
                                  child: coloredText(
                                      text: selectedLangs[index],
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                            ),
                          ),
                      separatorBuilder: (context, index) => spaceX(10.sp),
                      itemCount: selectedLangs.length),
                ),
          spaceY(20),
          Align(
            child: primaryButton(
                onTap: () {
                  _employeesController.employeesFilter.langs = selectedLangs;

                  _employeesController.applyFilter();
                  Get.back();
                },
                height: 50,
                width: 50.0.w,
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                text: coloredText(
                  text: "apply".tr,
                  color: Colors.white,
                  fontSize: 15.0.sp,
                ),
                radius: 15),
          )
        ],
      ),
    );
  }
}
