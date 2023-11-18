import 'package:badges/badges.dart' as badges;
import 'package:chips_choice/chips_choice.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/cleaning%20companies/cart_page.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/Pages/chat%20page/chat_page.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/chat%20page/model/my_message.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/web_view_container.dart';
import 'package:khedma/widgets/cleaning_company_service_widget.dart';
import 'package:khedma/widgets/my_rating_bar.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

class CleaningCompany extends StatefulWidget {
  const CleaningCompany({super.key, required this.cleaningCompany});
  final CompanyModel cleaningCompany;
  @override
  State<CleaningCompany> createState() => _CleaningCompanyState();
}

class _CleaningCompanyState extends State<CleaningCompany> {
  PageController _pageController = PageController(initialPage: 0);
  final CompaniesController _cleaningCompanyController = Get.find();
  final GlobalController _globalController = Get.find();
  ChatController _chatController = Get.find();
  List<double> rates = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  double rate = 0;
  List<String> tags = [
    "services".tr,
  ];

  List<String> options = [
    "services".tr,
    "orders".tr,
    "rate_view".tr,
  ];

  @override
  void initState() {
    if (widget.cleaningCompany.reviewCompany != null) {
      for (var i in widget.cleaningCompany.reviewCompany!) {
        rates[i.reviewValue!]++;
      }
      int c = 0;
      for (var i = 0; i < rates.length; i++) {
        if (rates[i] > 0) {
          rate += i * rates[i];
          c = c + 1;
        }
      }
      if (c == 0) c += 1;

      rate = rate / c;
    } else {
      widget.cleaningCompany.reviewCompany = [];
    }
    _cleaningCompanyController.geCompanyPrice(
        companyId: widget.cleaningCompany.id!);
    _globalController.getUserCheckouts();

    logSuccess("companyId:" + widget.cleaningCompany.id!.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: !tags.contains("services".tr)
            ? null
            : _globalController.guest
                ? Container()
                : Theme(
                    data: ThemeData(
                      useMaterial3: false,
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => CartPage(
                              companyId: widget.cleaningCompany.id!,
                            ));
                      },
                      child: GetBuilder<CompaniesController>(builder: (c) {
                        return badges.Badge(
                          showBadge: c.servicesBooked.isNotEmpty,
                          badgeContent: coloredText(
                              text: c.servicesBooked.length.toString(),
                              color: Colors.white),
                          position: badges.BadgePosition.topEnd(
                              top: -5.sp, end: -5.sp),
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
                              EvaIcons.shoppingCartOutline,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
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
                                      GlobalChat? chat =
                                          await _chatController.storeChat(
                                              id: widget.cleaningCompany.id!);
                                      if (chat != null) {
                                        Get.to(
                                          () => ChatPage(
                                            chatId: chat.chat!.id!,
                                            receiverId: chat.chat!.id!,
                                            recieverName: chat.user!.fullName!,
                                            recieverImage:
                                                _globalController.me.userType ==
                                                        "company"
                                                    ? chat
                                                        .user!
                                                        .userInformation!
                                                        .personalPhoto!
                                                    : chat
                                                        .user!
                                                        .companyInformation!
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
                                        maxWidth:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      itemBuilder: (BuildContext cc) => [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: coloredText(
                                              text: 'report'.tr,
                                              fontSize: 12.0.sp),
                                          onTap: () async {
                                            Utils().reportDialoge(
                                              context: context,
                                              companyId:
                                                  widget.cleaningCompany.id!,
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
                          // onTap: () => Get.to(() => const CleaningCompany(),
                          //     ),
                          child: Container(
                            width: 75.0.sp,
                            height: 75.0.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.cleaningCompany
                                      .companyInformation!.companyLogo),
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
                                  text: widget.cleaningCompany.fullName!,
                                  color: Colors.white,
                                  fontSize: 16.0.sp),
                              spaceY(6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    EvaIcons.pin,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 15.0.sp,
                                  ),
                                  spaceX(3),
                                  coloredText(
                                    text: _globalController.cities
                                        .where((element) =>
                                            widget.cleaningCompany
                                                .companyInformation!.cityId ==
                                            element.id)
                                        .map((e) => Get.locale ==
                                                const Locale('en', 'US')
                                            ? e.nameEn!
                                            : e.nameAr!)
                                        .first,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                    text: widget.cleaningCompany
                                        .companyInformation!.companyPhone!,
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
                                    text: (widget.cleaningCompany
                                                        .reviewCompanySumReviewValue !=
                                                    null &&
                                                widget.cleaningCompany
                                                        .reviewCompanyCount !=
                                                    null
                                            ? int.parse(widget.cleaningCompany
                                                    .reviewCompanySumReviewValue!) /
                                                widget.cleaningCompany
                                                    .reviewCompanyCount!
                                            : 0)
                                        .toStringAsFixed(1),
                                    fontSize: 13.0.sp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              spaceY(3.0.h),
                            ],
                          ),
                        )
                      ],
                    ),
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
                          _pageController
                              .jumpToPage(options.indexOf(item.label));

                          setState(() {});
                        },
                        child: Container(
                          // width: 45.0.w,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
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
                child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pageList,
            ))
          ],
        ));
  }

