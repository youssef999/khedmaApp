import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/pages/Addressess/controller/addressess_controller.dart';
import 'package:khedma/Admin/pages/Addressess/country_create_page.dart';
import 'package:khedma/Admin/pages/categories/admin_categories_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/city.dart';
import 'package:khedma/models/country.dart';
import 'package:khedma/models/region.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class AdminAddressesPage extends StatefulWidget {
  const AdminAddressesPage({super.key});

  @override
  State<AdminAddressesPage> createState() => _AdminAddressesPageState();
}

class _AdminAddressesPageState extends State<AdminAddressesPage>
    with SingleTickerProviderStateMixin {
  // GlobalController _globalController = Get.find();
  // AddressessController _adressControllerController = Get.find();
  List<String> tabs = [
    "countries",
    "cities",
    "regions",
  ];
  String searchText = "";
  int countryId = -1;
  late TabController tabController;
  int selectedTabIndex = 0;
  final GlobalController _globalController = Get.find();
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _globalController.getCountries();
    _globalController.getCities();
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
              Get.to(() => const AdminCreateCountry());
            } else {
              City city = City();
              int cId = 1;
              Utils.showDialogBox(
                context: context,
                actions: [
                  GetBuilder<AddressessController>(
                      builder: (addressessController) {
                    return primaryButton(
                      onTap: () async {
                        Get.back();
                        bool b = await addressessController.createCity(
                            city: city, countryId: cId);
                        // ignore: use_build_context_synchronously
                        if (b) Utils.doneDialog(context: context);
                      },
                      color: Colors.black,
                      width: 50.w,
                      height: 40.sp,
                      text: coloredText(text: "create".tr, color: Colors.white),
                    );
                  }),
                ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coloredText(text: "name_ar".tr),
                    spaceY(5.sp),
                    SizedBox(
                      height: 35.sp,
                      child: TextFormField(
                        // maxLines: 1,
                        initialValue: city.nameAr,
                        onChanged: (value) {
                          city.nameAr = value;
                        },
                        decoration: const InputDecoration(
                          // hintText: "write_your_notes".tr,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    coloredText(text: "name_en".tr),
                    spaceY(5.sp),
                    SizedBox(
                      height: 35.sp,
                      child: TextFormField(
                        // maxLines: 1,
                        initialValue: city.nameEn,
                        onChanged: (value) {
                          city.nameEn = value;
                        },
                        decoration: const InputDecoration(
                          // hintText: "write_your_notes".tr,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    coloredText(text: "country".tr),
                    spaceY(5.sp),
                    CustomDropDownMenuButtonV2(
                      filled: true,
                      focusNode: FocusNode(),
                      fillColor: Color(0xffF5F5F5),
                      borderRadius: 10,
                      width: 70.sp,
                      value: Get.locale == const Locale('en', 'US')
                          ? _globalController.countries[0].nameEn
                          : _globalController.countries[0].nameAr,
                      items: _globalController.countries
                          .map((e) => Get.locale == const Locale('en', 'US')
                              ? e.nameEn!
                              : e.nameAr!)
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (p0) {
                        cId = _globalController.countries
                            .where((element) =>
                                element.nameAr == p0 || element.nameEn == p0)
                            .single
                            .id!;
                      },
                    )
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        EvaIcons.close,
                      ),
                    )
                  ],
                ),
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
                    text: "addresses".tr,
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
                child: GetBuilder<GlobalController>(builder: (c) {
                  return Column(
                    children: [
                      SearchTextField(
                        onchanged: (s) async {
                          if (s != null) {
                            logSuccess(countryId);
                            c.handleCitySearch(
                              name: s,
                            );

                            c.handleCountrySearch(name: s);
                            searchText = s;
                          }
                        },
                        hintText: "${"search".tr} ...",
                        prefixIcon: const Icon(
                          EvaIcons.search,
                          color: Color(0xffAFAFAF),
                        ),
                        // suffixIcon: selectedTabIndex == 0
                        //     ? null
                        //     : CustomDropDownMenuButton(
                        //         width: 70.sp,
                        //         value: "all_cities".tr,
                        //         items: [
                        //           'all_cities'.tr,
                        //           ..._globalController.countries.map((e) =>
                        //               Get.locale == const Locale('en', 'US')
                        //                   ? e.nameEn!
                        //                   : e.nameAr!)
                        //         ]
                        //             .map(
                        //               (e) => DropdownMenuItem(
                        //                 value: e,
                        //                 child: Text(e),
                        //               ),
                        //             )
                        //             .toList(),
                        //         onChanged: (p0) {
                        //           if (p0 == "all_cities".tr) {
                        //             countryId = -1;
                        //           } else {
                        //             countryId = c.countries
                        //                 .where((element) =>
                        //                     element.nameAr == p0 ||
                        //                     element.nameEn == p0)
                        //                 .single
                        //                 .id!;
                        //           }
                        //           c.handleCitySearch(
                        //             name: searchText,
                        //           );
                        //         },
                        //       )),
                      ),
                      spaceY(10.sp),

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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: coloredText(
                                    fontSize: 11.sp,
                                    text: tabs[index].tr,
                                    color: selectedTabIndex == index
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            ),
                          )),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          tab2(),
                          tab1(),
                          // tab3(),
                        ],
                      )),

                      // Expanded(
                      //   child: c.getCountriesFlag
                      //       ? const Center(
                      //           child: CircularProgressIndicator(),
                      //         )
                      //       : c.countriesToShow.isEmpty
                      //           ? const Center(child: NoItemsWidget())
                      //           : ListView.separated(
                      //               itemBuilder: (context, index) =>
                      //                   AdminCountryWidget(
                      //                 country: c.countriesToShow[index],
                      //                 cities: c.cities
                      //                     .where((element) =>
                      //                         element.countryId ==
                      //                         c.countriesToShow[index].id)
                      //                     .toList(),
                      //               ),
                      //               separatorBuilder: (context, index) =>
                      //                   spaceY(10.sp),
                      //               itemCount: c.countriesToShow.length,
                      //             ),
                      // ),
                    ],
                  );
                }),
                // child:
                //  Column(
                //   children: [
                //     spaceY(10.sp),
                //     TabBar(
                //         dividerColor: Colors.grey,
                //         // indicatorColor: Colors.black,
                //         indicator: UnderlineTabIndicator(
                //             borderSide: BorderSide(
                //           color: Theme.of(context).colorScheme.primary,
                //         )),
                //         indicatorSize: TabBarIndicatorSize.tab,

                //         // isScrollable: true,
                //         controller: tabController,
                //         onTap: (value) {
                //           selectedTabIndex = value;
                //           setState(() {});
                //         },
                //         tabs: List<Widget>.generate(
                //           tabController.length,
                //           (index) => Tab(
                //             child: Container(
                //               margin: const EdgeInsets.symmetric(horizontal: 5),
                //               child: coloredText(
                //                   fontSize: 11.sp,
                //                   text: tabs[index].tr,
                //                   color: selectedTabIndex == index
                //                       ? Colors.black
                //                       : Colors.grey),
                //             ),
                //           ),
                //         )),
                //     Expanded(
                //         child: TabBarView(
                //       controller: tabController,
                //       children: [
                //         tab2(),
                //         tab1(),
                //         tab3(),
                //       ],
                //     )),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tab1() => GetBuilder<GlobalController>(builder: (globalController) {
        return Container(
          margin: EdgeInsets.only(bottom: 20.sp),
          child:
              GetBuilder<AddressessController>(builder: (addressessController) {
            return Column(
              children: [
                // spaceY(20.sp),
                // primaryBorderedButton(
                //     onTap: () {
                //       City city = City();
                //       Utils.showDialogBox(
                //         context: context,
                //         actions: [
                //           primaryButton(
                //             onTap: () async {
                //               Get.back();
                //               bool b = await addressessController.createCity(
                //                   city: city);
                //               // ignore: use_build_context_synchronously
                //               if (b) Utils.doneDialog(context: context);
                //             },
                //             color: Colors.black,
                //             width: 50.w,
                //             height: 40.sp,
                //             text: coloredText(
                //                 text: "create".tr, color: Colors.white),
                //           ),
                //         ],
                //         content: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             coloredText(text: "name_ar".tr),
                //             spaceY(5.sp),
                //             SizedBox(
                //               height: 35.sp,
                //               child: TextFormField(
                //                 // maxLines: 1,
                //                 initialValue: city.nameAr,
                //                 onChanged: (value) {
                //                   city.nameAr = value;
                //                 },
                //                 decoration: const InputDecoration(
                //                   // hintText: "write_your_notes".tr,
                //                   border: OutlineInputBorder(
                //                     borderSide: BorderSide.none,
                //                     borderRadius: BorderRadius.all(
                //                       Radius.circular(10),
                //                     ),
                //                   ),
                //                   filled: true,
                //                   fillColor: Color(0xffF5F5F5),
                //                 ),
                //               ),
                //             ),
                //             spaceY(10.sp),
                //             coloredText(text: "name_en".tr),
                //             spaceY(5.sp),
                //             SizedBox(
                //               height: 35.sp,
                //               child: TextFormField(
                //                 // maxLines: 1,
                //                 initialValue: city.nameEn,
                //                 onChanged: (value) {
                //                   city.nameEn = value;
                //                 },
                //                 decoration: const InputDecoration(
                //                   // hintText: "write_your_notes".tr,
                //                   border: OutlineInputBorder(
                //                     borderSide: BorderSide.none,
                //                     borderRadius: BorderRadius.all(
                //                       Radius.circular(10),
                //                     ),
                //                   ),
                //                   filled: true,
                //                   fillColor: Color(0xffF5F5F5),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         title: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             GestureDetector(
                //               onTap: () => Get.back(),
                //               child: const Icon(
                //                 EvaIcons.close,
                //               ),
                //             )
                //           ],
                //         ),
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
                // spaceY(10.sp),
                Expanded(
                  child: globalController.getCitiesFlag
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : globalController.citiesToSHow.isEmpty
                          ? NoItemsWidget()
                          : ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => AdminItemCard(
                                    name:
                                        "${globalController.citiesToSHow[index].nameEn!} - ${globalController.citiesToSHow[index].nameAr!}",
                                    margin: const EdgeInsets.only(bottom: 10),
                                    trailing: Theme(
                                      data:
                                          ThemeData(primaryColor: Colors.white),
                                      child: PopupMenuButton(
                                        constraints: BoxConstraints(
                                          minWidth: 2.0 * 56.0,
                                          maxWidth:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        itemBuilder: (BuildContext cc) => [
                                          PopupMenuItem<int>(
                                            value: 0,
                                            child: Row(
                                              children: [
                                                Icon(EvaIcons.editOutline,
                                                    size: 15.sp),
                                                spaceX(5.sp),
                                                coloredText(
                                                    text: 'edit'.tr,
                                                    fontSize: 12.0.sp),
                                              ],
                                            ),
                                            onTap: () {
                                              City city = City.fromJson(
                                                  globalController
                                                      .citiesToSHow[index]
                                                      .toJson());
                                              logSuccess(globalController
                                                  .citiesToSHow[index]
                                                  .toJson());
                                              Utils.showDialogBox(
                                                context: context,
                                                actions: [
                                                  primaryButton(
                                                    onTap: () async {
                                                      Get.back();
                                                      bool b =
                                                          await addressessController
                                                              .updateCity(
                                                                  city: city);
                                                      // ignore: use_build_context_synchronously
                                                      if (b)
                                                        Utils.doneDialog(
                                                            context: context);
                                                    },
                                                    color: Colors.black,
                                                    width: 50.w,
                                                    height: 40.sp,
                                                    text: coloredText(
                                                        text: "create".tr,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    coloredText(
                                                        text: "name_ar".tr),
                                                    spaceY(5.sp),
                                                    SizedBox(
                                                      height: 35.sp,
                                                      child: TextFormField(
                                                        // maxLines: 1,
                                                        initialValue:
                                                            city.nameAr,
                                                        onChanged: (value) {
                                                          city.nameAr = value;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          // hintText: "write_your_notes".tr,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xffF5F5F5),
                                                        ),
                                                      ),
                                                    ),
                                                    spaceY(10.sp),
                                                    coloredText(
                                                        text: "name_en".tr),
                                                    spaceY(5.sp),
                                                    SizedBox(
                                                      height: 35.sp,
                                                      child: TextFormField(
                                                        // maxLines: 1,
                                                        initialValue:
                                                            city.nameEn,
                                                        onChanged: (value) {
                                                          city.nameEn = value;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          // hintText: "write_your_notes".tr,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Color(0xffF5F5F5),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => Get.back(),
                                                      child: const Icon(
                                                        EvaIcons.close,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );

                                              //  Utils.doneDialog(context: context);
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
                                              bool b =
                                                  await addressessController
                                                      .deleteCity(
                                                city: globalController
                                                    .citiesToSHow[index],
                                              );
                                              if (b) {
                                                Utils.doneDialog(
                                                    context: context);
                                              }
                                            },
                                          ),
                                        ],
                                        child: const Icon(
                                          EvaIcons.moreVertical,
                                        ),
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  spaceY(10.sp),
                              itemCount: globalController.citiesToSHow.length),
                )
              ],
            );
          }),
        );
      });

  Widget tab2() => GetBuilder<GlobalController>(builder: (globalController) {
        return Container(
          margin: EdgeInsets.only(bottom: 20.sp),
          child:
              GetBuilder<AddressessController>(builder: (addressessController) {
            return Column(
              children: [
                // spaceY(20.sp),
                // primaryBorderedButton(
                //     onTap: () {
                //       Get.to(() => AdminCreateCountry());
                //       // Country country = Country();
                //       // Utils.showDialogBox(
                //       //   context: context,
                //       //   actions: [
                //       //     primaryButton(
                //       //       onTap: () async {
                //       //         Get.back();
                //       //         bool b = await addressessController.createCountry(
                //       //             country: country);
                //       //         // ignore: use_build_context_synchronously
                //       //         if (b) Utils.doneDialog(context: context);
                //       //       },
                //       //       color: Colors.black,
                //       //       width: 50.w,
                //       //       height: 40.sp,
                //       //       text: coloredText(
                //       //           text: "create".tr, color: Colors.white),
                //       //     ),
                //       //   ],
                //       //   content: Column(
                //       //     mainAxisSize: MainAxisSize.min,
                //       //     crossAxisAlignment: CrossAxisAlignment.start,
                //       //     children: [
                //       //       coloredText(text: "name_ar".tr),
                //       //       spaceY(5.sp),
                //       //       SizedBox(
                //       //         height: 35.sp,
                //       //         child: TextFormField(
                //       //           // maxLines: 1,
                //       //           initialValue: country.nameAr,
                //       //           onChanged: (value) {
                //       //             country.nameAr = value;
                //       //           },
                //       //           decoration: const InputDecoration(
                //       //             // hintText: "write_your_notes".tr,
                //       //             border: OutlineInputBorder(
                //       //               borderSide: BorderSide.none,
                //       //               borderRadius: BorderRadius.all(
                //       //                 Radius.circular(10),
                //       //               ),
                //       //             ),
                //       //             filled: true,
                //       //             fillColor: Color(0xffF5F5F5),
                //       //           ),
                //       //         ),
                //       //       ),
                //       //       spaceY(10.sp),
                //       //       coloredText(text: "name_en".tr),
                //       //       spaceY(5.sp),
                //       //       SizedBox(
                //       //         height: 35.sp,
                //       //         child: TextFormField(
                //       //           // maxLines: 1,
                //       //           initialValue: country.nameEn,
                //       //           onChanged: (value) {
                //       //             country.nameEn = value;
                //       //           },
                //       //           decoration: const InputDecoration(
                //       //             // hintText: "write_your_notes".tr,
                //       //             border: OutlineInputBorder(
                //       //               borderSide: BorderSide.none,
                //       //               borderRadius: BorderRadius.all(
                //       //                 Radius.circular(10),
                //       //               ),
                //       //             ),
                //       //             filled: true,
                //       //             fillColor: Color(0xffF5F5F5),
                //       //           ),
                //       //         ),
                //       //       ),
                //       //     ],
                //       //   ),
                //       //   title: Row(
                //       //     mainAxisAlignment: MainAxisAlignment.end,
                //       //     children: [
                //       //       GestureDetector(
                //       //         onTap: () => Get.back(),
                //       //         child: const Icon(
                //       //           EvaIcons.close,
                //       //         ),
                //       //       )
                //       //     ],
                //       //   ),
                //       // );
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
                // spaceY(10.sp),
                Expanded(
                  child: globalController.getCountriesFlag
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : globalController.countriesToShow.isEmpty
                          ? NoItemsWidget()
                          : ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => AdminItemCard(
                                    // img: globalController.countriesToShow[index].flag,
                                    name:
                                        "${globalController.countriesToShow[index].nameEn!} - ${globalController.countriesToShow[index].nameAr!}",
                                    margin: const EdgeInsets.only(bottom: 10),
                                    trailing: Theme(
                                      data:
                                          ThemeData(primaryColor: Colors.white),
                                      child: PopupMenuButton(
                                        constraints: BoxConstraints(
                                          minWidth: 2.0 * 56.0,
                                          maxWidth:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        itemBuilder: (BuildContext cc) => [
                                          PopupMenuItem<int>(
                                            value: 0,
                                            child: Row(
                                              children: [
                                                Icon(EvaIcons.editOutline,
                                                    size: 15.sp),
                                                spaceX(5.sp),
                                                coloredText(
                                                    text: 'edit'.tr,
                                                    fontSize: 12.0.sp),
                                              ],
                                            ),
                                            onTap: () {
                                              Get.to(() => AdminCreateCountry(
                                                    countryToEdit:
                                                        globalController
                                                            .countries[index],
                                                  ));
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
                                              bool b =
                                                  await addressessController
                                                      .deleteCountry(
                                                country: globalController
                                                    .countriesToShow[index],
                                              );
                                              if (b) {
                                                Utils.doneDialog(
                                                    context: context);
                                              }
                                            },
                                          ),
                                        ],
                                        child: const Icon(
                                          EvaIcons.moreVertical,
                                        ),
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  spaceY(10.sp),
                              itemCount:
                                  globalController.countriesToShow.length),
                )
              ],
            );
          }),
        );
      });

  Widget tab3() => GetBuilder<GlobalController>(builder: (globalController) {
        return GetBuilder<AddressessController>(
            builder: (addressessController) {
          return Column(
            children: [
              // spaceY(20.sp),
              // primaryBorderedButton(
              //     onTap: () {
              //       Region region = Region();
              //       Utils.showDialogBox(
              //         context: context,
              //         actions: [
              //           primaryButton(
              //             onTap: () async {
              //               Get.back();
              //               bool b = await addressessController.createRegion(
              //                   region: region);
              //               // ignore: use_build_context_synchronously
              //               if (b) Utils.doneDialog(context: context);
              //             },
              //             color: Colors.black,
              //             width: 50.w,
              //             height: 40.sp,
              //             text: coloredText(
              //                 text: "create".tr, color: Colors.white),
              //           ),
              //         ],
              //         content: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             coloredText(text: "name_ar".tr),
              //             spaceY(5.sp),
              //             SizedBox(
              //               height: 35.sp,
              //               child: TextFormField(
              //                 // maxLines: 1,
              //                 initialValue: region.nameAr,
              //                 onChanged: (value) {
              //                   region.nameAr = value;
              //                 },
              //                 decoration: const InputDecoration(
              //                   // hintText: "write_your_notes".tr,
              //                   border: OutlineInputBorder(
              //                     borderSide: BorderSide.none,
              //                     borderRadius: BorderRadius.all(
              //                       Radius.circular(10),
              //                     ),
              //                   ),
              //                   filled: true,
              //                   fillColor: Color(0xffF5F5F5),
              //                 ),
              //               ),
              //             ),
              //             spaceY(10.sp),
              //             coloredText(text: "name_en".tr),
              //             spaceY(5.sp),
              //             SizedBox(
              //               height: 35.sp,
              //               child: TextFormField(
              //                 // maxLines: 1,
              //                 initialValue: region.nameEn,
              //                 onChanged: (value) {
              //                   region.nameEn = value;
              //                 },
              //                 decoration: const InputDecoration(
              //                   // hintText: "write_your_notes".tr,
              //                   border: OutlineInputBorder(
              //                     borderSide: BorderSide.none,
              //                     borderRadius: BorderRadius.all(
              //                       Radius.circular(10),
              //                     ),
              //                   ),
              //                   filled: true,
              //                   fillColor: Color(0xffF5F5F5),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         title: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             GestureDetector(
              //               onTap: () => Get.back(),
              //               child: const Icon(
              //                 EvaIcons.close,
              //               ),
              //             )
              //           ],
              //         ),
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
              // spaceY(10.sp),
              Expanded(
                child: globalController.getCitiesFlag
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AdminItemCard(
                              name:
                                  "${globalController.regions[index].nameEn!} - ${globalController.regions[index].nameAr!}",
                              margin: const EdgeInsets.only(bottom: 10),
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
                                          Icon(EvaIcons.editOutline,
                                              size: 15.sp),
                                          spaceX(5.sp),
                                          coloredText(
                                              text: 'edit'.tr,
                                              fontSize: 12.0.sp),
                                        ],
                                      ),
                                      onTap: () {
                                        Region region = Region.fromJson(
                                            globalController.regions[index]
                                                .toJson());
                                        Utils.showDialogBox(
                                          context: context,
                                          actions: [
                                            primaryButton(
                                              onTap: () async {
                                                Get.back();
                                                bool b =
                                                    await addressessController
                                                        .updateRegion(
                                                            region: region);
                                                // ignore: use_build_context_synchronously
                                                if (b)
                                                  Utils.doneDialog(
                                                      context: context);
                                              },
                                              color: Colors.black,
                                              width: 50.w,
                                              height: 40.sp,
                                              text: coloredText(
                                                  text: "create".tr,
                                                  color: Colors.white),
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              coloredText(text: "name_ar".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue: region.nameAr,
                                                  onChanged: (value) {
                                                    region.nameAr = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    // hintText: "write_your_notes".tr,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffF5F5F5),
                                                  ),
                                                ),
                                              ),
                                              spaceY(10.sp),
                                              coloredText(text: "name_en".tr),
                                              spaceY(5.sp),
                                              SizedBox(
                                                height: 35.sp,
                                                child: TextFormField(
                                                  // maxLines: 1,
                                                  initialValue: region.nameEn,
                                                  onChanged: (value) {
                                                    region.nameEn = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    // hintText: "write_your_notes".tr,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffF5F5F5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () => Get.back(),
                                                child: const Icon(
                                                  EvaIcons.close,
                                                ),
                                              )
                                            ],
                                          ),
                                        );

                                        //  Utils.doneDialog(context: context);
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
                                        bool b = await addressessController
                                            .deleteRegion(
                                          region:
                                              globalController.regions[index],
                                        );
                                        if (b) {
                                          Utils.doneDialog(context: context);
                                        }
                                      },
                                    ),
                                  ],
                                  child: const Icon(
                                    EvaIcons.moreVertical,
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => spaceY(10.sp),
                        itemCount: globalController.regions.length),
              )
            ],
          );
        });
      });
}

class AdminCountryWidget extends StatefulWidget {
  AdminCountryWidget({super.key, required this.country, required this.cities});
  final Country country;
  final List<City> cities;

  @override
  State<AdminCountryWidget> createState() => _AdminCountryWidgetState();
}

class _AdminCountryWidgetState extends State<AdminCountryWidget> {
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: false);
  @override
  void initState() {
    _expandableController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  // GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10)),
          child: ExpandablePanel(
            controller: _expandableController,
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToCollapse: true,
            ),
            collapsed: Container(),
            expanded: widget.cities.isEmpty
                ? const Text("no cities found")
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.cities.length,
                    itemBuilder: (context, index) => coloredText(
                      text:
                          "${widget.cities[index].nameEn} - ${widget.cities[index].nameAr}",
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        spaceY(5.sp),
                  ),
            header: Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffEFEFEF)),
                  ),
                ),
                child: coloredText(
                    text:
                        "${widget.country.nameEn} - ${widget.country.nameAr}")),
          ),
        ),
      ),
    );
  }
}
