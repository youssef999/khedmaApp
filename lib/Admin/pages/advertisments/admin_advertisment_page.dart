import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/controllers/advertisment_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/ad_card.dart';
import 'package:sizer/sizer.dart';

class AdminAdvertismentsPage extends StatefulWidget {
  const AdminAdvertismentsPage({super.key});

  @override
  State<AdminAdvertismentsPage> createState() => _AdminAdvertismentsPageState();
}

class _AdminAdvertismentsPageState extends State<AdminAdvertismentsPage>
    with SingleTickerProviderStateMixin {
  AdvertismentController _advertismentController = Get.find();
  List<String> tabs = [
    "requests".tr,
    "refunds".tr,
    "history".tr,
  ];
  late TabController tabController;
  int selectedTabIndex = 0;
  @override
  void initState() {
    _advertismentController.getAdminAdvertisments();
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: "ads".tr,
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
                child: GetBuilder<AdvertismentController>(builder: (c) {
                  return c.getAdminAdvertismentsFlag
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            spaceY(10.sp),
                            // SearchTextField(
                            //   hintText: "${"search".tr} ...",
                            //   prefixIcon: const Icon(
                            //     EvaIcons.search,
                            //     color: Color(0xffAFAFAF),
                            //   ),
                            //   suffixIcon: GestureDetector(
                            //     onTap: () {
                            //       Get.to(() => const AdvertismentsFilterPage());
                            //     },
                            //     child: const Image(
                            //       width: 15,
                            //       height: 15,
                            //       image: AssetImage("assets/images/filter-icon.png"),
                            //     ),
                            //   ),
                            // ),
                            // spaceY(10.sp),
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: coloredText(
                                          fontSize: 12.sp,
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
                              controller: tabController,
                              children: [
                                tab1(),
                                tab2(),
                                tab3(),
                                // tab2(),
                                // tab3(),
                              ],
                            )),
                          ],
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tab1() => GetBuilder<AdvertismentController>(
        builder: (c) {
          return ListView.separated(
            primary: false,
            itemCount: c.adminRequestedAds.length,
            separatorBuilder: (BuildContext context, int index) =>
                spaceY(20.sp),
            itemBuilder: (BuildContext context, int index) => AdvertismentCard(
              admin: true,
              pending: true,
              advertismentModel: c.adminRequestedAds[index],
            ),
          );
        },
      );
  Widget tab2() => GetBuilder<AdvertismentController>(
        builder: (c) {
          return ListView.separated(
            primary: false,
            itemCount: c.adminRefundAds.length,
            separatorBuilder: (BuildContext context, int index) =>
                spaceY(20.sp),
            itemBuilder: (BuildContext context, int index) => AdvertismentCard(
              admin: true,
              // pending: true,
              advertismentModel: c.adminRefundAds[index],
              refunds: true,
            ),
          );
        },
      );
  Widget tab3() => GetBuilder<AdvertismentController>(
        builder: (c) {
          return ListView.separated(
            primary: false,
            itemCount: c.adminAds.length,
            separatorBuilder: (BuildContext context, int index) =>
                spaceY(20.sp),
            itemBuilder: (BuildContext context, int index) => AdvertismentCard(
              admin: true,
              status: true,
              // pending: true,
              advertismentModel: c.adminAds[index],
              // refunds: true,
            ),
          );
        },
      );

  //       children: [
  //         AdvertismentCard(
  //           advertismentModel: _tmp,
  //           admin: true,
  //           status: true,
  //         ),
  //         spaceY(20.sp),
  //         AdvertismentCard(
  //           advertismentModel: _tmp,
  //           admin: true,
  //           status: true,
  //         ),
  //         spaceY(20.sp),
  //         AdvertismentCard(
  //           advertismentModel: _tmp,
  //           admin: true,
  //           status: true,
  //         ),
  //         spaceY(20.sp),
  //       ],
  //     );
}
