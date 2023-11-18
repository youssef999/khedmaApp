import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/models/account_statment.dart';
import 'package:khedma/Admin/pages/account%20statment/account_statment_filter_page.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class AdminAccountStatmentPage extends StatefulWidget {
  const AdminAccountStatmentPage({super.key});

  @override
  State<AdminAccountStatmentPage> createState() =>
      _AdminAccountStatmentPageState();
}

class _AdminAccountStatmentPageState extends State<AdminAccountStatmentPage> {
  AdminController _adminController = Get.find();
  @override
  void initState() {
    _adminController.getAccountStatments();
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
                    text: "account_statment".tr,
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
                    spaceY(10.sp),
                    SearchTextField(
                      onchanged: (s) {
                        if (s != null)
                          _adminController.handleAccountStatmentSearch(name: s);
                      },
                      hintText: "${"search".tr} ...",
                      prefixIcon: const Icon(
                        EvaIcons.search,
                        color: Color(0xffAFAFAF),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Get.to(() => AccountStatmentFilterPage());
                        },
                        child: const Image(
                          width: 15,
                          height: 15,
                          image: AssetImage("assets/images/filter-icon.png"),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    GetBuilder<AdminController>(builder: (c) {
                      return Expanded(
                        child: c.accountStatmentFlag
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : c.accountStatmentsToShow.isEmpty
                                ? NoItemsWidget()
                                : ListView.separated(
                                    itemBuilder: (context, index) =>
                                        AccountStatmentCard(
                                            accountStatmentModel: c
                                                .accountStatmentsToShow[index]),
                                    separatorBuilder: (context, index) =>
                                        spaceY(10.sp),
                                    itemCount: c.accountStatmentsToShow.length),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountStatmentCard extends StatelessWidget {
  const AccountStatmentCard({
    super.key,
    required this.accountStatmentModel,
  });
  final AccountStatmentModel accountStatmentModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(10),
      // height: 25.h,
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          depositLine(
              title: "depositor".tr, content: accountStatmentModel.depositor!),
          spaceY(10.sp),
          depositLine(
              title: "beneficiary".tr,
              content: accountStatmentModel.beneficiary!),
          spaceY(10.sp),
          depositLine(
              title: "deposit_type".tr,
              content: accountStatmentModel.depositType!.tr),
          spaceY(10.sp),
          depositLine(
              title: "payment_date".tr,
              content: intl.DateFormat(intl.DateFormat.YEAR_NUM_MONTH_DAY)
                  .format(DateTime.parse(accountStatmentModel.createdAt!))),
          spaceY(10.sp),
          Row(
            children: [
              SizedBox(
                width: 30.w,
                child:
                    coloredText(text: "${"amount".tr}: ", color: Colors.grey),
              ),
              Expanded(
                child: coloredText(
                  text: "${accountStatmentModel.amount} ${"kwd".tr}",
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
          // depositLine(title: "amount".tr, content: "lorem ipsum etc"),
          ,
          spaceY(10.sp),
          depositLine(
            title: "about".tr,
            content: accountStatmentModel.about!,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}

Row depositLine(
    {required String title,
    required String content,
    TextDirection? textDirection,
    TextOverflow? overflow,
    double? width,
    TextDecoration? decoration,
    void Function()? onTap,
    Color? color}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: width ?? 30.w,
        child: coloredText(text: "$title: ", color: Colors.grey),
      ),
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: coloredText(
            overflow: overflow,
            color: color,
            text: content,
            fontSize: 12.sp,
            textDirection: textDirection,
            decoration: decoration,
          ),
        ),
      )
    ],
  );
}
