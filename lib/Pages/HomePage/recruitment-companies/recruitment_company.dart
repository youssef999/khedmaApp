import 'package:chips_choice/chips_choice.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/Pages/chat%20page/chat_page.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/chat%20page/model/my_message.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/profile_card.dart';

class RecruitmentCompany extends StatefulWidget {
  const RecruitmentCompany({super.key, required this.company});
  final CompanyModel company;
  @override
  State<RecruitmentCompany> createState() => _RecruitmentCompanyState();
}

class _RecruitmentCompanyState extends State<RecruitmentCompany>
    with SingleTickerProviderStateMixin {
  ChatController _chatController = Get.find();
  GlobalController _globalController = Get.find();
  // CompaniesController _companiesController = Get.find();
  List<EmployeeModel> employeesToShow = [];
  List<EmployeeModel> employees = [];
  List<EmployeeModel> employeesOfficeWarrantly = [];
  List<EmployeeModel> employeesIsOffer = [];
  bool visible = true;
  List<String> tags = [
    "employees",
  ];

  List<String> options = [
    "employees",
    "office_warrently",
    "offers",
  ];
  List<EmployeeModel> employeesPerJobList = [];
  List<String?> jobsForFilter = [];
  late List<String> tabs = [];
  late TabController tabController;
  int selectedTabIndex = 0;
  bool offerFlag = false;
  @override
  void initState() {
    tabs = _globalController.jobs
        .map((e) =>
            Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
        .toList();
    tabController = TabController(length: tabs.length, vsync: this);

    for (var employee in widget.company.companyInformation!.employees!) {
      jobsForFilter.addAll(employee.jobs!
          .where((job) =>
              tabs[selectedTabIndex] == job.nameAr! ||
              tabs[selectedTabIndex] == job.nameEn!)
          .toList()
          .map((e) => e.nameEn)
          .toList());
    }

    employees = widget.company.companyInformation!.employees!
        .where((element) => element.isOffer == 0)
        .toList();
    employeesOfficeWarrantly = widget.company.companyInformation!.employees!
        .where((element) => element.isOffer == 0)
        .toList();
    employeesIsOffer = widget.company.companyInformation!.employees!
        .where((element) => element.isOffer == 1)
        .toList();

    employeesToShow = employees;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ClipPath(
          // clipper: OvalBottomBorderClipper(),
          clipper: Clipp(),
          child: Container(
            padding: EdgeInsetsDirectional.only(
                start: 8.0.sp, end: 8.0.sp, top: 25.0.sp, bottom: 8.0.sp),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: AlignmentDirectional.bottomStart,
              end: AlignmentDirectional.topEnd,
              stops: [0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1],
              colors: [
                Color(0xff225153),
                Color(0xff24615E),
                Color(0xff257169),
                Color(0xff278274),
                Color(0xff28927E),
                Color(0xff2AA289),
                Color(0xff2BB294),
              ],
            )),
            width: 100.0.w,
            height: 43.0.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22.0.sp,
                      ),
                    ),
                    _globalController.guest
                        ? Container()
                        : Row(
                            children: [
                              GestureDetector(
                                child: Icon(
                                  EvaIcons.messageCircle,
                                  color: Colors.white,
                                  size: 22.0.sp,
                                ),
                                onTap: () async {
                                  logSuccess(widget.company.id!);
                                  GlobalChat? chat = await _chatController
                                      .storeChat(id: widget.company.id!);

                                  if (chat != null) {
                                    Get.to(
                                      () => ChatPage(
                                        chatId: chat.chat!.id!,
                                        receiverId: chat.chat!.id!,
                                        recieverName: chat.user!.fullName!,
                                        recieverImage:
                                            _globalController.me.userType ==
                                                    "company"
                                                ? chat.user!.userInformation!
                                                    .personalPhoto!
                                                : chat.user!.companyInformation!
                                                    .companyLogo!,
                                      ),
                                    );
                                  }
                                  // Get.to(() => const MessagesPage());
                                },
                              ),
                              spaceX(10.sp),
                              Theme(
                                data: ThemeData(primaryColor: Colors.white),
                                child: PopupMenuButton(
                                  constraints: BoxConstraints(
                                    minWidth: 2.0 * 56.0,
                                    maxWidth: MediaQuery.of(context).size.width,
                                  ),
                                  itemBuilder: (BuildContext cc) => [
                                    PopupMenuItem<int>(
                                      value: 0,
                                      child: coloredText(
                                          text: 'report'.tr, fontSize: 12.0.sp),
                                      onTap: () async {
                                        Utils().reportDialoge(
                                          context: context,
                                          companyId: widget.company.id!,
                                        );
                                      },
                                    ),
                                  ],
                                  child: const Icon(
                                    EvaIcons.moreVertical,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                spaceY(1.0.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      // onTap: () => Get.to(() => const RecruitmentCompany(),
                      //     ),
                      child: Container(
                        width: 75.0.sp,
                        height: 75.0.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget
                                  .company.companyInformation!.companyLogo!),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    spaceX(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coloredText(
                              text: widget.company.fullName!,
                              color: Colors.white,
                              fontSize: 16.0.sp),
                          spaceY(6),
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
                                    ? widget.company.companyInformation!.city!
                                        .nameEn!
                                    : widget.company.companyInformation!.city!
                                        .nameAr!,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14.0.sp,
                              ),
                            ],
                          ),
                          spaceY(6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                EvaIcons.phone,
                                color: const Color(0xffD4D4D4),
                                size: 15.0.sp,
                              ),
                              spaceX(5),
                              coloredText(
                                text: widget
                                    .company.companyInformation!.companyPhone!,
                                fontSize: 13.0.sp,
                                color: const Color(0xffD4D4D4),
                              ),
                            ],
                          ),
                          spaceY(6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                EvaIcons.star,
                                color: Colors.yellow,
                                size: 15.0.sp,
                              ),
                              spaceX(5),
                              coloredText(
                                text: (widget.company
                                            .reviewCompanySumReviewValue ??
                                        0)
                                    .toString(),
                                fontSize: 13.0.sp,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                spaceY(3.0.h),
                ChipsChoice<String>.multiple(
                  padding: EdgeInsets.zero,
                  value: tags,
                  onChanged: (val) {},
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: options,
                    value: (i, v) => v,
                    label: (i, v) => v,
                  ),
                  // choiceStyle: C2ChipStyle.outlined(),
                  choiceCheckmark: true,

                  choiceBuilder: (item, i) => GestureDetector(
                    onTap: () {
                      if (item.label == "employees") {
                        employeesToShow = employees;
                      } else if (item.label == "office_warrently") {
                        employeesToShow = employeesOfficeWarrantly;
                      } else {
                        employeesToShow = employeesIsOffer;
                      }
                      setState(() {});
                      if (!tags.contains(item.label)) {
                        tags = [];
                        tags.add(item.label);
                      }
                      if (item.label == "offers") {
                        offerFlag = true;
                      } else {
                        offerFlag = false;
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: 40.0.w,
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 1.0.w),
                      decoration: BoxDecoration(
                          color: !tags.contains(item.label)
                              ? const Color(0xffE8E8E8).withOpacity(0)
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: !tags.contains(item.label)
                                ? const Color(0xffF1F1F1)
                                : Colors.transparent,
                          )),
                      child: Center(
                        child: coloredText(
                            text: item.label.tr,
                            color: !tags.contains(item.label)
                                ? const Color(0xffF1F1F1)
                                : Colors.white,
                            fontSize: 12.0.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // spaceY(1.0.h),
        Expanded(
          child: Column(
            children: [
              TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.black,
                  isScrollable: true,
                  controller: tabController,
                  onTap: (value) {
                    selectedTabIndex = value;
                    jobsForFilter = [];
                    for (var employee
                        in widget.company.companyInformation!.employees!) {
                      jobsForFilter.addAll(employee.jobs!
                          .where((job) =>
                              tabs[selectedTabIndex] == job.nameAr! ||
                              tabs[selectedTabIndex] == job.nameEn!)
                          .toList()
                          .map((e) => e.nameEn)
                          .toList());
                    }

                    // employeesPerJobList = [];
                    // setState(() {});

                    // for (var employee
                    //     in widget.company.companyInformation!.employees!) {
                    //   List tmp = employee.jobs!
                    //       .where((job) =>
                    //           tabs[selectedTabIndex] == job.nameAr! ||
                    //           tabs[selectedTabIndex] == job.nameEn!)
                    //       .toList();
                    //   if (tmp.isNotEmpty) {
                    //     visible = true;
                    //   } else {
                    //     visible = false;
                    //   }
                    // }
                    // for (var element
                    //     in widget.company.companyInformation!.employees!) {
                    //   List tmp = element.jobs!
                    //       .where((job) =>
                    //           tabs[selectedTabIndex] == job.nameAr! ||
                    //           tabs[selectedTabIndex] == job.nameEn!)
                    //       .toList();
                    //   if (tmp.isNotEmpty) {
                    //     employeesPerJobList.add(element);
                    //   }
                    // }
                    setState(() {});
                  },
                  tabs: List<Widget>.generate(
                    tabController.length,
                    (index) => Tab(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: coloredText(
                            text: tabs[index].tr,
                            color: selectedTabIndex == index
                                ? Colors.black
                                : Colors.grey),
                      ),
                    ),
                  )),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: List<Widget>.generate(
                      tabController.length,
                      (index) => employeesToShow.isEmpty
                          ? const NoItemsWidget()
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemBuilder: (context, index) => Visibility(
                                visible: employeesToShow[index]
                                    .jobs!
                                    .where((element) =>
                                        jobsForFilter
                                            .contains(element.nameAr) ||
                                        jobsForFilter.contains(element.nameEn))
                                    .isNotEmpty,
                                child: ProfileCard(
                                  employee: employeesToShow[index],
                                  // trailing: _globalController.guest
                                  //     ? Container()
                                  //     : GestureDetector(
                                  //         onTap: () async {
                                  //           if (employeesToShow[index]
                                  //                       .favourite !=
                                  //                   null &&
                                  //               employeesToShow[index]
                                  //                       .favourite!
                                  //                       .userId ==
                                  //                   _globalController.me.id &&
                                  //               employeesToShow[index]
                                  //                       .favourite!
                                  //                       .type ==
                                  //                   0) {
                                  //             await _globalController
                                  //                 .deleteFavourite(
                                  //               detect: 0,
                                  //               id: employeesToShow[index]
                                  //                   .favourite!
                                  //                   .id!,
                                  //             );
                                  //           } else {
                                  //             await _globalController
                                  //                 .storeFavourite(
                                  //                     typeId:
                                  //                         employeesToShow[index]
                                  //                             .id!,
                                  //                     type: 0);
                                  //           }
                                  //           CompanyModel? m =
                                  //               await _companiesController
                                  //                   .showCompany(
                                  //                       id: widget.company.id!,
                                  //                       indicator: false);
                                  //           if (m != null) {
                                  //             Get.off(() => RecruitmentCompany(
                                  //                 company: m));
                                  //           }
                                  //         },
                                  //         child: Icon(
                                  //           EvaIcons.heart,
                                  //           color: employeesToShow[index]
                                  //                           .favourite !=
                                  //                       null &&
                                  //                   employeesToShow[index]
                                  //                           .favourite!
                                  //                           .userId ==
                                  //                       _globalController
                                  //                           .me.id &&
                                  //                   employeesToShow[index]
                                  //                           .favourite!
                                  //                           .type ==
                                  //                       0
                                  //               ? Colors.red
                                  //               : const Color(0xffD4D4D4),
                                  //           size: 13.0.sp,
                                  //         ),
                                  //       ),

                                  isOffer: offerFlag,
                                ),
                              ),
                              separatorBuilder: (context, index) => spaceY(10),
                              itemCount: employeesToShow.length,
                            ),
                    )),
              )
            ],
          ),
        )
      ],
    ));
  }
}

class Clipp extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double firstFactor = 0;
    double secondFactor = size.height - 35;
    double thirdFactor = 0;
    double fourthFactor = size.height - 35;
    path.moveTo(firstFactor, 0);
    path.quadraticBezierTo(thirdFactor, firstFactor, 0, firstFactor);
    path.lineTo(0, fourthFactor);
    path.quadraticBezierTo(
      size.width / 3,
      size.height,
      size.width,
      secondFactor,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
