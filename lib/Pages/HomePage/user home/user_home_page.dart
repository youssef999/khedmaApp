import 'dart:math' as math; // import this
import 'dart:math';
import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart'; // ignore_for_file: must_be_immutable
import 'package:easy_stepper/easy_stepper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Pages/HomePage/cleaning%20companies/cleaning_company.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/HomePage/employees/employee_page.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/Pages/HomePage/recruitment-companies/recruitment_company.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/controller/auth_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/login_page.dart';
import 'package:khedma/Pages/log-reg%20pages/models/user_register_model.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:restart_app/restart_app.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/dropdown_menu_button.dart';
import '../../../widgets/underline_text_field.dart';
import '../../Notifications/notifications_page.dart';
import '../../chat%20page/messages_page.dart';
import '../../personal%20page/personal_page.dart';
import '../cleaning%20companies/cleaning_companies_search_page.dart';
import '../employees/employees_search_page.dart';
import '../recruitment-companies/recruitment_companies_search_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({
    super.key,
  });
  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  PageController pageController = PageController(initialPage: 0);
  var errors = {};
  UserRegisterData userCompleteData = UserRegisterData();
  final AuthController _authController = Get.find();
  final ChatController _chatController = Get.find();
  final CompaniesController _companiesController = Get.find();
  final CompanyTypesController _companyTypesController = Get.find();

  List<String> tags = [];

  List<String> options = [
    "cleaner",
    "driver",
    "chef",
    "babysitter",
    "nurse",
    "sewing",
    "washing",
  ];
  bool completedRegisterFlag = false;
  int _currentStep = 0;

  late double h;
  late double h2;
  late double h3;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _pieceNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _adnController = TextEditingController();
  final TextEditingController _idNumController = TextEditingController();

  String button1Text = "upload_id".tr;
  String button2Text = "upload_personal_photo".tr;
  final GlobalController _globalController = Get.find();
  final AdminController _adminController = Get.find();
  Future getAllThings() async {
    await _adminController.getSettingAdmin();
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
    await _adminController.getContacts();
    await _adminController.getAbouts();
    await _globalController.getCategories();
  }

  final EmployeesController _employeesController = Get.find();
  String region = "";
  String nationality = "";
  String city = "";
  // String phoneCode = "";
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  @override
  void initState() {
    if (_globalController.guest) {
      completedRegisterFlag = true;
      _globalController.getUserHomePage();
      getAllThings();
    } else {
      completedRegisterFlag = _globalController.me.userInformation != null;
      _globalController.getUserHomePage();

      _employeesController.getEmployees();
      _chatController.getChats();
      getAllThings();
    }
    h2 = 470.0.sp;
    h = 330.0.sp;
    h3 = 400.0.sp;
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        body: Stack(
          children: [
            Visibility(
              visible: completedRegisterFlag,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 55,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          GestureDetector(
                            onTap: () {
                              Utils.takeContainer(controller, "user_home.png");
                            },
                            child: coloredText(
                              text: "hello".tr,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          spaceX(3),
                          SizedBox(
                            width: 35.w,
                            child: coloredText(
                                text: _globalController.guest
                                    ? "Guest"
                                    : _globalController.me.fullName ?? "",
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ]),
                        _globalController.guest
                            ? GestureDetector(
                                onTap: () {
                                  Get.offAll(() => LoginPage());
                                },
                                child: coloredText(
                                  text: "login".tr,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            : Row(children: [
                                GetBuilder<NotificationController>(
                                    builder: (c) {
                                  return badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                        top: 0, end: 0),
                                    showBadge: c.newNotifications,
                                    child: GestureDetector(
                                      onTap: () => Get.to(
                                        () => NotificationsPage(),
                                      ),
                                      child: Icon(
                                        EvaIcons.bell,
                                        color: const Color(0xffD1D1D1),
                                        size: 25.0.sp,
                                      ),
                                    ),
                                  );
                                }),
                                spaceX(10),
                                GetBuilder<ChatController>(
                                    builder: (chatController) {
                                  return badges.Badge(
                                    showBadge: chatController.unreadChatsFlag,
                                    position: badges.BadgePosition.topEnd(
                                        top: 0, end: 0),
                                    child: GestureDetector(
                                      child: Icon(
                                        EvaIcons.messageCircle,
                                        color: const Color(0xffD1D1D1),
                                        size: 22.0.sp,
                                      ),
                                      onTap: () =>
                                          Get.to(() => const MessagesPage()),
                                    ),
                                  );
                                }),
                                spaceX(10),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => const PersonalPage(),
                                    );
                                  },
                                  child: GetBuilder<GlobalController>(
                                      builder: (c) {
                                    return Container(
                                      width: 25.sp,
                                      height: 25.sp,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   width: 1,
                                        //   color: const Color(0xffD1D1D1),
                                        // ),
                                        image: DecorationImage(
                                          image: NetworkImage(c.me
                                              .userInformation!.personalPhoto!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ]),
                      ],
                    ),
                    spaceY(1.5.h),
                    GetBuilder<GlobalController>(builder: (globalController) {
                      return Expanded(
                        child: globalController.getUserHomePageFlag
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView(
                                padding: EdgeInsets.zero,
                                physics: completedRegisterFlag
                                    ? null
                                    : const NeverScrollableScrollPhysics(),
                                primary: false,
                                children: [
                                  globalController.userHomePage.ads == null ||
                                          globalController
                                              .userHomePage.ads!.isEmpty
                                      ? Container()
                                      : CarouselSlider(
                                          options: CarouselOptions(
                                            height: 150.0,
                                            aspectRatio: 16 / 9,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            enlargeFactor: 0.2,
                                            onPageChanged: (index, reason) {},
                                            scrollDirection: Axis.horizontal,
                                          ),
                                          items: globalController
                                              .userHomePage.ads!
                                              .map((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    if (i.promotionType == 1) {
                                                      CompanyModel? x =
                                                          await _companiesController
                                                              .showCompany(
                                                                  indicator:
                                                                      true,
                                                                  id: i
                                                                      .companyId!);

                                                      if (x != null) {
                                                        if (x.companyInformation !=
                                                            null) {
                                                          if (x.companyInformation!
                                                                  .companyType ==
                                                              "cleaning") {
                                                            Get.to(
                                                              () => CleaningCompany(
                                                                  cleaningCompany:
                                                                      x),
                                                            );
                                                          } else {
                                                            Get.to(
                                                              () =>
                                                                  RecruitmentCompany(
                                                                      company:
                                                                          x),
                                                            );
                                                          }
                                                        }
                                                      }
                                                    } else {
                                                      Uri x = Uri.parse(
                                                          i.externalLink!);
                                                      await launchUrl(x,
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 100.w,
                                                    height: 56.w,

                                                    // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              i.image!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        // color: Theme.of(context)
                                                        //     .colorScheme
                                                        //     .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                        ),
                                  spaceY(2.0.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      coloredText(
                                        text: globalController
                                            .userHomePage.companiesParant!
                                            .map((e) => Get.locale ==
                                                    const Locale('en', 'US')
                                                ? e.nameEn!
                                                : e.nameAr!)
                                            .toList()[0],
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(
                                          () =>
                                              const RecruitmentCompaniesSearchPage(),
                                        ),
                                        child: coloredText(
                                          text: "all".tr,
                                          fontSize: 13.0.sp,
                                          color: Colors.grey,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  spaceY(1.5.h),
                                  SizedBox(
                                    height: 125.sp,
                                    child:
                                        globalController.userHomePage
                                                        .companiesRecruitment ==
                                                    null ||
                                                globalController
                                                    .userHomePage
                                                    .companiesRecruitment!
                                                    .isEmpty
                                            ? const NoItemsWidget()
                                            : ListView.separated(
                                                physics: completedRegisterFlag
                                                    ? null
                                                    : const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (globalController
                                                              .userHomePage
                                                              .companiesRecruitment![
                                                                  index]
                                                              .companyInformation!
                                                              .busy !=
                                                          1) {
                                                        CompanyModel? x =
                                                            await _companiesController.showCompany(
                                                                indicator: true,
                                                                id: globalController
                                                                    .userHomePage
                                                                    .companiesRecruitment![
                                                                        index]
                                                                    .id!);

                                                        if (x != null) {
                                                          Get.to(
                                                            () =>
                                                                RecruitmentCompany(
                                                                    company: x),
                                                          );
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 40.0.w,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF8F8F8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                width: 60.0.sp,
                                                                height: 60.0.sp,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              NetworkImage("${globalController.userHomePage.companiesRecruitment![index].companyInformation!.companyLogo!}/"),
                                                                        )),
                                                              ),
                                                              if (globalController
                                                                      .userHomePage
                                                                      .companiesRecruitment![
                                                                          index]
                                                                      .companyInformation!
                                                                      .busy ==
                                                                  1)
                                                                Container(
                                                                  width:
                                                                      60.0.sp,
                                                                  height:
                                                                      60.0.sp,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        RotationTransition(
                                                                      turns: const AlwaysStoppedAnimation(
                                                                          15 /
                                                                              360),
                                                                      child:
                                                                          coloredText(
                                                                        text:
                                                                            "busy",
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            15.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          coloredText(
                                                            text: globalController
                                                                        .userHomePage
                                                                        .companiesRecruitment![
                                                                            index]
                                                                        .fullName!
                                                                        .length >
                                                                    12
                                                                ? "${globalController.userHomePage.companiesRecruitment![index].fullName!.substring(0, 12)}.."
                                                                : globalController
                                                                    .userHomePage
                                                                    .companiesRecruitment![
                                                                        index]
                                                                    .fullName!,
                                                            fontSize: 12.0.sp,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                  EvaIcons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                              spaceX(5),
                                                              coloredText(
                                                                text: (globalController.userHomePage.companiesRecruitment![index].reviewCompanySumReviewValue !=
                                                                                null &&
                                                                            globalController.userHomePage.companiesRecruitment![index].reviewCompanyCount !=
                                                                                null
                                                                        ? int.parse(globalController.userHomePage.companiesRecruitment![index].reviewCompanySumReviewValue!) /
                                                                            globalController.userHomePage.companiesRecruitment![index].reviewCompanyCount!
                                                                        : 0)
                                                                    .toStringAsFixed(1),
                                                                fontSize:
                                                                    13.0.sp,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: globalController
                                                    .userHomePage
                                                    .companiesRecruitment!
                                                    .length,
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        spaceX(10),
                                              ),
                                  ),
                                  spaceY(2.0.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      coloredText(
                                        text: globalController
                                            .userHomePage.companiesParant!
                                            .map((e) => Get.locale ==
                                                    const Locale('en', 'US')
                                                ? e.nameEn!
                                                : e.nameAr!)
                                            .toList()[1],
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () =>
                                                const CleaningCompaniesSearchPage(),
                                          );
                                        },
                                        child: coloredText(
                                          text: "all".tr,
                                          fontSize: 13.0.sp,
                                          color: Colors.grey,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  spaceY(1.5.h),
                                  SizedBox(
                                    height: 125.sp,
                                    child:
                                        globalController.userHomePage
                                                        .companiesGeneral ==
                                                    null ||
                                                globalController.userHomePage
                                                    .companiesGeneral!.isEmpty
                                            ? const NoItemsWidget()
                                            : ListView.separated(
                                                physics: completedRegisterFlag
                                                    ? null
                                                    : const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (globalController
                                                              .userHomePage
                                                              .companiesGeneral![
                                                                  index]
                                                              .companyInformation!
                                                              .busy !=
                                                          1) {
                                                        CompanyModel? x =
                                                            await _companiesController.showCompany(
                                                                indicator: true,
                                                                id: globalController
                                                                    .userHomePage
                                                                    .companiesGeneral![
                                                                        index]
                                                                    .id!);

                                                        if (x != null) {
                                                          if (x.companyInformation !=
                                                              null) {
                                                            logSuccess(x
                                                                .companyInformation!
                                                                .companyType!);
                                                            if (x.companyInformation!
                                                                    .companyType ==
                                                                "recruitment") {
                                                              Get.to(
                                                                () =>
                                                                    RecruitmentCompany(
                                                                        company:
                                                                            x),
                                                              );
                                                            } else {
                                                              Get.to(
                                                                () => CleaningCompany(
                                                                    cleaningCompany:
                                                                        x),
                                                              );
                                                            }
                                                          }
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 40.0.w,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF8F8F8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                width: 60.0.sp,
                                                                height: 60.0.sp,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage("${globalController.userHomePage.companiesGeneral![index].companyInformation!.companyLogo!}"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                              ),
                                                              if (globalController
                                                                      .userHomePage
                                                                      .companiesGeneral![
                                                                          index]
                                                                      .companyInformation!
                                                                      .busy ==
                                                                  1)
                                                                Container(
                                                                  width:
                                                                      60.0.sp,
                                                                  height:
                                                                      60.0.sp,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        RotationTransition(
                                                                      turns: const AlwaysStoppedAnimation(
                                                                          15 /
                                                                              360),
                                                                      child:
                                                                          coloredText(
                                                                        text:
                                                                            "busy",
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            15.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          coloredText(
                                                            text: globalController
                                                                        .userHomePage
                                                                        .companiesGeneral![
                                                                            index]
                                                                        .fullName!
                                                                        .length >
                                                                    12
                                                                ? "${globalController.userHomePage.companiesGeneral![index].fullName!.substring(0, 12)}.."
                                                                : globalController
                                                                    .userHomePage
                                                                    .companiesGeneral![
                                                                        index]
                                                                    .fullName!,
                                                            fontSize: 13.0.sp,
                                                          ),
                                                          coloredText(
                                                              text: globalController
                                                                  .userHomePage
                                                                  .companiesGeneral![
                                                                      index]
                                                                  .companyInformation!
                                                                  .companyType!,
                                                              fontSize: 11.0.sp,
                                                              color:
                                                                  Colors.grey),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                  EvaIcons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                              spaceX(5),
                                                              coloredText(
                                                                text: (globalController.userHomePage.companiesGeneral![index].reviewCompanySumReviewValue !=
                                                                                null &&
                                                                            globalController.userHomePage.companiesGeneral![index].reviewCompanyCount !=
                                                                                null
                                                                        ? int.parse(globalController.userHomePage.companiesGeneral![index].reviewCompanySumReviewValue!) /
                                                                            globalController.userHomePage.companiesGeneral![index].reviewCompanyCount!
                                                                        : 0)
                                                                    .toStringAsFixed(1),
                                                                fontSize:
                                                                    13.0.sp,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: globalController
                                                    .userHomePage
                                                    .companiesGeneral!
                                                    .length,
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        spaceX(10),
                                              ),
                                  ),
                                  spaceY(2.0.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      coloredText(
                                        text: "employees".tr,
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(
                                          () => const EmployeesSearchPage(),
                                        ),
                                        child: coloredText(
                                          text: "all".tr,
                                          fontSize: 13.0.sp,
                                          color: Colors.grey,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  spaceY(2.0.h),
                                  SizedBox(
                                    height: 120.sp,
                                    child: globalController
                                                    .userHomePage.employees ==
                                                null ||
                                            globalController
                                                .userHomePage.employees!.isEmpty
                                        ? const NoItemsWidget()
                                        : ListView.separated(
                                            physics: completedRegisterFlag
                                                ? null
                                                : const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  EmployeeModel? em =
                                                      await _employeesController
                                                          .showEmployee(
                                                              id: globalController
                                                                  .userHomePage
                                                                  .employees![
                                                                      index]
                                                                  .id!,
                                                              indicator: true);
                                                  if (em != null) {
                                                    Get.to(
                                                      () => EmployeePage(
                                                          employeeModel: em),
                                                    );
                                                  }
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 25.0.w,
                                                      height: 25.0.w,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${globalController.userHomePage.employees![index].image}/"),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    spaceY(5.sp),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .only(
                                                                  start: 2),
                                                          child: Get.locale ==
                                                                  const Locale(
                                                                      'en',
                                                                      'uS')
                                                              ? coloredText(
                                                                  text: globalController.userHomePage.employees![index].nameEn!.length >
                                                                          12
                                                                      ? "${globalController.userHomePage.employees![index].nameEn!.substring(0, 12)}.."
                                                                      : globalController
                                                                          .userHomePage
                                                                          .employees![
                                                                              index]
                                                                          .nameEn!,
                                                                  fontSize:
                                                                      13.0.sp)
                                                              : coloredText(
                                                                  text: globalController.userHomePage.employees![index].nameAr!.length >
                                                                          12
                                                                      ? "${globalController.userHomePage.employees![index].nameAr!.substring(0, 12)}.."
                                                                      : globalController
                                                                          .userHomePage
                                                                          .employees![
                                                                              index]
                                                                          .nameAr!,
                                                                  fontSize:
                                                                      13.0.sp),
                                                        ),
                                                        spaceY(2),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              EvaIcons.pin,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              size: 13.0.sp,
                                                            ),
                                                            spaceX(3),
                                                            coloredText(
                                                              text: Get.locale ==
                                                                      const Locale(
                                                                          'en',
                                                                          'US')
                                                                  ? globalController
                                                                      .userHomePage
                                                                      .employees![
                                                                          index]
                                                                      .nationality!
                                                                      .nameEn!
                                                                  : globalController
                                                                      .userHomePage
                                                                      .employees![
                                                                          index]
                                                                      .nationality!
                                                                      .nameAr!,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              fontSize: 12.0.sp,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount: globalController
                                                .userHomePage.employees!.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    spaceX(20),
                                          ),
                                  ),
                                  spaceY(3.0.h)
                                ],
                              ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !completedRegisterFlag,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  width: 100.0.w,
                  height: 100.0.h,
                ),
              ),
            ),
            Visibility(
              visible: !completedRegisterFlag,
              child: Material(
                color: Colors.transparent,
                elevation: 15,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(50.0.w, 30),
                  bottomRight: Radius.elliptical(50.0.w, 30),
                ),
                child: ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Stack(
                    children: [
                      Container(
                        width: 100.0.w,
                        height: _currentStep == 1
                            ? h2
                            : _currentStep == 2
                                ? h3
                                : h,
                        color: Colors.white,
                        // duration: const const Duration(milliseconds: 250),
                        child: Column(
                          children: [
                            spaceY(100),
                            EasyStepper(
                              activeStep: _currentStep,
                              lineLength: 30.0.w,
                              lineSpace: 0,
                              lineType: LineType.normal,
                              defaultLineColor: Colors.grey,

                              finishedLineColor:
                                  Theme.of(context).colorScheme.tertiary,
                              activeStepTextColor:
                                  Theme.of(context).colorScheme.tertiary,
                              finishedStepTextColor: Colors.transparent,
                              internalPadding: 0,
                              showLoadingAnimation: false,
                              stepRadius: 10,
                              showStepBorder: false,
                              lineThickness: 0.7,
                              alignment: Alignment.topCenter,
                              disableScroll: true,
                              fitWidth: true,
                              steps: stepList(),
                              // onStepReached: (index) =>
                              //     setState(() => _currentStep = index),
                            ),
                            Expanded(
                              child: Form(
                                child: PageView(
                                  controller: pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: pageList,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PositionedDirectional(
                        top: 40,
                        start: 30,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentStep == 2) {
                              _currentStep -= 1;
                              setState(() {});
                              pageController.jumpToPage(_currentStep);
                            } else if (_currentStep == 0) {
                              Get.back();
                              setState(() {});
                            } else {
                              _currentStep -= 1;
                              pageController.jumpToPage(_currentStep);
                              setState(() {});
                            }
                            logSuccess(_currentStep);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.primary,
                            size: 22.0.sp,
                          ),
                        ),
                      ),
                      Positioned.fill(
                          top: 40,
                          child: Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: coloredText(
                              text: "complete_data".tr,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> get pageList => [
        Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(padding: EdgeInsets.zero, primary: false, children: [
            UnderlinedCustomTextField(
              focusNode: _focusNodes[2],
              controller: _phoneNumberController,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              onchanged: (s) {
                errors['phone'] = null;
                setState(() {});
                userCompleteData.phone = s!;
              },
              validator: (String? value) {
                if (errors['phone'] != null) {
                  String tmp = "";
                  tmp = errors['phone'].join("\n");

                  return tmp;
                } else if (value!.length < 7 && value.isNotEmpty) {
                  return "phone must be 7 numbers at least";
                }
                return null;
              },
              prefixIcon: Container(
                margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      EvaIcons.phoneOutline,
                      size: 20.0.sp,
                    ),
                    spaceX(5.sp),
                    coloredText(text: "+965", color: Colors.grey)
                    // GetBuilder<GlobalController>(builder: (c) {
                    //   return CustomDropDownMenuButton(
                    //     width: 65.sp,
                    //     hintPadding: 5,
                    //     hintSize: 13,
                    //     value: phoneCode == "" ? null : phoneCode,
                    //     items: c.countries
                    //         .map((e) => DropdownMenuItem<String>(
                    //               value: e.code!,
                    //               child: coloredText(
                    //                 text: e.code!,
                    //                 fontSize: 17,
                    //               ),
                    //             ))
                    //         .toList(),
                    //     onChanged: (s) {
                    //       phoneCode = s!;
                    //     },
                    //   );
                    // }),
                  ],
                ),
              ),
              hintText: "phone_number".tr,
              // validator: (String? value) =>
              //     EmailValidator.validate(value!)
              //         ? null
              //         : "please_enter_a_valid_email".tr,
            ),
            spaceY(10.0.sp),
            UnderlinedCustomTextField(
              focusNode: _focusNodes[4],
              controller: _jobNameController,
              keyBoardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.always,

              prefixIcon: Icon(
                EvaIcons.briefcaseOutline,
                size: 20.0.sp,
              ),
              onchanged: (s) {
                errors['job_name'] = null;
                setState(() {});
                userCompleteData.jobName = s;
              },
              validator: (String? value) {
                if (errors['job_name'] != null) {
                  String tmp = "";
                  tmp = errors['job_name'].join("\n");

                  return tmp;
                }
                return null;
              },
              hintText: "job".tr,
              // validator: (String? value) =>
              //     EmailValidator.validate(value!)
              //         ? null
              //         : "please_enter_a_valid_email".tr,
            ),
            spaceY(20.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                coloredText(
                    text: "next".tr,
                    fontSize: 16.0.sp,
                    color: Theme.of(context).colorScheme.tertiary),
                spaceX(10),
                GestureDetector(
                  onTap: () {
                    if (_currentStep < stepList().length - 1) {
                      setState(() => _currentStep += 1);
                      pageController.jumpToPage(_currentStep);
                    } else {
                      completedRegisterFlag = true;
                    }

                    logSuccess(_currentStep);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(
                          Get.locale == const Locale('en', 'US') ? 0 : math.pi),
                      child: const Icon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            spaceY(20.0.sp),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
              primary: false,
              padding: const EdgeInsets.all(0),
              children: [
                GetBuilder<GlobalController>(builder: (c) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //todo:langs needs to be fixed
                      CustomDropDownMenuButton(
                        hint: "city".tr,
                        value: city == "" ? null : city,
                        hintPadding: 0,
                        border: const UnderlineInputBorder(),
                        width: 40.0.w,
                        items: c.cities
                            .map((e) => DropdownMenuItem<String>(
                                  value: e.nameEn,
                                  child: coloredText(
                                    text: e.nameEn!,
                                    fontSize: 17,
                                  ),
                                ))
                            .toList(),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (String? value) {
                          if (errors['city_id'] != null) {
                            String tmp = "";
                            tmp = errors['city_id'].join("\n");

                            return tmp;
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          city = p0!;
                          errors["city_id"] = null;
                          setState(() {});
                          userCompleteData.cityId = c.cities
                              .where((element) =>
                                  element.nameEn == p0 || element.nameAr == p0)
                              .first
                              .id
                              .toString();
                        },
                      ),
                      //todo:langs need to be fixed
                      CustomDropDownMenuButton(
                        hint: "region".tr,
                        border: const UnderlineInputBorder(),
                        width: 40.0.w,
                        value: region == "" ? null : region,
                        items: c.regions
                            .map((e) => DropdownMenuItem<String>(
                                  value: e.nameEn,
                                  child: coloredText(
                                    text: e.nameEn!,
                                    fontSize: 17,
                                  ),
                                ))
                            .toList(),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (String? value) {
                          if (errors['region_id'] != null) {
                            String tmp = "";
                            tmp = errors['region_id'].join("\n");

                            return tmp;
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          region = p0!;
                          errors["region_id"] = null;
                          setState(() {});
                          userCompleteData.regionId = c.regions
                              .where((element) =>
                                  element.nameEn == p0 || element.nameAr == p0)
                              .first
                              .id
                              .toString();
                          ;
                        },
                      ),
                    ],
                  );
                }),
                spaceY(10.0.sp),
                UnderlinedCustomTextField(
                  focusNode: _focusNodes[5],
                  controller: _pieceNumberController,
                  keyBoardType: TextInputType.number,
                  // prefixIcon: const Icon(Icons.email_outlined),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (String? value) {
                    if (errors['piece_number'] != null) {
                      String tmp = "";
                      tmp = errors['piece_number'].join("\n");

                      return tmp;
                    }
                    return null;
                  },
                  onchanged: (s) {
                    errors["piece_number"] = null;
                    setState(() {});
                    userCompleteData.pieceNumber = s;
                  },
                  hintText: "piece_num".tr,
                  // validator: (String? value) =>
                  //     EmailValidator.validate(value!)
                  //         ? null
                  //         : "please_enter_a_valid_email".tr,
                ),
                spaceY(10.0.sp),
                UnderlinedCustomTextField(
                  focusNode: _focusNodes[6],
                  controller: _streetController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (String? value) {
                    if (errors['street'] != null) {
                      String tmp = "";
                      tmp = errors['street'].join("\n");

                      return tmp;
                    }
                    return null;
                  },
                  onchanged: (s) {
                    errors["street"] = null;
                    setState(() {});
                    userCompleteData.street = s;
                  },
                  keyBoardType: TextInputType.text,
                  // prefixIcon: const Icon(Icons.email_outlined),
                  hintText: "street".tr,
                  // validator: (String? value) =>
                  //     EmailValidator.validate(value!)
                  //         ? null
                  //         : "please_enter_a_valid_email".tr,
                ),
                spaceY(10.0.sp),
                UnderlinedCustomTextField(
                  focusNode: _focusNodes[7],
                  controller: _buildingController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (String? value) {
                    if (errors['building'] != null) {
                      String tmp = "";
                      tmp = errors['building'].join("\n");

                      return tmp;
                    }
                    return null;
                  },
                  onchanged: (s) {
                    errors["building"] = null;
                    setState(() {});
                    userCompleteData.building = s;
                  },
                  keyBoardType: TextInputType.text,
                  // prefixIcon: const Icon(Icons.email_outlined),
                  hintText: "building".tr,
                  // validator: (String? value) =>
                  //     EmailValidator.validate(value!)
                  //         ? null
                  //         : "please_enter_a_valid_email".tr,
                ),
                spaceY(10.0.sp),
                UnderlinedCustomTextField(
                  focusNode: _focusNodes[8],
                  controller: _adnController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (String? value) {
                    if (errors['automated_address_number'] != null) {
                      String tmp = "";
                      tmp = errors['automated_address_number'].join("\n");

                      return tmp;
                    }
                    return null;
                  },
                  onchanged: (s) {
                    errors["automated_address_number"] = null;
                    setState(() {});
                    userCompleteData.automatedAddressNumber = s;
                  },
                  keyBoardType: TextInputType.number,
                  // prefixIcon: const Icon(Icons.email_outlined),
                  hintText: "adn".tr,
                  // validator: (String? value) =>
                  //     EmailValidator.validate(value!)
                  //         ? null
                  //         : "please_enter_a_valid_email".tr,
                ),
                spaceY(20.0.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    coloredText(
                        text: "next".tr,
                        fontSize: 16.0.sp,
                        color: Theme.of(context).colorScheme.tertiary),
                    spaceX(10),
                    GestureDetector(
                      onTap: () {
                        if (_currentStep < stepList().length - 1) {
                          setState(() => _currentStep += 1);
                          pageController.jumpToPage(_currentStep);
                        } else {
                          completedRegisterFlag = true;
                        }

                        logSuccess(_currentStep);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                        ),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(
                              Get.locale == const Locale('en', 'US')
                                  ? 0
                                  : math.pi),
                          child: const Icon(
                            FontAwesomeIcons.anglesRight,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                spaceY(20.0.sp),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(primary: false, padding: EdgeInsets.zero, children: [
            UnderlinedCustomTextField(
              focusNode: _focusNodes[9],
              controller: _idNumController,
              keyBoardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (errors['id_number_nationality'] != null) {
                  String tmp = "";
                  tmp = errors['id_number_nationality'].join("\n");

                  return tmp;
                }
                return null;
              },
              onchanged: (s) {
                errors["id_number_nationality"] = null;
                setState(() {});
                userCompleteData.idNumberNationality = s;
              },
              // prefixIcon: const Icon(Icons.email_outlined),
              hintText: "id_number".tr,
              // validator: (String? value) =>
              //     EmailValidator.validate(value!)
              //         ? null
              //         : "please_enter_a_valid_email".tr,
            ),
            spaceY(25.0.sp),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () async {
                  XFile? image = await Utils().selectImageSheet();

                  if (image != null) {
                    button1Text =
                        image.name.substring(0, min(15, image.name.length));
                    userCompleteData.idPhotoNationality = image;
                    setState(() {});
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.13),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.upload,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 13.0.sp,
                      ),
                      spaceX(10.0.sp),
                      coloredText(
                          text: button1Text,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 13.0.sp)
                    ],
                  ),
                ),
              ),
            ),
            spaceY(20.0.sp),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () async {
                  XFile? image = await Utils().selectImageSheet();

                  if (image != null) {
                    button2Text =
                        image.name.substring(0, min(25, image.name.length));
                    userCompleteData.personalPhoto = image;
                    setState(() {});
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.upload,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 13.0.sp,
                      ),
                      spaceX(10.0.sp),
                      coloredText(
                          text: button2Text,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 13.0.sp)
                    ],
                  ),
                ),
              ),
            ),
            spaceY(20.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                coloredText(
                    text: "next".tr,
                    fontSize: 16.0.sp,
                    color: Theme.of(context).colorScheme.tertiary),
                spaceX(10),
                GestureDetector(
                  onTap: () async {
                    if (_currentStep < stepList().length - 1) {
                      setState(() => _currentStep += 1);
                      pageController.jumpToPage(_currentStep);
                    } else {
                      // completedRegisterFlag = true;

                      FocusScope.of(context).unfocus();
                      // userRegisterData.phone ??= "";
                      userCompleteData.phone = _phoneNumberController.text;
                      var x = await _authController.usercompleteData(
                          userCompleteData: userCompleteData);

                      if (x == true) {
                        // ignore: use_build_context_synchronously
                        Utils.customDialog(
                            actions: [
                              primaryButton(
                                onTap: () {
                                  Get.back();
                                  completedRegisterFlag = true;
                                  Restart.restartApp();

                                  setState(() {});
                                },
                                width: 40.0.w,
                                height: 50,
                                radius: 10.w,
                                color: Theme.of(context).colorScheme.primary,
                                text: coloredText(
                                  text: "ok".tr,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            context: context,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  spaceY(20),
                                  Icon(
                                    EvaIcons.checkmarkCircle,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 40.sp,
                                  ),
                                  spaceY(20),
                                  coloredText(
                                      text: "your_data_have_been_completed".tr,
                                      fontSize: 12.0.sp),
                                  coloredText(
                                    text: "successfully".tr,
                                    fontSize: 14.0.sp,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ));
                      } else if (x['message'] ==
                          "The given data was invalid.") {
                        errors = x['errors'];
                        if (errors['full_name'] != null ||
                            errors['phone'] != null ||
                            errors['email'] != null ||
                            errors['jon_name'] != null ||
                            errors['nationality_id'] != null) {
                          setState(() => _currentStep = 0);
                          pageController.jumpToPage(_currentStep);
                        } else if (errors['city_id'] != null ||
                            errors['region_id'] != null ||
                            errors['piece_number'] != null ||
                            errors['street'] != null ||
                            errors['building'] != null ||
                            errors['automated_address_number'] != null) {
                          setState(() => _currentStep = 1);
                          pageController.jumpToPage(_currentStep);
                        } else if (errors['id_number_nationality'] != null ||
                            errors['refrence_number'] != null ||
                            errors['id_photo_nationality'] != null ||
                            errors['personal_photo'] != null) {
                          setState(() => _currentStep = 2);
                          pageController.jumpToPage(_currentStep);
                          String tmp = "";
                          if (errors['id_photo_nationality'] != null &&
                              errors['personal_photo'] != null) {
                            tmp = errors['id_photo_nationality'].join("\n") +
                                "\n" +
                                errors['personal_photo'].join("\n");
                            Utils.showSnackBar(message: tmp, fontSize: 12.0.sp);
                          } else if (errors['id_photo_nationality'] != null) {
                            tmp = errors['id_photo_nationality'].join("\n");
                            Utils.showSnackBar(message: tmp, fontSize: 12.0.sp);
                          } else if (errors['personal_photo'] != null) {
                            tmp = errors['personal_photo'].join("\n");
                            Utils.showSnackBar(message: tmp, fontSize: 12.0.sp);
                          }
                        }
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(
                          Get.locale == const Locale('en', 'US') ? 0 : math.pi),
                      child: const Icon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            spaceY(20.0.sp),
          ]),
        ),
      ];
  List<EasyStep> stepList() => [
        EasyStep(
          customStep: CircleAvatar(
            radius: 10,
            backgroundColor: _currentStep >= 0
                ? Theme.of(context).colorScheme.tertiary
                : Colors.grey,
            child: const CircleAvatar(
              radius: 3,
              backgroundColor: Colors.white,
            ),
          ),
          title: _currentStep == 0 ? "personal_info".tr : "",
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 10,
            backgroundColor: _currentStep >= 1
                ? Theme.of(context).colorScheme.tertiary
                : Colors.grey,
            child: const CircleAvatar(
              radius: 3,
              backgroundColor: Colors.white,
            ),
          ),
          title: _currentStep == 1 ? 'address_info'.tr : "",
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 10,
            backgroundColor: _currentStep >= 2
                ? Theme.of(context).colorScheme.tertiary
                : Colors.grey,
            child: const CircleAvatar(
              radius: 3,
              backgroundColor: Colors.white,
            ),
          ),
          title: _currentStep == 2 ? 'id_proof'.tr : "",
        ),
      ];
}
