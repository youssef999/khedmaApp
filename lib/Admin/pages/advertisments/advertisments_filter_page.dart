import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Themes/themes.dart';
import 'package:khedma/widgets/radio_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/search_text_field.dart';

class AdvertismentsFilterPage extends StatefulWidget {
  const AdvertismentsFilterPage({super.key});

  @override
  State<AdvertismentsFilterPage> createState() =>
      _AdvertismentsFilterPageState();
}

class _AdvertismentsFilterPageState extends State<AdvertismentsFilterPage> {
  SfRangeValues values = const SfRangeValues(1, 5000);

  TextEditingController maxController = TextEditingController();

  TextEditingController minController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController firstDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();

  int dateRadioGroup = 0;

  @override
  void initState() {
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
          Row(
            children: [
              MyRadioButton(
                text: "special_date".tr,
                value: 0,
                color: Theme.of(Get.context!).colorScheme.secondary,
                groupValue: dateRadioGroup,
                onChanged: (p0) {
                  dateRadioGroup = p0;
                  setState(() {});
                },
              ),
              spaceX(10.sp),
              MyRadioButton(
                color: Theme.of(Get.context!).colorScheme.secondary,
                text: "from_to".tr,
                value: 1,
                groupValue: dateRadioGroup,
                onChanged: (p0) {
                  dateRadioGroup = p0;
                  setState(() {});
                },
              ),
            ],
          ),
          spaceY(10.sp),
          dateRadioGroup == 0
              ? SendMessageTextField(
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
                        initialDate: DateTime.now().subtract(
                          const Duration(days: 365 * 20),
                        ),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365 * 50),
                        ),
                        lastDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 15)));
                    if (x != null) {
                      dateController.text = DateFormat('y/MM/dd').format(x);
                    }
                  },
                  focusNode: FocusNode(),
                  hintText: 'YYYY/MM/DD',
                  fillColor: const Color(0xffF8F8F8),
                  borderRadius: 10,
                  controller: dateController,
                  readOnly: true,
                )
              : Row(
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
                            initialDate: DateTime.now().subtract(
                              const Duration(days: 365 * 20),
                            ),
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365 * 50),
                            ),
                            lastDate: DateTime.now()
                                .subtract(const Duration(days: 365 * 15)));
                        if (x != null) {
                          firstDateController.text =
                              DateFormat('y/MM/dd').format(x);
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
                            initialDate: DateTime.now().subtract(
                              const Duration(days: 365 * 20),
                            ),
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365 * 50),
                            ),
                            lastDate: DateTime.now()
                                .subtract(const Duration(days: 365 * 15)));
                        if (x != null) {
                          lastDateController.text =
                              DateFormat('y/MM/dd').format(x);
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
                hintText: "0 KWD",
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
                hintText: "5000 KWD",
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
          spaceY(50.sp),
          Align(
            child: primaryButton(
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
