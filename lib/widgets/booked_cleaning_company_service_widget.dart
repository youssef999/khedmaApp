import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/cleaning_company_service_widget.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class BookedCleaningServiceWidget extends StatefulWidget {
  const BookedCleaningServiceWidget({
    super.key,
    required this.service,
  });
  final MyService service;
  @override
  State<BookedCleaningServiceWidget> createState() =>
      _BookedCleaningServiceWidgetState();
}

class _BookedCleaningServiceWidgetState
    extends State<BookedCleaningServiceWidget> {
  @override
  void initState() {
    super.initState();
  }

  GlobalController _globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(widget.service.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          spaceX(10.sp),
          SizedBox(
            height: 25.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                coloredText(text: widget.service.name),
                coloredText(
                    textDirection: TextDirection.ltr,
                    text:
                        "${(double.parse(widget.service.price) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key}",
                    color: Theme.of(context).colorScheme.secondary),
                Row(
                  children: [
                    coloredText(text: "${"quantity".tr}:", color: Colors.grey),
                    coloredText(text: widget.service.quantity.toString()),
                  ],
                ),
                spaceX(5),
              ],
            ),
          ),
          Expanded(
              child: SizedBox(
            height: 25.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetBuilder<CompaniesController>(builder: (c) {
                  return GestureDetector(
                    onTap: () async {
                      await c.deleteCart(service: widget.service);
                      // if (b) Get.back();
                    },
                    child: const Icon(Icons.close),
                  );
                }),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
