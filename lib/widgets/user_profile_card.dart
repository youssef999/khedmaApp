import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:sizer/sizer.dart';

import '../Pages/HomePage/employees/employee_page.dart';
import '../Utils/utils.dart';

// ignore: must_be_immutable
class UserProfileCard extends StatelessWidget {
  UserProfileCard({
    super.key,
    this.trailing,
    required this.employeeModel,
  });
  final EmployeeModel employeeModel;
  final Widget? trailing;
  // ignore: unused_field
  final GlobalController _globalController = Get.find();
  EmployeesController _employeeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            EmployeeModel? em = await _employeeController.showEmployee(
                id: employeeModel.id!, indicator: true);
            if (em != null) {
              Get.to(
                () => EmployeePage(employeeModel: em),
              );
            } else {
              EmployeeModel? em = await _employeeController.showEmployee(
                  id: employeeModel.id!, indicator: true);
              if (em != null) {
                Get.to(
                  () => EmployeePage(employeeModel: em),
                );
              }
            }
          },
          child: Container(
            width: 60.0.sp,
            height: 60.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(employeeModel.image!), fit: BoxFit.cover),
            ),
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
                              text: employeeModel.nameEn != null
                                  ? employeeModel.nameEn!
                                  : 'lorem ipsun',
                              fontSize: 13.0.sp)
                          : coloredText(
                              text: employeeModel.nameAr != null
                                  ? employeeModel.nameAr!
                                  : 'lorem ipsun',
                              fontSize: 13.0.sp),
                      spaceY(5.sp),
                      Row(
                        children: [
                          SizedBox(
                            width: employeeModel.isOffer == 1 ? 25.w : null,
                            child: coloredText(
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              text:
                                  "${(double.parse(employeeModel.contractAmount!) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key} / ${"${employeeModel.contractDuration!} years"}",
                              color: employeeModel.isOffer == 1
                                  ? const Color(0xff919191)
                                  : Theme.of(context).colorScheme.tertiary,
                              fontSize: 9.0.sp,
                              decoration: employeeModel.isOffer == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          employeeModel.isOffer != 1
                              ? Container()
                              : spaceX(4.sp),
                          employeeModel.isOffer != 1
                              ? Container()
                              : SizedBox(
                                  width:
                                      employeeModel.isOffer == 1 ? 25.w : null,
                                  child: coloredText(
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    text:
                                        "${(employeeModel.amountAfterDiscount! * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key} / ${"${employeeModel.contractDuration!} years"}",
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 9.0.sp,
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                  trailing ?? Container(),
                ],
              ),
              employeeModel.jobs == null || employeeModel.jobs!.isEmpty
                  ? Container()
                  : spaceY(10),
              employeeModel.jobs == null || employeeModel.jobs!.isEmpty
                  ? Container()
                  : SizedBox(
                      height: 24.sp,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
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
                                ? employeeModel.jobs![index].nameEn!
                                : employeeModel.jobs![index].nameAr!,
                            color: const Color(0xff787878),
                            fontSize: 11.0.sp,
                          ),
                        ),
                        itemCount: employeeModel.jobs!.length,
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
                    text: Get.locale != const Locale('en', 'US')
                        ? _globalController.countries
                            .firstWhere((element) =>
                                element.id == employeeModel.birthPlace)
                            .nameAr!
                        : _globalController.countries
                            .firstWhere((element) =>
                                element.id == employeeModel.livingTown)
                            .nameEn!,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13.0.sp,
                  ),
                ],
              ),
              //   spaceY(10),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       const Icon(EvaIcons.star, color: Colors.yellow),
              //       spaceX(5),
              //       coloredText(
              //         text: "4.5",
              //         fontSize: 13.0.sp,
              //         color: Colors.black,
              //       ),
              //     ],
              //   )
            ],
          ),
        )
      ],
    );
  }
}
