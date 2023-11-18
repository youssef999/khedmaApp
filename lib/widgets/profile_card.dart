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
class ProfileCard extends StatelessWidget {
  ProfileCard({
    super.key,
    this.isOffer = false,
    // this.employeeType = EmployeeType.recruitment,
    this.trailing,
    required this.employee,
  });
  bool isOffer = false;
  // final EmployeeType employeeType;
  final Widget? trailing;
  final EmployeeModel employee;
  EmployeesController _employeeController = Get.find();
  GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            // logSuccess(employeeType);
            EmployeeModel? em = await _employeeController.showMyEmployee(
                id: employee.id!, indicator: true);
            if (em != null) {
              Get.to(
                () => EmployeePage(employeeModel: em),
              );
            } else {
              EmployeeModel? em = await _employeeController.showEmployee(
                  id: employee.id!, indicator: true);
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
                  image: NetworkImage(employee.image!), fit: BoxFit.cover),
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
                      coloredText(
                          text: Get.locale == const Locale('en', 'US')
                              ? employee.nameEn!
                              : employee.nameAr!,
                          fontSize: 13.0.sp),
                      spaceY(5.sp),
                      Row(
                        children: [
                          SizedBox(
                            width: employee.isOffer == 1 ? 25.w : null,
                            child: coloredText(
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                              text:
                                  "${(double.parse(employee.contractAmount!) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key} / ${"${employee.contractDuration!}  years"}",
                              color: employee.isOffer == 1
                                  ? const Color(0xff919191)
                                  : Theme.of(context).colorScheme.tertiary,
                              fontSize: 9.0.sp,
                              decoration: employee.isOffer == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          employee.isOffer != 1 ? Container() : spaceX(4.sp),
                          employee.isOffer != 1
                              ? Container()
                              : SizedBox(
                                  width: employee.isOffer == 1 ? 25.w : null,
                                  child: coloredText(
                                    textDirection: TextDirection.ltr,
                                    overflow: TextOverflow.ellipsis,
                                    text:
                                        "${(employee.amountAfterDiscount! * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key} / ${"${employee.contractDuration!} years"}",
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
              spaceY(10),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                        .where((element) {
                          if (employee.livingTown != null) {
                            return element.id == employee.livingTown;
                          } else {
                            return element.id == employee.nationalityId;
                          }
                        })
                        .map((e) => Get.locale == const Locale('en', 'US')
                            ? e.nameEn!
                            : e.nameAr!)
                        .first,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13.0.sp,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
