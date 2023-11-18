// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/page_indicator.dart';
import 'package:khedma/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  final pageController = PageController(initialPage: 0, keepPage: false);

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZeroAppBar(
        gradient: LinearGradient(
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
          // stops: [0, 0.],
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ],
              )),
              width: 100.0.w,
              height: 32.0.h,
            ),
          ),
          SizedBox(
            height: 50.0.h,
            child: PageView.builder(
              controller: pageController,
              // physics:const  NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                i = value;
                setState(() {});
              },
              itemBuilder: (BuildContext context, int index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: coloredText(
                      text: "Lorem Ipsum",
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0.sp,
                    ),
                  ),
                  spaceY(2.0.h),
                  Align(
                    child: coloredText(
                      text:
                          "Lorem ipsum dolor sit amet consectetur adipiscing elit",
                      textAlign: TextAlign.center,
                      // fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 15.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PageIndicator(
            currentValue: i,
            num: 3,
          ),
        ],
      ),
    );
  }
}
