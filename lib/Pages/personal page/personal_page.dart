import 'package:chips_choice/chips_choice.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/recruitment-companies/recruitment_companies_search_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/personal%20page/submit_files_page.dart';
import 'package:khedma/Themes/themes.dart';
import 'package:khedma/web_view_container.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/user_profile_card.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';
import '../../widgets/profile_card.dart';
import '../personal%20page/reservation_extension_request_page.dart';
import 'personal_settings.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({
    super.key,
  });
  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage>
    with SingleTickerProviderStateMixin {
  List<String> tags = [
    "my_bookings".tr,
  ];

  List<String> options = [
    "my_bookings".tr,
    "favourites".tr,
  ];
  List<String> tabs = [
    "pending".tr,
    "booked".tr,
    "canceled".tr,
    "retrieved".tr,
  ];

  List<EmployeeModel> pendingEmployees = [];
  List<EmployeeModel> bookedEmployees = [];
  List<EmployeeModel> canceledEmployees = [];
  List<EmployeeModel> retreivedEmployees = [];
  late TabController tabController;
  int selectedTabIndex = 0;

  PageController pageController = PageController(initialPage: 0);
  GlobalController _globalController = Get.find();
  @override
  void dispose() {
    _globalController.getMe();
    super.dispose();
  }

  @override
  void initState() {
    logSuccess(_globalController.me.toJson());
    // logSuccess(_globalController.me.userInformation!.booking[0].toJson());
    tabController = TabController(length: 4, vsync: this);
    pendingEmployees = _globalController.me.booking
        .where((element) => element.status == "pending")
        .map((e) => e.employee!)
        .toList();
    bookedEmployees = _globalController.me.booking
        .where((element) => element.status == "booked")
        .map((e) => e.employee!)
        .toList();
    canceledEmployees = _globalController.me.booking
        .where((element) => element.status == "candeled")
        .map((e) => e.employee!)
        .toList();
    retreivedEmployees = _globalController.me.booking
        .where((element) => element.status == "retreived")
        .map((e) => e.employee!)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<GlobalController>(builder: (globalController) {
      return Column(
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
              height: 230.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceY(5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
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
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const PersonalSettings(userType: "user"),
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.gear,
                            color: Colors.white,
                            size: 20.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceY(2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Stack(
                          children: [
                            Container(
                              width: 75.0.sp,
                              height: 75.0.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(20.0.w),
                                image: DecorationImage(
                                  image: NetworkImage(globalController
                                      .me.userInformation!.personalPhoto!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                                bottom: 0,
                                end: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    XFile? image =
                                        await Utils().selectImageSheet();

                                    if (image != null) {
                                      await _globalController.updateUserProfile(
                                          userInfo: _globalController
                                              .me.userInformation!,
                                          personaPhoto: image);
                                      // );

                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.4)),
                                    child: const Icon(
                                      FontAwesomeIcons.camera,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      spaceX(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            coloredText(
                                text: globalController.me.fullName!,
                                color: Colors.white,
                                fontSize: 15.0.sp),
                            spaceY(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  EvaIcons.pin,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 13.0.sp,
                                ),
                                spaceX(3),
                                coloredText(
                                  text: Get.locale == const Locale('en', 'US')
                                      ? globalController.countries
                                          .where((element) =>
                                              element.id ==
                                              globalController
                                                  .me
                                                  .userInformation!
                                                  .nationalityId!)
                                          .first
                                          .nameEn!
                                      : globalController.countries
                                          .where((element) =>
                                              element.id ==
                                              globalController
                                                  .me
                                                  .userInformation!
                                                  .nationalityId!)
                                          .first
                                          .nameAr!,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12.0.sp,
                                ),
                              ],
                            ),
                            spaceY(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  EvaIcons.phone,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 15.0.sp,
                                ),
                                spaceX(5),
                                coloredText(
                                  text: globalController
                                      .me.userInformation!.phone!,
                                  fontSize: 13.0.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                        if (!tags.contains(item.label)) {
                          tags = [];
                          tags.add(item.label);
                        }
                        pageController.jumpToPage(options.indexOf(item.label));
                        setState(() {});
                      },
                      child: Container(
                        width: 40.0.w,
                        height: 25.sp,
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
                              text: item.label,
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
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Column(
                children: [
                  TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.black,
                      isScrollable: true,
                      controller: tabController,
                      onTap: (value) {
                        selectedTabIndex = value;
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
                        controller: tabController, children: tapList),
                  )
                ],
              ),
              globalController.allFavourites.isEmpty
                  ? const Center(child: NoItemsWidget())
                  : ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) =>
                          globalController.allFavourites[index].employee != null
                              ? UserProfileCard(
                                  employeeModel: globalController
                                      .allFavourites[index].employee!,
                                  trailing: GestureDetector(
                                    child: const Icon(
                                      EvaIcons.heart,
                                      color: Colors.red,
                                      // size: 13.0.sp,
                                    ),
                                    onTap: () async {
                                      await globalController.deleteFavourite(
                                        detect: 0,
                                        id: globalController
                                            .allFavourites[index].id!,
                                      );
                                    },
                                  ),
                                )
                              : globalController.allFavourites[index].company !=
                                      null
                                  ? CompanyCard(
                                      company: globalController
                                          .allFavourites[index].company!,
                                      deleteFlag: true,
                                      deleteId: globalController
                                          .allFavourites[index].id!,
                                    )
                                  : Container(),
                      separatorBuilder: (context, index) => spaceY(10),
                      itemCount: globalController.allFavourites.length,
                    ),
              // ListView(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              //   children: [
              //     coloredText(
              //       text: "rate_view".tr,
              //       color: Theme.of(context).colorScheme.primary,
              //     ),
              //     const Divider(
              //       color: Color(0xffDBDBDB),
              //     ),
              //     spaceY(10),
              //     Row(
              //       children: [
              //         coloredText(
              //           text: "4.5",
              //           fontSize: 35.0.sp,
              //           color: Theme.of(context).colorScheme.primary,
              //           // fontWeight: FontWeight.bold,
              //         ),
              //         spaceX(30),
              //         Expanded(
              //           child: Column(
              //             children: [
              //               const MyRatingBar(label: '5', value: 50),
              //               spaceY(3),
              //               const MyRatingBar(label: '4', value: 20),
              //               spaceY(3),
              //               const MyRatingBar(label: '3', value: 70),
              //               spaceY(3),
              //               const MyRatingBar(label: '2', value: 10),
              //               spaceY(3),
              //               const MyRatingBar(label: '1', value: 90),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //     spaceY(20),
              //     ListView.separated(
              //         shrinkWrap: true,
              //         primary: false,
              //         padding: EdgeInsets.zero,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemBuilder: (context, index) => Column(
              //               children: [
              //                 Row(
              //                   children: [
              //                     Container(
              //                       width: 12.0.w,
              //                       height: 12.0.w,
              //                       decoration: const BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         image: DecorationImage(
              //                             image: AssetImage(
              //                                 "assets/images/image.png"),
              //                             fit: BoxFit.cover),
              //                       ),
              //                     ),
              //                     spaceX(10),
              //                     coloredText(
              //                       text: "Ahmad ALi",
              //                       color: Colors.black,
              //                       fontSize: 14.0.sp,
              //                     )
              //                   ],
              //                 ),
              //                 Align(
              //                     alignment: AlignmentDirectional.centerStart,
              //                     child: r.RatingBar.readOnly(
              //                       isHalfAllowed: true,
              //                       filledIcon: Icons.star_rounded,
              //                       halfFilledIcon: Icons.star_half_rounded,
              //                       emptyIcon: Icons.star_border_rounded,
              //                       filledColor: Colors.black,
              //                       halfFilledColor: Colors.black,
              //                       emptyColor: Colors.black,
              //                       initialRating: 3.5,
              //                       maxRating: 5,
              //                       size: 18.0.sp,
              //                     )
              //                     //  RatingBar.builder(
              //                     //   initialRating: 4.5,
              //                     //   minRating: 0,
              //                     //   direction: Axis.horizontal,
              //                     //   allowHalfRating: true,
              //                     //   itemCount: 5,
              //                     //   itemSize: 17.0.sp,unratedColor: Colors.transparent,
              //                     //   itemPadding:
              //                     //       EdgeInsets.symmetric(horizontal: 4.0),
              //                     //   itemBuilder: (context, index) {
              //                     //     if (index < 4.5) {
              //                     //       return const Icon(
              //                     //         Icons.star_rounded,
              //                     //         color: Colors.black,
              //                     //       );
              //                     //     } else {
              //                     //       return const Icon(
              //                     //         Icons.star_outline_rounded,
              //                     //         color: Colors.black,
              //                     //       );
              //                     //     }
              //                     //   },
              //                     //   onRatingUpdate: (rating) {
              //                     //     print(rating);
              //                     //   },
              //                     // ),

              //                     ),
              //                 spaceY(10),
              //                 coloredText(
              //                     text:
              //                         "Lorem ipsum dolor sit amet consectetur adipiscing elit",
              //                     color: const Color(0xff919191))
              //               ],
              //             ),
              //         separatorBuilder: (context, index) => spaceY(20),
              //         itemCount: 10),
              //     spaceY(20),
              //   ],
              // ),
            ],
          ))
        ],
      );
    }));
  }

  List<Widget> get tapList => [
        pendingEmployees.isEmpty
            ? const Center(child: NoItemsWidget())
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) => index ==
                        pendingEmployees.length
                    ? spaceY(20.sp)
                    : ProfileCard(
                        employee: pendingEmployees[index],
                        trailing: Theme(
                          data: ThemeData(primaryColor: Colors.white),
                          child: PopupMenuButton(
                            constraints: BoxConstraints(
                              minWidth: 2.0 * 56.0,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<int>(
                                value: 1,
                                child: coloredText(
                                    text: 'reservation_request'.tr,
                                    fontSize: 11.0.sp),
                                onTap: () {
                                  Future(() => Get.to(() =>
                                      ReservationExtensionRequestPage(
                                        employeeId: pendingEmployees[index].id!,
                                      )));
                                },
                              ),
                              PopupMenuItem<int>(
                                value: 4,
                                child: coloredText(
                                    text: 'submit_docs'.tr, fontSize: 12.0.sp),
                                onTap: () {
                                  Future(() => Get.to(() => SubmitFilesPage(
                                        employeeId: pendingEmployees[index].id!,
                                      )));
                                },
                              ),
                            ],
                            child: const Icon(
                              EvaIcons.moreVertical,
                            ),
                          ),
                        ),
                        isOffer: false,
                      ),
                separatorBuilder: (context, index) => spaceY(10),
                itemCount: pendingEmployees.length + 1,
              ),
        bookedEmployees.isEmpty
            ? const Center(child: NoItemsWidget())
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) => index == bookedEmployees.length
                    ? spaceY(20.sp)
                    : ProfileCard(
                        employee: bookedEmployees[index],
                        trailing: Theme(
                          data: ThemeData(primaryColor: Colors.white),
                          child: PopupMenuButton(
                            constraints: BoxConstraints(
                              minWidth: 2.0 * 56.0,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                            itemBuilder: (BuildContext ctx) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: coloredText(
                                    text: 'medical_exam'.tr, fontSize: 11.0.sp),
                                onTap: () async {
                                  DateTime? dateTime =
                                      await showOmniDateTimePicker(
                                          theme: ThemeData(
                                            colorScheme: ColorScheme.fromSeed(
                                              seedColor: AppThemes.colorCustom,
                                            ),
                                          ),
                                          is24HourMode: false,
                                          isShowSeconds: false,
                                          minutesInterval: 1,
                                          secondsInterval: 1,
                                          type: OmniDateTimePickerType.date,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          constraints: const BoxConstraints(
                                            maxWidth: 350,
                                            maxHeight: 650,
                                          ),
                                          transitionBuilder:
                                              (context, anim1, anim2, child) {
                                            return FadeTransition(
                                              opacity: anim1.drive(
                                                Tween(
                                                  begin: 0,
                                                  end: 1,
                                                ),
                                              ),
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                          barrierDismissible: true,
                                          selectableDayPredicate: (dateTime) {
                                            // Disable 25th Feb 2023
                                            if (dateTime ==
                                                DateTime(2023, 2, 25)) {
                                              return false;
                                            } else {
                                              return true;
                                            }
                                          },
                                          context: context,
                                          initialDate: DateTime.now()
                                              .add(Duration(days: 1)),
                                          firstDate: DateTime.now()
                                              .add(Duration(days: 1)),
                                          lastDate: DateTime.now()
                                              .add(const Duration(days: 30)));
                                  if (dateTime != null) {
                                    Map<String, String>? x =
                                        await _globalController
                                            .requestMedicalExamination(
                                                id: bookedEmployees[index].id!,
                                                date: DateFormat('y/MM/dd')
                                                    .format(dateTime));
                                    if (x != null) {
                                      //   //String invoiceId = x.keys.first;
                                      //   Uri url = Uri.parse(x.values.first);
                                      Get.to(() => WebViewContainer(
                                                url: x.values.first,
                                              ))!
                                          .then((value) {
                                        Utils.doneDialog(context: context);
                                      });
                                      //   await launchUrl(url,
                                      //       mode: LaunchMode.externalApplication);

                                      //   await Future.delayed(
                                      //       const Duration(milliseconds: 100));
                                      //   while (WidgetsBinding
                                      //           .instance.lifecycleState !=
                                      //       AppLifecycleState.resumed) {
                                      //     await Future.delayed(
                                      //         const Duration(milliseconds: 100));
                                      //   }
                                    }
                                  }
                                },
                              ),
                            ],
                            child: const Icon(
                              EvaIcons.moreVertical,
                            ),
                          ),
                        ),
                        isOffer: false,
                      ),
                separatorBuilder: (context, index) => spaceY(10),
                itemCount: bookedEmployees.length + 1,
              ),
        canceledEmployees.isEmpty
            ? const Center(child: NoItemsWidget())
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) =>
                    index == canceledEmployees.length
                        ? spaceY(20.sp)
                        : ProfileCard(
                            employee: canceledEmployees[index],
                            isOffer: false,
                          ),
                separatorBuilder: (context, index) => spaceY(10),
                itemCount: canceledEmployees.length + 1,
              ),
        retreivedEmployees.isEmpty
            ? const Center(child: NoItemsWidget())
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) =>
                    index == retreivedEmployees.length
                        ? spaceY(20.sp)
                        : ProfileCard(
                            employee: retreivedEmployees[index],
                            isOffer: false,
                          ),
                separatorBuilder: (context, index) => spaceY(10),
                itemCount: retreivedEmployees.length + 1,
              ),
      ];
}
