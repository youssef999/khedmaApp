import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/models/refund_model.dart';
import 'package:khedma/Admin/pages/account%20statment/admin_account_statment_page.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminRefundsPage extends StatefulWidget {
  const AdminRefundsPage({super.key});

  @override
  State<AdminRefundsPage> createState() => _AdminRefundsPageState();
}

class _AdminRefundsPageState extends State<AdminRefundsPage> {
  AdminController _adminController = Get.find();
  @override
  void initState() {
    _adminController.getRefunds();
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
                    text: "refund_requests".tr,
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
                    // SearchTextField(
                    //   onchanged: (s) {
                    //     if (s != null)
                    //       _adminController.handleAccountStatmentSearch(name: s);
                    //   },
                    //   hintText: "${"search".tr} ...",
                    //   prefixIcon: const Icon(
                    //     EvaIcons.search,
                    //     color: Color(0xffAFAFAF),
                    //   ),
                    //   suffixIcon: GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => AccountStatmentFilterPage());
                    //     },
                    //     child: const Image(
                    //       width: 15,
                    //       height: 15,
                    //       image: AssetImage("assets/images/filter-icon.png"),
                    //     ),
                    //   ),
                    // ),
                    // spaceY(10.sp),
                    GetBuilder<AdminController>(builder: (c) {
                      return Expanded(
                        child: c.getRefundsFlag
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : c.refunds.isEmpty
                                ? const NoItemsWidget()
                                : ListView.separated(
                                    itemBuilder: (context, index) =>
                                        RefundWidget(refund: c.refunds[index]),
                                    separatorBuilder: (context, index) =>
                                        spaceY(10.sp),
                                    itemCount: c.refunds.length),
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

class RefundWidget extends StatelessWidget {
  RefundWidget({
    super.key,
    required this.refund,
  });
  final RefundModel refund;
  final AdminController _adminController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              depositLine(
                title: "user".tr,
                content: refund.user!.fullName!,
                width: 25.w,
              ),
              spaceY(10.sp),
              depositLine(
                title: "date".tr,
                content: DateFormat('y/MM/dd hh:mm a')
                    .format(DateTime.parse(refund.createdAt!)),
                width: 25.w,
              ),
              spaceY(10.sp),
              depositLine(
                title: "desc".tr,
                content: refund.desc!,
                width: 25.w,
              ),
              if (refund.attchment != null) spaceY(10.sp),
              if (refund.attchment != null)
                depositLine(
                  title: "file".tr,
                  content: basename(refund.attchment!),
                  color: Colors.blue.shade400,
                  decoration: TextDecoration.underline,
                  onTap: () async {
                    Uri uri = Uri.parse(refund.attchment!);
                    await launchUrl(uri);
                  },
                  width: 25.w,
                ),
              spaceY(10.sp),
              refund.approved != 0
                  ? depositLine(
                      title: "status",
                      content:
                          refund.approved == 2 ? "accepted".tr : "refused".tr,
                      color: refund.approved == 1
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        primaryButton(
                          onTap: () async {
                            bool b = await _adminController.approveRefund(
                              id: refund.id!,
                              approve: 2,
                            );
                            if (b) {
                              // ignore: use_build_context_synchronously

                              Utils.doneDialog(context: context);
                            }
                          },
                          width: 40.w,
                          height: 30.sp,
                          color: Theme.of(context).colorScheme.primary,
                          text: coloredText(
                              text: "approve".tr, color: Colors.white),
                        ),
                        primaryBorderedButton(
                          onTap: () async {
                            String desc = "";
                            Utils.showDialogBox(
                              context: context,
                              actions: [
                                primaryButton(
                                  onTap: () async {
                                    Get.back();
                                    bool b =
                                        await _adminController.approveRefund(
                                            id: refund.id!,
                                            approve: 1,
                                            desc: desc);
                                    if (b) {
                                      // adminApprove = 1;
                                      // setState(() {});
                                      // ignore: use_build_context_synchronously
                                      Utils.doneDialog(context: context);
                                    }
                                  },
                                  color: Colors.black,
                                  width: 45.w,
                                  height: 30.sp,
                                  text: coloredText(
                                      text: "submit".tr, color: Colors.white),
                                ),
                              ],
                              content: TextFormField(
                                onChanged: (value) {
                                  desc = value;
                                },
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "write_your_notes".tr,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffF5F5F5),
                                ),
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
                          },
                          width: 40.w,
                          height: 30.sp,
                          color: Colors.black,
                          text: coloredText(
                              text: "refuse".tr, color: Colors.black),
                        )
                      ],
                    ),
            ],
          ),
        ),
        PositionedDirectional(
          top: 10,
          end: 10,
          child: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: PopupMenuButton(
              constraints: BoxConstraints(
                minWidth: 2.0 * 56.0,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              itemBuilder: (BuildContext cc) => [
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(EvaIcons.trash2Outline, size: 15.sp),
                      spaceX(5.sp),
                      coloredText(text: 'delete'.tr, fontSize: 12.0.sp),
                    ],
                  ),
                  onTap: () async {
                    bool b = await _adminController.deleteRefund(
                      id: refund.id!,
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
        )
      ],
    );
  }
}
