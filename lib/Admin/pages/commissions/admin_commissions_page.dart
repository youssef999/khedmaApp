import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/models/setting_admin_model.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/radio_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';

class AdminCommissionsPage extends StatefulWidget {
  const AdminCommissionsPage({super.key});

  @override
  State<AdminCommissionsPage> createState() => _AdminAddressesPageState();
}

class _AdminAddressesPageState extends State<AdminCommissionsPage> {
  AdminController _adminController = Get.find();
  late SettingAdmin _settingAdmin;
  @override
  void initState() {
    _settingAdmin =
        SettingAdmin.fromJson(_adminController.settingAdmin.toJson());
    recruitmentCommissionGroup = _settingAdmin.typeCommssionRecruitment!;
    cleanCommissionGroup = _settingAdmin.typeCommssionCleaning!;
    super.initState();
  }

  int recruitmentCommissionGroup = 0;
  int cleanCommissionGroup = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ])),
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 15.h,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  coloredText(
                    text: "commissions".tr,
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                  spaceX(10)
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                width: 100.w,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp,
                          text: "commssion_recruitment_type".tr),
                      spaceY(5.sp),
                      Row(
                        children: [
                          MyRadioButton(
                            text: "fixed".tr,
                            value: 0,
                            color: Theme.of(Get.context!).colorScheme.secondary,
                            groupValue: recruitmentCommissionGroup,
                            onChanged: (p0) {
                              recruitmentCommissionGroup = p0;
                              _settingAdmin.typeCommssionRecruitment = p0;
                              setState(() {});
                            },
                          ),
                          spaceX(10.sp),
                          MyRadioButton(
                            color: Theme.of(Get.context!).colorScheme.secondary,
                            text: "rate".tr,
                            value: 1,
                            groupValue: recruitmentCommissionGroup,
                            onChanged: (p0) {
                              recruitmentCommissionGroup = p0;
                              _settingAdmin.typeCommssionRecruitment = p0;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "commssion_recruitment".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix(
                            recruitmentCommissionGroup == 0 ? "kwd".tr : "%"),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue: _settingAdmin.commssionRecruitment,
                        onchanged: (s) {
                          _settingAdmin.commssionRecruitment = s;
                        },
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "commssion_clean_type".tr),
                      spaceY(5.sp),
                      Row(
                        children: [
                          MyRadioButton(
                            text: "fixed".tr,
                            value: 0,
                            color: Theme.of(Get.context!).colorScheme.secondary,
                            groupValue: cleanCommissionGroup,
                            onChanged: (p0) {
                              cleanCommissionGroup = p0;
                              _settingAdmin.typeCommssionCleaning = p0;
                              setState(() {});
                            },
                          ),
                          spaceX(10.sp),
                          MyRadioButton(
                            color: Theme.of(Get.context!).colorScheme.secondary,
                            text: "rate".tr,
                            value: 1,
                            groupValue: cleanCommissionGroup,
                            onChanged: (p0) {
                              cleanCommissionGroup = p0;
                              _settingAdmin.typeCommssionCleaning = p0;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "commssion_clean".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix(
                            cleanCommissionGroup == 0 ? "kwd".tr : "%"),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue: _settingAdmin.commssionCleaning,
                        onchanged: (s) {
                          _settingAdmin.commssionCleaning = s;
                        },
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "advertisment_price".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix("kwd".tr),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue: _settingAdmin.advertisementPrice,
                        onchanged: (s) {
                          _settingAdmin.advertisementPrice = s;
                        },
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "price_pending_employee".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix("kwd".tr),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue: _settingAdmin.pricePendingEmployee,
                        onchanged: (s) {
                          if (s != null && s != "") {
                            _settingAdmin.pricePendingEmployee = s;
                          }
                        },
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp,
                          text: "end_date_pending_employee".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix("day".tr),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue:
                            _settingAdmin.endDatePendingEmployee.toString(),
                        onchanged: (s) {
                          if (s != null && s != "") {
                            _settingAdmin.endDatePendingEmployee = int.parse(s);
                          }
                        },
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "medical_exam_price".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix("kwd".tr),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue:
                            _settingAdmin.medicalExaminationPrice.toString(),
                        onchanged: (s) {
                          if (s != null && s != "") {
                            _settingAdmin.medicalExaminationPrice = s;
                          }
                        },
                      ),
                      spaceY(10.sp),
                      coloredText(
                          fontSize: 14.0.sp, text: "khedma_cleaning_price".tr),
                      spaceY(5.sp),
                      SendMessageTextField(
                        suffixIcon: Utils.kwdSuffix("kwd".tr),
                        borderRadius: 10,
                        focusNode: FocusNode(),
                        keyBoardType: TextInputType.number,
                        initialValue: _settingAdmin.khedmaPrice.toString(),
                        onchanged: (s) {
                          if (s != null && s != "") {
                            _settingAdmin.khedmaPrice = s;
                          }
                        },
                      ),
                      spaceY(30.sp),
                      primaryButton(
                          onTap: () async {
                            bool b = await _adminController.updateSettingAdmin(
                                settingAdmin: _settingAdmin);
                            // ignore: use_build_context_synchronously
                            if (b) Utils.doneDialog(context: context);
                          },
                          text: coloredText(
                            text: "edit".tr,
                            color: Colors.white,
                          ),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ]))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
