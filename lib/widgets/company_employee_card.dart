import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:sizer/sizer.dart';

import '../Utils/utils.dart';

// ignore: must_be_immutable
class CompanyEmployeeCard extends StatelessWidget {
  CompanyEmployeeCard(
      {super.key, this.trailing, this.onTap, required this.employee});
  final EmployeeModel employee;

  final Widget? trailing;
  GlobalController _globalController = Get.find();

  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60.0.sp,
            height: 60.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(employee.image), fit: BoxFit.cover),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Get.locale == const Locale('en', 'US')
                            ? coloredText(
                                text: employee.nameEn != null
                                    ? employee.nameEn!.length > 8
                                        ? "${employee.nameEn!.substring(0, 8)}..."
                                        : employee.nameEn!
                                    : 'lorem ipsun',
                                fontSize: 13.0.sp)
                            : coloredText(
                                text: employee.nameAr != null
                                    ? employee.nameAr!.length > 8
                                        ? "${employee.nameAr!.substring(0, 8)}..."
                                        : employee.nameAr!
                                    : 'lorem ipsun',
                                fontSize: 13.0.sp),
                        spaceY(5.sp),
                        Row(
                          children: [
                            coloredText(
                              text:
                                  "${employee.contractAmount!} ${'kwd'.tr} / ${employee.contractDuration! + "year".tr}",
                              color: employee.isOffer == 1
                                  ? const Color(0xff919191)
                                  : Theme.of(context).colorScheme.tertiary,
                              fontSize: 9.0.sp,
                              decoration: employee.isOffer == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            employee.isOffer != 1 ? Container() : spaceX(4.sp),
                            employee.isOffer != 1
                                ? Container()
                                : coloredText(
                                    text:
                                        "${employee.amountAfterDiscount!} ${'kwd'.tr} / ${employee.contractDuration! + "year".tr}",
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 9.0.sp,
                                  ),
                          ],
                        )
                      ],
                    ),
                    trailing ?? Container(),
                  ],
                ),
                spaceY(10),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF8F8F8),
                        border: Border.all(
                          color: const Color(0xffE8E8E8),
                        ),
                      ),
                      child: coloredText(
                        text: Get.locale == const Locale('en', 'US')
                            ? employee.jobs![index].nameEn!
                            : employee.jobs![index].nameAr!,
                        color: const Color(0xff787878),
                        fontSize: 11.0.sp,
                      ),
                    ),
                    itemCount: employee.jobs!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        spaceX(5),
                  ),
                ),
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
                      text: _globalController.countries
                          .where(
                              (element) => element.id == employee.nationalityId)
                          .map((e) => Get.locale == const Locale('en', 'US')
                              ? e.nameEn!
                              : e.nameAr!)
                          .first,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 13.0.sp,
                    ),
                  ],
                ),
                spaceY(10),
                primaryButton(
                  alignment: AlignmentDirectional.centerStart,
                  color: employee.status == null ||
                          employee.status!.status != "booked"
                      ? Colors.black
                      : const Color(0xff9A9A9A),
                  width: 35.w,
                  height: 30.sp,
                  radius: 10,
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      coloredText(
                          text: employee.status == null
                              ? "not_booked".tr
                              : employee.status!.status!.tr,
                          color: Colors.white),
                      employee.status == null ||
                              (employee.status != null &&
                                  employee.status!.status != "booked")
                          ? Container()
                          : spaceX(10),
                      employee.status == null ||
                              (employee.status != null &&
                                  employee.status!.status != "booked")
                          ? Container()
                          : Icon(
                              EvaIcons.checkmarkCircle,
                              size: 15.sp,
                              color: Colors.white,
                            )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
