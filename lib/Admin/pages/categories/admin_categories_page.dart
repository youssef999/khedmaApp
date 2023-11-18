import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Admin/pages/categories/controller/categories_controller.dart';
import 'package:khedma/Admin/pages/categories/create_job_page.dart';
import 'package:khedma/Admin/pages/categories/create_service_page.dart';
import 'package:khedma/Admin/pages/jobs/controller/jobs_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class AdminCategoriesPage extends StatefulWidget {
  const AdminCategoriesPage({super.key});

  @override
  State<AdminCategoriesPage> createState() => _AdminCategoriesPageState();
}

class _AdminCategoriesPageState extends State<AdminCategoriesPage>
    with SingleTickerProviderStateMixin {
  List<String> tabs = [
    "jobs".tr,
    "services".tr,
  ];
  late TabController tabController;
  int selectedTabIndex = 0;
  CompanyTypesController _companyTypesController = Get.find();
  GlobalController _globalController = Get.find();
  String companyType = "";
  String search = "";
  late int companyTypeId;
  @override
  void initState() {
    _globalController.getCategories();
    _globalController.getjobs();
    tabController = TabController(length: 2, vsync: this);
    companyType = _companyTypesController.companyTypes
        .map((e) =>
            Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
        .first;
    companyTypeId = _companyTypesController.companyTypes[0].id!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Theme(
        data: ThemeData(
          useMaterial3: false,
        ),
        child: FloatingActionButton(
          onPressed: () {
            if (selectedTabIndex == 0) {
              Get.to(
                () => const AdminCreateJob(),
              );
            } else {
              Get.to(
                () => const AdminCreateService(),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: AlignmentDirectional.bottomStart,
                end: AlignmentDirectional.topEnd,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
            ),
            width: 60,
            height: 60,
            child: const Icon(
              EvaIcons.plus,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                    text: "categories".tr,
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
                child: Column(
                  children: [
                    TabBar(
                        dividerColor: Colors.grey,
                        // indicatorColor: Colors.black,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        )),
                        indicatorSize: TabBarIndicatorSize.tab,

                        // isScrollable: true,
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
                    spaceY(10.sp),
                    Expanded(
                      child: TabBarView(
                          controller: tabController, children: tabList),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get tabList => [
        GetBuilder<GlobalController>(builder: (globalController) {
          return Column(
            children: [
              SearchTextField(
                onchanged: (s) {
                  if (s != null) {
                    globalController.handleJobsSearch(name: s);
                    setState(() {});
                  }
                },
                hintText: "${'search'.tr} ...",
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
                // suffixIcon: GestureDetector(
                //   onTap: () {
                //     // FocusScope.of(context).unfocus();
                //     // Get.to(
                //     //   () => const EmployeesFilterPage(),
                //     // );
                //   },
                //   child: const Image(
                //     width: 15,
                //     height: 15,
                //     image: AssetImage("assets/images/filter-icon.png"),
                //   ),
                // ),
              ),
              spaceY(10.sp),
              // primaryBorderedButton(
              //     onTap: () {
              //       Get.to(
              //         () => const AdminCreateJob(),
              //       );
              //     },
              //     width: 100.w,
              //     text: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(EvaIcons.plus, color: Colors.black, size: 20.sp),
              //         spaceX(10.sp),
              //         coloredText(text: "create_new".tr),
              //       ],
              //     ),
              //     color: Colors.black),
              // spaceY(30.sp),
              Expanded(
                child: GetBuilder<JobsController>(builder: (c) {
                  return globalController.getjobsFlag
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => AdminItemCard(
                            img: globalController.jobsToShow[index].icon,
                            name:
                                "${globalController.jobsToShow[index].nameEn!} - ${globalController.jobsToShow[index].nameAr!}",
                            trailing: Theme(
                              data: ThemeData(primaryColor: Colors.white),
                              child: PopupMenuButton(
                                constraints: BoxConstraints(
                                  minWidth: 2.0 * 56.0,
                                  maxWidth: MediaQuery.of(context).size.width,
                                ),
                                itemBuilder: (BuildContext cc) => [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Row(
                                      children: [
                                        Icon(EvaIcons.editOutline, size: 15.sp),
                                        spaceX(5.sp),
                                        coloredText(
                                            text: 'edit'.tr, fontSize: 12.0.sp),
                                      ],
                                    ),
                                    onTap: () {
                                      Future(() => Get.to(() => AdminCreateJob(
                                            jobToEdit: globalController
                                                .jobsToShow[index],
                                          )));
                                    },
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Icon(EvaIcons.trash2Outline,
                                            size: 15.sp),
                                        spaceX(5.sp),
                                        coloredText(
                                            text: 'delete'.tr,
                                            fontSize: 12.0.sp),
                                      ],
                                    ),
                                    onTap: () async {
                                      bool b = await c.deleteJob(
                                          job: globalController
                                              .jobsToShow[index]);
                                      if (b) Utils.doneDialog(context: context);
                                    },
                                  ),
                                ],
                                child: const Icon(
                                  EvaIcons.moreVertical,
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => spaceY(20.sp),
                          itemCount: globalController.jobsToShow.length,
                        );
                }),
              ),
            ],
          );
        }),
        GetBuilder<GlobalController>(builder: (globalController) {
          return Column(
            children: [
              SearchTextField(
                onchanged: (s) {
                  if (s != null) {
                    search = s;
                    globalController.handleCategoriesSearch(
                      name: search,
                      typeId: companyTypeId,
                    );
                    setState(() {});
                  }
                },
                hintText: "${'search'.tr} ...",
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Color(0xffAFAFAF),
                ),
                // suffixIcon: GestureDetector(
                //   onTap: () {
                //     // FocusScope.of(context).unfocus();
                //     // Get.to(
                //     //   () => const EmployeesFilterPage(),
                //     // );
                //   },
                //   child: const Image(
                //     width: 15,
                //     height: 15,
                //     image: AssetImage("assets/images/filter-icon.png"),
                //   ),
                // ),
              ),
              spaceY(15.sp),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CustomDropDownMenuButton(
                  width: 50.w,
                  items: _companyTypesController.companyTypes
                      .map((e) => Get.locale == const Locale('en', 'US')
                          ? e.nameEn!
                          : e.nameAr!)
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: coloredText(
                              text: e, color: Colors.black, fontSize: 11.sp),
                        ),
                      )
                      .toList(),
                  onChanged: (p0) {
                    companyType = p0!;
                    companyTypeId = _companyTypesController.companyTypes
                        .where((element) =>
                            element.nameAr == p0 || element.nameEn == p0)
                        .first
                        .id!;

                    globalController.handleCategoriesSearch(
                      name: search,
                      typeId: companyTypeId,
                    );
                    setState(() {});
                    // globalController.accountStatmentFilter.status = p0;
                  },
                  value: companyType == "" ? null : companyType,
                  borderc: Border.all(color: const Color(0xffE3E3E3)),
                  borderRadius: BorderRadius.circular(8),
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10),
                ),
              ),

              spaceY(15.sp),
              // primaryBorderedButton(
              //     onTap: () {
              //       Get.to(
              //         () => const AdminCreateService(),
              //       );
              //     },
              //     width: 100.w,
              //     text: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(EvaIcons.plus, color: Colors.black, size: 20.sp),
              //         spaceX(10.sp),
              //         coloredText(text: "create_new".tr),
              //       ],
              //     ),
              //     color: Colors.black),
              // // spaceY(30.sp),
              Expanded(
                child: GetBuilder<CategoriesController>(builder: (c) {
                  return globalController.getCategoriesFlag
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.count(
                          // physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 0.75,
                          padding: EdgeInsets.zero,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: List.generate(
                              globalController.categoriesToShow.length,
                              (index) => Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 45.w,
                                            height: 45.w,
                                            // margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      globalController
                                                          .categoriesToShow[
                                                              index]
                                                          .image),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Theme(
                                                data: ThemeData(
                                                    primaryColor: Colors.white),
                                                child: PopupMenuButton(
                                                  constraints: BoxConstraints(
                                                    minWidth: 2.0 * 56.0,
                                                    maxWidth: 100.w,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext ctx) => [
                                                    PopupMenuItem<int>(
                                                      value: 0,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              EvaIcons
                                                                  .editOutline,
                                                              size: 15.sp),
                                                          spaceX(5.sp),
                                                          coloredText(
                                                              text: 'edit'.tr,
                                                              fontSize:
                                                                  12.0.sp),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        Future(() => Get.to(() =>
                                                            AdminCreateService(
                                                              categoryToEdit:
                                                                  globalController
                                                                          .categoriesToShow[
                                                                      index],
                                                            )));
                                                      },
                                                    ),
                                                    PopupMenuItem<int>(
                                                      value: 1,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              EvaIcons
                                                                  .trash2Outline,
                                                              size: 15.sp),
                                                          spaceX(5.sp),
                                                          coloredText(
                                                              text: 'delete'.tr,
                                                              fontSize:
                                                                  12.0.sp),
                                                        ],
                                                      ),
                                                      onTap: () async {
                                                        bool b = await c.deleteCategory(
                                                            category:
                                                                globalController
                                                                        .categoriesToShow[
                                                                    index]);
                                                        if (b)
                                                          Utils.doneDialog(
                                                              context:
                                                                  Get.context!);
                                                      },
                                                    ),
                                                  ],
                                                  child: const Icon(
                                                    EvaIcons.moreVertical,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      spaceY(10.sp),
                                      coloredText(
                                          text: Get.locale ==
                                                  const Locale('en', 'US')
                                              ? globalController
                                                  .categoriesToShow[index]
                                                  .nameEn!
                                              : globalController
                                                  .categoriesToShow[index]
                                                  .nameAr!)
                                    ],
                                  )),
                        );
                }),
              )
            ],
          );
        }),
      ];
}

// ignore: must_be_immutable
class AdminItemCard extends StatelessWidget {
  AdminItemCard({
    super.key,
    this.img,
    required this.name,
    this.margin,
    this.trailing,
    this.noIcon = false,
  });
  final String? img;
  bool noIcon = false;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: margin,
      decoration: BoxDecoration(
          color: const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          img != null
              ? SizedBox(
                  width: 30.sp,
                  height: 30.sp,
                  child: Image(
                    image: NetworkImage(img!),
                    width: 30.sp,
                    height: 30.sp,
                  ),
                )
              : noIcon
                  ? Container()
                  : Icon(
                      Icons.place,
                      size: 25.sp,
                    ),
          spaceX(10.sp),
          SizedBox(
            width: 60.w,
            child: coloredText(
              overflow: TextOverflow.ellipsis,
              text: name,
              fontSize: 12.0.sp,
            ),
          ),
          const Spacer(),
          trailing != null ? trailing! : Container(),
        ],
      ),
    );
  }
}