  List<Widget> get pageList => [
        GetBuilder<CompaniesController>(builder: (c) {
          return widget.cleaningCompany.cleaningServices!.isEmpty
              ? const Center(child: NoItemsWidget())
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  itemBuilder: (context, index) => CleaningServiceWidget(
                    added: _cleaningCompanyController.servicesBooked
                        .where((element) =>
                            element.serviceId ==
                            widget.cleaningCompany.cleaningServices![index].id!)
                        .isNotEmpty,
                    index: index,
                    price:
                        widget.cleaningCompany.cleaningServices![index].price!,
                    name: _globalController.categories
                        .where((element) =>
                            element.id ==
                            widget.cleaningCompany.cleaningServices![index]
                                .serviceId)
                        .map(
                          (e) => Get.locale == const Locale('en', 'US')
                              ? e.nameEn!
                              : e.nameAr!,
                        )
                        .first,
                    image: _globalController.categories
                        .where((element) =>
                            element.id ==
                            widget.cleaningCompany.cleaningServices![index]
                                .serviceId)
                        .first
                        .image,
                    serviceId:
                        widget.cleaningCompany.cleaningServices![index].id!,
                  ),
                  separatorBuilder: (context, index) => spaceY(20.sp),
                  itemCount: widget.cleaningCompany.cleaningServices!.length,
                );
        }),
        GetBuilder<GlobalController>(builder: (c) {
          return c.getUserCheckoutsFlag
              ? const Center(child: CircularProgressIndicator())
              : c.checkouts.isEmpty
                  ? NoItemsWidget()
                  : ListView.builder(
                      itemBuilder: (context, index) => Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 20.sp),
                        padding: const EdgeInsetsDirectional.only(
                            top: 20, bottom: 20, start: 20, end: 10),
                        width: 100.w,
                        // height: 42.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 18.w,
                                    child: coloredText(
                                        text: "${"order".tr}:",
                                        fontSize: 12.sp)),
                                spaceX(10.sp),
                                Expanded(
                                  child: coloredText(
                                      text: c.checkouts[index].order!
                                          .map((e) =>
                                              "${e.quantity} ${Get.locale == const Locale('en', 'US') ? e.services!.adminService!.nameEn! : e.services!.adminService!.nameAr!}")
                                          .toList()
                                          .join(", "),
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                            spaceY(10.sp),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 18.w,
                                    child: coloredText(
                                        text: "${"address".tr}:",
                                        fontSize: 12.sp)),
                                spaceX(10.sp),
                                Expanded(
                                  child: coloredText(
                                      text: c.checkouts[index].address!,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                            spaceY(10.sp),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 18.w,
                                    child: coloredText(
                                        text: "${"price".tr}:",
                                        fontSize: 12.sp)),
                                spaceX(10.sp),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: coloredText(
                                        textDirection: TextDirection.ltr,
                                        text:
                                            "${c.checkouts[index].amount != null ? (double.parse(c.checkouts[index].amount!) * _globalController.currencyRate).toStringAsFixed(1) : 0} ${_globalController.currencySymbol.key}",
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                            spaceY(10.sp),
                            c.checkouts[index].approve == null ||
                                    c.checkouts[index].approve == 0 ||
                                    c.checkouts[index].paid == 1
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 18.w,
                                          child: coloredText(
                                              text: "${"status".tr}:",
                                              fontSize: 12.sp)),
                                      spaceX(10.sp),
                                      Expanded(
                                        child: c.checkouts[index].approve ==
                                                null
                                            ? coloredText(
                                                text: "pending".tr,
                                                color: Colors.blue,
                                                fontSize: 12.sp)
                                            : c.checkouts[index].approve == 0
                                                ? coloredText(
                                                    text: "refused".tr,
                                                    color: Colors.red,
                                                    fontSize: 12.sp)
                                                : c.checkouts[index].paid == 1
                                                    ? coloredText(
                                                        text: "paid".tr,
                                                        color: Colors.green,
                                                        fontSize: 12.sp)
                                                    : Container(),
                                      )
                                    ],
                                  )
                                : Container(),
                            spaceY(10.sp),
                            c.checkouts[index].approve == null ||
                                    c.checkouts[index].approve == 0 ||
                                    c.checkouts[index].paid == 1
                                ? Container()
                                : primaryBorderedButton(
                                    onTap: () async {
                                      Map<String, String>? x =
                                          await _globalController.payCheckOut(
                                              id: c.checkouts[index].id!);
                                      if (x != null) {
                                        Get.to(() => WebViewContainer(
                                                  url: x.values.first,
                                                ))!
                                            .then((value) async {
                                          await _globalController
                                              .getUserCheckouts();
                                          // ignore: use_build_context_synchronously
                                          Utils().rateDialoge(
                                              context: context,
                                              companyId:
                                                  widget.cleaningCompany.id!);
                                          setState(() {});
                                        });
                                        // Uri url = Uri.parse(x.values.first);

                                        // logSuccess(x);
                                        // await launchUrl(url,
                                        //     mode:
                                        //         LaunchMode.externalApplication);

                                        // await Future.delayed(
                                        //     Duration(milliseconds: 100));
                                        // while (WidgetsBinding
                                        //         .instance.lifecycleState !=
                                        //     AppLifecycleState.resumed) {
                                        //   await Future.delayed(
                                        //       Duration(milliseconds: 100));
                                        // }
                                      }
                                    },
                                    alignment: AlignmentDirectional.center,
                                    width: 35.w,
                                    height: 40.sp,
                                    radius: 10,
                                    text: coloredText(
                                        text: "pay".tr, fontSize: 12.sp),
                                    color: const Color(0xff919191),
                                  ),
                          ],
                        ),
                      ),
                      itemCount: c.checkouts.length,
                    );
        }),
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          children: [
            coloredText(
              text: "rate_view".tr,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Divider(
              color: Color(0xffDBDBDB),
            ),
            spaceY(10),
            Row(
              children: [
                coloredText(
                  text: rate.toStringAsFixed(1),
                  fontSize: 35.0.sp,
                  color: Theme.of(context).colorScheme.primary,
                  // fontWeight: FontWeight.bold,
                ),
                spaceX(30),
                Expanded(
                  child: Column(
                    children: [
                      MyRatingBar(
                        label: '5',
                        value: rates[5],
                        maxVal: widget.cleaningCompany.reviewCompany!.length
                            .toDouble(),
                      ),
                      spaceY(3),
                      MyRatingBar(
                        label: '4',
                        value: rates[4],
                        maxVal: widget.cleaningCompany.reviewCompany!.length
                            .toDouble(),
                      ),
                      spaceY(3),
                      MyRatingBar(
                        label: '3',
                        value: rates[3],
                        maxVal: widget.cleaningCompany.reviewCompany!.length
                            .toDouble(),
                      ),
                      spaceY(3),
                      MyRatingBar(
                        label: '2',
                        value: rates[2],
                        maxVal: widget.cleaningCompany.reviewCompany!.length
                            .toDouble(),
                      ),
                      spaceY(3),
                      MyRatingBar(
                        label: '1',
                        value: rates[1],
                        maxVal: widget.cleaningCompany.reviewCompany!.length
                            .toDouble(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            spaceY(20),
            ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12.0.w,
                              height: 12.0.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(),
                                image: DecorationImage(
                                    image: NetworkImage(widget
                                        .cleaningCompany
                                        .reviewCompany![index]
                                        .user!
                                        .userInformation!
                                        .personalPhoto!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            spaceX(10),
                            coloredText(
                              text: widget.cleaningCompany.reviewCompany![index]
                                  .user!.fullName!,
                              color: Colors.black,
                              fontSize: 14.0.sp,
                            )
                          ],
                        ),
                        spaceY(5.sp),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: RatingBar.builder(
                            allowHalfRating: false,
                            initialRating: widget.cleaningCompany
                                .reviewCompany![index].reviewValue!
                                .toDouble(),
                            itemSize: 20.sp,
                            itemCount: 5,
                            ignoreGestures: true,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  );
                                case 1:
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  );
                                case 2:
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  );
                                case 3:
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  );
                                default:
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {},

                            //  RatingBar.builder(
                            //   initialRating: 4.5,
                            //   minRating: 0,
                            //   direction: Axis.horizontal,
                            //   allowHalfRating: true,
                            //   itemCount: 5,
                            //   itemSize: 17.0.sp,unratedColor: Colors.transparent,
                            //   itemPadding:
                            //       EdgeInsets.symmetric(horizontal: 4.0),
                            //   itemBuilder: (context, index) {
                            //     if (index < 4.5) {
                            //       return const Icon(
                            //         Icons.star_rounded,
                            //         color: Colors.black,
                            //       );
                            //     } else {
                            //       return const Icon(
                            //         Icons.star_outline_rounded,
                            //         color: Colors.black,
                            //       );
                            //     }
                            //   },
                            //   onRatingUpdate: (rating) {
                            //     print(rating);
                            //   },
                            // ),
                          ),
                        ),
                        spaceY(10),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: coloredText(
                              text: widget.cleaningCompany.reviewCompany![index]
                                  .review!,
                              color: const Color(0xff919191)),
                        )
                      ],
                    ),
                separatorBuilder: (context, index) => spaceY(20),
                itemCount: widget.cleaningCompany.reviewCompany!.length),
            spaceY(20),
          ],
        ),
      ];
}
