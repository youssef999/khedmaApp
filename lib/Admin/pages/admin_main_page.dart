import 'package:badges/badges.dart' as badges;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/account%20statment/admin_account_statment_page.dart';
import 'package:khedma/Admin/pages/company%20profiles/admin_company_profiles_page.dart';
import 'package:khedma/Admin/pages/user%20profiles/admin_user_profiles_page.dart';
import 'package:khedma/Admin/pages/zoom_drawer_controller.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/Notifications/notifications_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/personal%20page/personal_settings.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminMainPage extends StatefulWidget {
  AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage>
    with SingleTickerProviderStateMixin {
  Future getAllThings() async {
    await _adminHomeController.getSettingAdmin();
    await _globalController.getCities();
    await _globalController.getCountries();
    await _globalController.getRegions();
    await _globalController.setLocale();
    await _globalController.getComplexion();
    await _globalController.getRelegions();
    await _globalController.getMaritalStatuss();
    await _globalController.getCertificates();
    await _globalController.getlanguages();
    await _globalController.getjobs();
    await _globalController.getCategories();
    await _adminHomeController.getContacts();
    await _adminHomeController.getMessages();
    await _adminHomeController.getAbouts();
  }

  MyZoomDrawerController _myZoomDrawerController = Get.find();
  List<String> tabs = [
    "bookings".tr,
    "ads".tr,
  ];
  List<String> labels = ['payments'.tr, 'booking_no'.tr];
  List<String> tags = [
    "Y",
  ];
  List<String> options = [
    "W",
    "M",
    "Y",
  ];
  late TabController tabController;
  List<StatisticBoxMdel> statsBoxList = [];

  int switchIndex = 0;
  int selectedTabIndex = 0;

  AdminController _adminHomeController = Get.find();
  GlobalController _globalController = Get.find();

  @override
  void initState() {
    _adminHomeController.getAdminHomePage().then((value) {
      statsBoxList = [
        StatisticBoxMdel(
            title: "booking_no".tr,
            subTitle: _adminHomeController.adminHomePageModel.bookings!
                .round()
                .toString(),
            icon: EvaIcons.calendarOutline),
        StatisticBoxMdel(
          title: "payments".tr,
          subTitle:
              "${_adminHomeController.adminHomePageModel.paymentBookingAmount!}",
          currency: "kwd".tr,
          icon: Icons.monetization_on_outlined,
          onTap: () => Get.to(() => const AdminAccountStatmentPage()),
        ),
        StatisticBoxMdel(
            title: "ads_payment".tr,
            subTitle: "${_adminHomeController.adminHomePageModel.adsAmount!}",
            currency: "kwd".tr,
            onTap: () => Get.to(() => const AdminAccountStatmentPage()),
            icon: Icons.monetization_on_outlined),
        StatisticBoxMdel(
            title: "users_no".tr,
            subTitle: _adminHomeController.adminHomePageModel.users!
                .round()
                .toString(),
            onTap: () => Get.to(() => const AdminUserProfilesPage()),
            icon: EvaIcons.peopleOutline),
        StatisticBoxMdel(
            title: "rec_com_no".tr,
            subTitle: _adminHomeController
                .adminHomePageModel.compnaiesRecruitment!
                .round()
                .toString(),
            onTap: () => Get.to(() => const AdminCompanyProfilesPage()),
            icon: Iconsax.buildings),
        StatisticBoxMdel(
            title: "clean_com_no".tr,
            subTitle: _adminHomeController.adminHomePageModel.compnaiesCleaning!
                .round()
                .toString(),
            onTap: () => Get.to(() => const AdminCompanyProfilesPage()),
            icon: Iconsax.buildings),
      ];
    });
    getAllThings();
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AdminController>(builder: (c) {
        return Column(
          children: [
            SizedBox(
              height: 45.h,
              width: 100.w,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        end: Alignment.bottomLeft,
                        begin: Alignment.topRight,
                        stops: [0.4, 0.6, 0.7, 0.8, 0.9, 0.95, 1],
                        colors: [
                          Color(0xff225153),
                          Color(0xff24615E),
                          Color(0xff257169),
                          Color(0xff278274),
                          Color(0xff28927E),
                          Color(0xff2AA289),
                          Color(0xff2BB294),
                        ],
                      )
                          // color: Theme.of(context).colorScheme.primary,
                          // borderRadius: BorderRadius.only(
                          //   bottomRight: Radius.elliptical(60.0.w, 20.0.w),
                          //   bottomLeft: Radius.elliptical(0, 10.0.w),
                          // ),
                          ),
                      width: 100.0.w,
                      height: 35.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spaceY(25.sp),
                            GetBuilder<GlobalController>(builder: (c) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: _myZoomDrawerController
                                        .zoomDrawerController.open,
                                    child: Icon(
                                      EvaIcons.menu,
                                      color: Colors.white,
                                      size: 22.sp,
                                    ),
                                  ),
                                  spaceX(5.sp),
                                  coloredText(
                                    text:
                                        "${"hello".tr} ${_globalController.me.fullName}",
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  GetBuilder<NotificationController>(
                                      builder: (c) {
                                    return badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: 0, end: 0),
                                      showBadge: c.newNotifications,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => NotificationsPage());
                                        },
                                        child: Icon(
                                          EvaIcons.bell,
                                          color: Colors.white,
                                          size: 22.0.sp,
                                        ),
                                      ),
                                    );
                                  }),
                                  spaceX(12.sp),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          PersonalSettings(userType: "admin"));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 30.sp,
                                      height: 30.sp,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: _globalController
                                                          .me.adminPhoto ==
                                                      "https://khdmah.online/api/images/admin/admin_photo"
                                                  ? const AssetImage(
                                                      "assets/images/logo.png")
                                                  : NetworkImage(
                                                          _globalController
                                                              .me.adminPhoto!)
                                                      as ImageProvider,
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            spaceY(10.sp),
                            c.getAdminHomePageflag
                                ? const SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : coloredText(
                                    text:
                                        "${_adminHomeController.adminHomePageModel.totalBalance!.toStringAsFixed(2)} ${"kwd".tr}",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                            spaceY(2.sp),
                            coloredText(
                              text: "total_balance".tr,
                              color: const Color(0xffE1E1E1),
                              // fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: SizedBox(
                      height: 130.sp,
                      width: 100.w,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => StatisticBoxWidget(
                            statisticBoxMdel: statsBoxList[index]),
                        itemCount: statsBoxList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            spaceX(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<AdminController>(builder: (c) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                    primary: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffDEDEDE), width: 2),
                            ),
                          ),
                          child:
                              coloredText(text: "reports".tr, fontSize: 14.sp),
                        ),
                      ),
                      spaceY(10.sp),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: ToggleSwitch(
                            minWidth: 42.w,
                            minHeight: 30.sp,
                            customTextStyles: [
                              GoogleFonts.poppins(fontSize: 14.sp),
                              GoogleFonts.poppins(fontSize: 14.sp),
                            ],
                            initialLabelIndex: switchIndex,
                            activeBgColor: [Colors.white],
                            inactiveBgColor: Colors.transparent,
                            inactiveFgColor: const Color(0xffA7A7A7),
                            activeFgColor: Colors.black,
                            totalSwitches: 2,
                            labels: labels,
                            onToggle: (index) {
                              switchIndex = index!;
                              if (labels[index] == "booking_no".tr) {
                                c.getBookingsCountGraph();
                              } else if (tabs[selectedTabIndex] ==
                                  "bookings".tr) {
                                c.getBookingPaymentsGraph();
                              } else {
                                c.getAdsPaymentsGraph();
                              }
                            },
                          ),
                        ),
                      ),
                      spaceY(10.sp),
                      switchIndex == 1
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TabBar(
                                  dividerColor: Colors.grey,
                                  // indicatorColor:
                                  //     Theme.of(context).colorScheme.primary,
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  isScrollable: false,
                                  controller: tabController,
                                  onTap: (value) {
                                    selectedTabIndex = value;

                                    if (tabs[selectedTabIndex] ==
                                        "bookings".tr) {
                                      c.getBookingPaymentsGraph();
                                    } else {
                                      c.getAdsPaymentsGraph();
                                    }
                                  },
                                  tabs: List<Widget>.generate(
                                    tabController.length,
                                    (index) => Tab(
                                      child: Container(
                                        // width: 45.w,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: coloredText(
                                          text: tabs[index],
                                          fontSize: 13.sp,
                                          color: selectedTabIndex == index
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                      switchIndex == 1 ? Container() : spaceY(10.sp),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: SizedBox(
                      //     height: 60,
                      //     child: ChipsChoice<String>.multiple(
                      //       padding: EdgeInsets.zero,
                      //       value: tags,
                      //       onChanged: (val) {},
                      //       choiceItems: C2Choice.listFrom<String, String>(
                      //         source: options,
                      //         value: (i, v) => v,
                      //         label: (i, v) => v,
                      //       ),
                      //       // choiceStyle: C2ChipStyle.outlined(),
                      //       choiceCheckmark: true,

                      //       choiceBuilder: (item, i) => GestureDetector(
                      //         onTap: () {
                      //           if (!tags.contains(item.label)) {
                      //             tags = [];
                      //             tags.add(item.label);
                      //           }
                      //           setState(() {});
                      //         },
                      //         child: Container(
                      //           width: 28.sp,
                      //           height: 28.sp,
                      //           margin: EdgeInsetsDirectional.only(start: 10.sp),
                      //           decoration: BoxDecoration(
                      //               boxShadow: tags.contains(item.label)
                      //                   ? [
                      //                       BoxShadow(
                      //                         color: Colors.grey.withOpacity(0.5),
                      //                         spreadRadius: 2,
                      //                         blurRadius: 2,
                      //                         offset: const Offset(0,
                      //                             2), // changes position of shadow
                      //                       ),
                      //                     ]
                      //                   : null,
                      //               color: !tags.contains(item.label)
                      //                   ? const Color(0xffF6F6F6)
                      //                   : Colors.white,
                      //               borderRadius: BorderRadius.circular(5),
                      //               border: Border.all(
                      //                 color: !tags.contains(item.label)
                      //                     ? const Color(0xffF1F1F1)
                      //                     : Colors.transparent,
                      //               )),
                      //           child: Center(
                      //               child: coloredText(
                      //             text: item.label,
                      //             color: tags.contains(item.label)
                      //                 ? Colors.black
                      //                 : const Color(0xff8F8F8F),
                      //           )),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      c.getAdminHomePageflag
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              height: 35.h,
                              width: 100.w,
                              child: Align(
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      height: 35.h,
                                      width: 150.w,
                                      child: BarChart(
                                        BarChartData(
                                          gridData: const FlGridData(
                                            show: true,
                                            drawHorizontalLine: true,
                                            drawVerticalLine: false,
                                          ),
                                          borderData: FlBorderData(show: false),
                                          titlesData: FlTitlesData(
                                            show: true,
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                interval: 5,
                                                getTitlesWidget: (value, meta) {
                                                  return Text(
                                                      _adminHomeController
                                                          .data[value.toInt()]
                                                          .name
                                                          .toString());
                                                },
                                              ),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                reservedSize: 60,
                                                showTitles: true,
                                                // interval: 20,
                                                getTitlesWidget: (value, meta) {
                                                  return Text((value.toInt() >=
                                                          1000
                                                      ? "${(value.toInt() / 1000).toStringAsFixed(1)}k"
                                                      : value
                                                          .toInt()
                                                          .toStringAsFixed(1)));
                                                },
                                              ),
                                            ),
                                            rightTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                reservedSize: 60,
                                                showTitles: true,
                                                // interval: 20,
                                                getTitlesWidget: (value, meta) {
                                                  return Text((value.toInt() >=
                                                          1000
                                                      ? "${(value.toInt() / 1000).toStringAsFixed(1)}k"
                                                      : value
                                                          .toInt()
                                                          .toStringAsFixed(1)));
                                                },
                                              ),
                                            ),
                                            topTitles: const AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: false,
                                              ),
                                            ),
                                          ), // alignment: BarChartAlignment.center,

                                          minY: 0,
                                          maxY: c.maxChart,
                                          groupsSpace: 12,
                                          // baselineY: 20,

                                          barTouchData: BarTouchData(
                                            enabled: false,
                                            touchTooltipData:
                                                BarTouchTooltipData(
                                              tooltipBgColor:
                                                  Colors.transparent,
                                              tooltipMargin: -10,
                                              getTooltipItem: (group,
                                                      groupIndex,
                                                      rod,
                                                      rodIndex) =>
                                                  BarTooltipItem(
                                                (rod.toY) > 1000
                                                    ? "${(rod.toY / 1000).toStringAsFixed(1)} K"
                                                    : (rod.toY)
                                                        .toStringAsFixed(1),
                                                TextStyle(),
                                              ),
                                            ),
                                          ),
                                          barGroups: _adminHomeController.data
                                              .map(
                                                (e) => BarChartGroupData(
                                                  showingTooltipIndicators: [
                                                    0,
                                                    1
                                                  ],
                                                  x: e.id!,
                                                  barsSpace: 10,
                                                  barRods: [
                                                    BarChartRodData(
                                                      toY: e.y!,
                                                      width: 10,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      spaceY(10.sp),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 18.sp,
                      //       height: 18.sp,
                      //       decoration: BoxDecoration(
                      //         color: Theme.of(context).colorScheme.primary,
                      //         borderRadius: BorderRadius.circular(5),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey.withOpacity(0.3),
                      //             spreadRadius: 2,
                      //             blurRadius: 3,
                      //             offset: const Offset(
                      //                 0, 1), // changes position of shadow
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     spaceX(10.sp),
                      //     coloredText(
                      //         text: switchIndex == 0
                      //             ? 'payments'.tr
                      //             : 'booking_no'.tr)
                      //   ],
                      // ),
                      // spaceY(10.sp),
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

class StatisticBoxMdel {
  final String title;
  final String subTitle;
  final IconData icon;
  final String? currency;
  void Function()? onTap;
  StatisticBoxMdel({
    required this.title,
    required this.subTitle,
    required this.icon,
    this.currency,
    this.onTap,
  });
}

class StatisticBoxWidget extends StatelessWidget {
  const StatisticBoxWidget({
    super.key,
    required this.statisticBoxMdel,
  });
  final StatisticBoxMdel statisticBoxMdel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: statisticBoxMdel.onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 140.sp,
        height: 140.sp,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100.sp,
              child: coloredText(
                textAlign: TextAlign.center,
                text: statisticBoxMdel.title,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Icon(
              statisticBoxMdel.icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                coloredText(
                    text: statisticBoxMdel.subTitle,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
                statisticBoxMdel.currency == null ? Container() : spaceX(5.sp),
                statisticBoxMdel.currency == null
                    ? Container()
                    : coloredText(
                        text: statisticBoxMdel.currency!,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
