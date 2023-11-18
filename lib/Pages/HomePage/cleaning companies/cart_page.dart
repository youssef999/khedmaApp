import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/employees/filling_data_page.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/widgets/booked_cleaning_company_service_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  CartPage({super.key, required this.companyId});
  final int companyId;
  final GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(text: "my_cart".tr, fontSize: 15.0.sp),
      ),
      body: GetBuilder<CompaniesController>(
        builder: (c) => Column(
          children: [
            SizedBox(
              height: 80.h,
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) => BookedCleaningServiceWidget(
                  service: c.servicesBooked[index],
                ),
                separatorBuilder: (context, index) => spaceY(20.sp),
                itemCount: c.servicesBooked.length,
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    coloredText(text: "${"total".tr}:"),
                    coloredText(
                        textDirection: TextDirection.ltr,
                        text:
                            "${(c.getCartTotal() * _globalController.currencyRate).toCurrencyString()} ${_globalController.currencySymbol.key}",
                        color: Theme.of(context).colorScheme.secondary),
                  ],
                ),
                primaryButton(
                    alignment: Alignment.topCenter,
                    onTap: () {
                      Get.to(() => FillingDataPage(
                            companyId: companyId,
                          ));
                    },
                    height: 40.sp,
                    width: 60.w,
                    text: coloredText(text: "next".tr, color: Colors.white),
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
