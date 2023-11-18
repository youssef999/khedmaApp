import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CleaningServiceWidget extends StatefulWidget {
  CleaningServiceWidget(
      {super.key,
      this.added = false,
      required this.index,
      required this.price,
      required this.name,
      required this.image,
      required this.serviceId});
  final int index;
  bool added;
  final String price;
  final String name;
  final String image;
  final int serviceId;

  @override
  State<CleaningServiceWidget> createState() => _CleaningServiceWidgetState();
}

class _CleaningServiceWidgetState extends State<CleaningServiceWidget> {
  final CompaniesController _cleaningCompanyController = Get.find();
  final GlobalController _globalController = Get.find();
  int quantityCounter = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 35.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          spaceX(10.sp),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(text: widget.name),
              spaceY(3.sp),
              coloredText(
                  textDirection: TextDirection.ltr,
                  text:
                      "${(double.parse(widget.price) * _globalController.currencyRate).toStringAsFixed(1)} ${_globalController.currencySymbol.key}",
                  color: Theme.of(context).colorScheme.secondary),
              spaceY(3.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      quantityCounter++;

                      setState(() {});
                    },
                    child: const Icon(
                      EvaIcons.plusCircleOutline,
                      color: Color(0xff919191),
                    ),
                  ),
                  spaceX(10.sp),
                  coloredText(text: "$quantityCounter"),
                  spaceX(10.sp),
                  GestureDetector(
                    onTap: () {
                      if (quantityCounter > 0) {
                        quantityCounter--;
                      }
                      setState(() {});
                    },
                    child: const Icon(
                      EvaIcons.minusCircleOutline,
                      color: Color(0xff919191),
                    ),
                  )
                ],
              ),
              spaceY(6.sp),
              primaryButton(
                  onTap: widget.added
                      ? null
                      : () async {
                          if (_globalController.guest) {
                            Utils.loginFirstDialoge(context: context);
                          } else {
                            bool b = await _cleaningCompanyController
                                .createCompanyService(
                                    service: MyService(
                              price: widget.price,
                              name: widget.name,
                              image: widget.image,
                              serviceId: widget.serviceId,
                              quantity: quantityCounter,
                            ));
                            if (b) widget.added = true;

                            setState(() {});
                          }
                        },
                  alignment: AlignmentDirectional.centerStart,
                  width: 30.w,
                  height: 25.sp,
                  text: coloredText(
                    text: widget.added ? "added".tr : "add".tr,
                    color: Colors.white,
                  ),
                  color: widget.added
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary)
            ],
          ))
        ],
      ),
    );
  }
}

class MyService {
  final String price;
  final String name;
  final String image;
  final int serviceId;
  final int quantity;

  MyService(
      {required this.price,
      required this.quantity,
      required this.name,
      required this.image,
      required this.serviceId});
}
