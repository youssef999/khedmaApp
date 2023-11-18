import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/models/contact_model.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdminContactUsPage extends StatefulWidget {
  const AdminContactUsPage({super.key});

  @override
  State<AdminContactUsPage> createState() => _AdminAddressesPageState();
}

class _AdminAddressesPageState extends State<AdminContactUsPage>
    with SingleTickerProviderStateMixin {
  List<String> tabs = [
    "contact",
    "messages",
  ];
  ContactModel m = ContactModel(id: 0);
  AdminController _adminController = Get.find();
  late TabController tabController;
  int selectedTabIndex = 0;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    if (_adminController.contactModel != null)
      m = _adminController.contactModel!;
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
                    text: "contact".tr,
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
                              margin: const EdgeInsets.symmetric(horizontal: 5),
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
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        tab1(),
                        tab2(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tab1() => GetBuilder<AdminController>(builder: (c) {
        return ListView(
          primary: false,
          children: [
            coloredText(text: "phone_number".tr),
            spaceY(5.sp),
            SendMessageTextField(
              initialValue:
                  c.contactModel != null ? c.contactModel!.phoneNumber : null,
              onchanged: (s) {
                m.phoneNumber = s;
              },
              keyBoardType: TextInputType.phone,
              focusNode: FocusNode(),
              borderRadius: 10,
              prefixIcon: Container(
                padding: EdgeInsetsDirectional.only(start: 10.sp),
                width: 18.w,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: coloredText(
                      text: "+965",
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            spaceY(10.sp),
            coloredText(text: "email".tr),
            spaceY(5.sp),
            SendMessageTextField(
              initialValue:
                  c.contactModel != null ? c.contactModel!.email : null,
              onchanged: (s) {
                m.email = s;
              },
              keyBoardType: TextInputType.emailAddress,
              focusNode: FocusNode(),
              borderRadius: 10,
            ),
            spaceY(30.sp),
            primaryButton(
              onTap: () async {
                logSuccess(m.toJson());
                bool x = await c.updateContact(contact: m);
                if (x) {
                  Utils.doneDialog(
                    context: context,
                  );
                }
              },
              text: coloredText(text: "save".tr, color: Colors.white),
              color: Theme.of(context).colorScheme.primary,
            ),
            spaceY(10.sp),
          ],
        );
      });
  Widget tab2() => GetBuilder<AdminController>(builder: (c) {
        return Column(children: [
          // spaceY(10.sp),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CustomDropDownMenuButton(
          //       width: 40.0.w,
          //       items: ["item", "item2"]
          //           .map(
          //             (e) => DropdownMenuItem<String>(
          //               value: e,
          //               child: coloredText(text: e, color: Colors.black),
          //             ),
          //           )
          //           .toList(),
          //       onChanged: (p0) {},
          //       hint: "viewd".tr,
          //       borderc: Border.all(color: const Color(0xffE3E3E3)),
          //       borderRadius: BorderRadius.circular(20),
          //       padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          //     ),
          //     CustomDropDownMenuButton(
          //       width: 40.0.w,
          //       items: ["item", "item2"]
          //           .map(
          //             (e) => DropdownMenuItem<String>(
          //               value: e,
          //               child: coloredText(text: e, color: Colors.black),
          //             ),
          //           )
          //           .toList(),
          //       onChanged: (p0) {},
          //       hint: "sort by".tr,
          //       borderc: Border.all(color: const Color(0xffE3E3E3)),
          //       borderRadius: BorderRadius.circular(20),
          //       padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          //     ),
          //   ],
          // ),

          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => AdminMessageCard(
                        name: c.contactMessages[index].name!,
                        email: c.contactMessages[index].email!,
                        phone: c.contactMessages[index].phoneNumber!,
                        message: c.contactMessages[index].message!,
                      ),
                  separatorBuilder: (context, index) => spaceY(20.sp),
                  itemCount: c.contactMessages.length)),
        ]);
      });
}

class AdminMessageCard extends StatelessWidget {
  const AdminMessageCard({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });
  final String name;
  final String email;
  final String phone;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF8F8F8),
      ),
      child: Column(
        children: [
          _messageLine(title: "name".tr, content: name),
          spaceY(10.sp),
          GestureDetector(
              onTap: () {
                launchUrlString("tel://+965$phone");
              },
              child: _messageLine(title: "phone".tr, content: phone)),
          spaceY(10.sp),
          GestureDetector(
              onTap: () {
                launchUrlString("mailto:$email?subject=Khedmah%20Feedback");
              },
              child: _messageLine(
                  title: "email".tr,
                  content: email,
                  overflow: TextOverflow.ellipsis)),
          spaceY(10.sp),
          _messageLine(title: "message".tr, content: message),
        ],
      ),
    );
  }

  Row _messageLine(
      {required String title,
      required String content,
      TextOverflow? overflow}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 33.w,
          child: coloredText(text: "$title: ", color: Colors.grey),
        ),
        Expanded(
            child:
                coloredText(text: content, fontSize: 12.sp, overflow: overflow))
      ],
    );
  }
}
