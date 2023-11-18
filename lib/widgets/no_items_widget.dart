import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:sizer/sizer.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          coloredText(
              text: "nothing_found".tr, fontSize: 25.sp, color: Colors.grey),
          spaceY(10.sp),
          Icon(
            EvaIcons.alertCircleOutline,
            size: 40.sp,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
