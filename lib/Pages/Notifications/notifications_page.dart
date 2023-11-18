import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/pages/advertisments/admin_advertisment_page.dart';
import 'package:khedma/Pages/HomePage/company%20home/company_personal_page.dart';
import 'package:khedma/Pages/HomePage/company%20home/emloyee_details.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/HomePage/employees/employee_page.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/chat%20page/messages_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/personal%20page/personal_page.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationController _notificationController =
      Get.put(NotificationController());
  @override
  void initState() {
    _notificationController.getNotifications();
    super.initState();
  }

  EmployeesController _employeesController = Get.find();
  GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: coloredText(text: "notifications".tr, fontSize: 15.0.sp),
        ),
        body: GetBuilder<NotificationController>(builder: (c) {
          return c.getNotificationsFlag
              ? const Center(child: CircularProgressIndicator())
              : c.notifications.isEmpty
                  ? const NoItemsWidget()
                  : ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () async {
                              switch (c.notifications[index].notificationType) {
                                case "Employee":
                                  if (_globalController.me.userType == "user") {
                                    EmployeeModel? em =
                                        await _employeesController
                                            .showMyEmployee(
                                                id: c.notifications[index]
                                                    .typeId!,
                                                indicator: true);
                                    if (em != null) {
                                      Get.to(() => EmployeePage(
                                            employeeModel: em,
                                          ));
                                    }
                                  } else {
                                    EmployeeModel? em =
                                        await _employeesController
                                            .showCompanyEmployee(
                                                id: c.notifications[index]
                                                    .typeId!,
                                                indicator: true);
                                    if (em != null) {
                                      Get.to(() => EmployeeDetailsPage(
                                            employee: em,
                                          ));
                                    }
                                  }

                                  break;
                                case "reservationExtintion":
                                  if (_globalController.me.userType == "user") {
                                    Get.to(() => const PersonalPage());
                                  } else {
                                    Get.to(() => const CompanyPersonalPage());

                                    EmployeeModel? em =
                                        await _employeesController
                                            .showCompanyEmployee(
                                                id: c.notifications[index]
                                                    .typeId!,
                                                indicator: true);
                                    if (em != null) {
                                      Get.to(() => EmployeeDetailsPage(
                                            employee: em,
                                          ));
                                    }
                                  }

                                  break;
                                case "chatMessage":
                                  Get.to(() => const MessagesPage());

                                  break;
                                case "advertisement":
                                  if (_globalController.me.userType ==
                                      "admin") {
                                    Get.to(
                                        () => const AdminAdvertismentsPage());
                                  } else {
                                    Get.to(() => const CompanyPersonalPage());
                                  }

                                  break;
                                default:
                              }
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 100.0.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        coloredText(
                                            text: c.notifications[index].text!,
                                            fontSize: 13.0.sp,
                                            fontWeight: FontWeight.w600),
                                        spaceY(10),
                                        coloredText(
                                          text: DateFormat('yyyy-MM-dd hh:mm a')
                                              .format(DateTime.parse(c
                                                  .notifications[index]
                                                  .createdAt!)),
                                          fontSize: 11.0.sp,
                                          color: Colors.grey,
                                        ),
                                        // DateFormat('dd/M/y').format(DateTime.parse(
                                        //         c.notifications[index].createdAt!)) +
                                        //     " " +
                                        //     DateFormat('hh:mm a').format(
                                        //         DateTime.parse(c.notifications[index]
                                        //             .createdAt!)),
                                        // 11),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => Container(
                            width: 100.0.w,
                            height: 2,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            color: const Color(0xffD8D8D8),
                          ),
                      itemCount: c.notifications.length);
        }));
  }
}
