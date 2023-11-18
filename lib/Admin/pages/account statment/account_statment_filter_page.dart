import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/account%20statment/model/ac_filter.dart';
import 'package:khedma/Themes/themes.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/search_text_field.dart';

class AccountStatmentFilterPage extends StatefulWidget {
  const AccountStatmentFilterPage({super.key});

  @override
  State<AccountStatmentFilterPage> createState() =>
      _AccountStatmentFilterPageState();
}

class _AccountStatmentFilterPageState extends State<AccountStatmentFilterPage> {
  SfRangeValues values = const SfRangeValues(1, 5000);

  TextEditingController maxController = TextEditingController();

  TextEditingController minController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController firstDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  String status = "";
  int dateRadioGroup = 0;
  AdminController _adminController = Get.find();
  @override
  void initState() {
    _adminController.accountStatmentFilter = AccountStatmentFilter();
    maxController.text = values.end.toString();
    minController.text = values.start.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: coloredText(
          text: "ads_filter_page".tr,
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
          coloredText(fontSize: 14.0.sp, text: "booking_date".tr),
          spaceY(10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SendMessageTextField(
                width: 40.w,
                onTap: () async {
                  DateTime? x = await showDatePicker(
                      builder: (context, child) => Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.fromSeed(
                                seedColor: AppThemes.colorCustom,
                              ),
                            ),
                            child: child!,
                          ),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365 * 50),
                      ),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 15)));
                  if (x != null) {
                    _adminController.accountStatmentFilter.minDate =
                        x.toString();
                    firstDateController.text = DateFormat('y/MM/dd').format(x);
                  }
                },
                focusNode: FocusNode(),
                hintText: 'start_date'.tr,
                fillColor: const Color(0xffF8F8F8),
                borderRadius: 10,
                controller: firstDateController,
                readOnly: true,
              ),
              SendMessageTextField(
                width: 40.w,
                onTap: () async {
                  DateTime? x = await showDatePicker(
                      builder: (context, child) => Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.fromSeed(
                                seedColor: AppThemes.colorCustom,
                              ),
                            ),
                            child: child!,
                          ),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365 * 50),
                      ),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 15)));
                  if (x != null) {
                    _adminController.accountStatmentFilter.maxDate =
                        x.toString();
                    lastDateController.text = DateFormat('y/MM/dd').format(x);
                  }
                },
                focusNode: FocusNode(),
                hintText: 'end_date'.tr,
                fillColor: const Color(0xffF8F8F8),
                borderRadius: 10,
                controller: lastDateController,
                readOnly: true,
              ),
            ],
          ),
          spaceY(10.sp),
          coloredText(fontSize: 14.0.sp, text: "price".tr),
          Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: SfRangeSlider(
              values: values,
              onChanged: (value) {
                values = value;
                minController.text = values.start.toString().split(".")[0];
                maxController.text = values.end.toString().split(".")[0];
                setState(() {});
              },
              min: 0,
              max: 5000,

              interval: 5000 / 5,
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
          spaceY(10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchTextField(
                textAlign: TextAlign.center,
                hintText: "0KWD",
                controller: minController,
                width: 40.0.w,
                height: 45,
                fillColor: Colors.transparent,
                border: Border.all(
                  color: const Color(0xffE3E3E3),
                ),
                keyBoardType: TextInputType.number,
                onchanged: (s) {
                  if (s != "" && int.parse(s!) >= 0 && int.parse(s) <= 5000) {
                    values = SfRangeValues(int.parse(s), values.end);
                    setState(() {});
                  }
                },
              ),
              SearchTextField(
                textAlign: TextAlign.center,
                hintText: "5000",
                controller: maxController,
                width: 40.0.w,
                height: 45,
                fillColor: Colors.transparent,
                border: Border.all(
                  color: const Color(0xffE3E3E3),
                ),
                keyBoardType: TextInputType.number,
                onchanged: (s) {
                  if (s != "" && int.parse(s!) <= 5000 && int.parse(s) >= 0) {
                    values = SfRangeValues(values.start, int.parse(s));
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          spaceY(10.sp),
          coloredText(
            fontSize: 14.0.sp,
            text: "deposit_type".tr,
          ),
          spaceY(10),
          CustomDropDownMenuButton(
            items: [
              "pending_employee",
              "checkout_cleaning_company",
              "advertisement",
            ]
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: coloredText(text: e.tr, color: Colors.black),
                  ),
                )
                .toList(),
            onChanged: (p0) {
              status = p0!;
              _adminController.accountStatmentFilter.status = p0;
            },
            value: status == "" ? null : status,
            borderc: Border.all(color: const Color(0xffE3E3E3)),
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          ),
          spaceY(50.sp),
          Align(
            child: primaryButton(
                onTap: () {
                  _adminController.accountStatmentFilter.minPrice =
                      int.parse(minController.text);
                  _adminController.accountStatmentFilter.maxPrice =
                      int.parse(maxController.text);
                  _adminController.applyFilter();

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
