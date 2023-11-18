import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/user%20profiles/admin_user_details.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/me.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class AdminUserProfilesPage extends StatefulWidget {
  const AdminUserProfilesPage({super.key});

  @override
  State<AdminUserProfilesPage> createState() => _AdminUserProfilesPageState();
}

class _AdminUserProfilesPageState extends State<AdminUserProfilesPage> {
  final AdminController _adminController = Get.find();
  @override
  void initState() {
    _adminController.getUserProfiles();
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
                    text: "user_profiles".tr,
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
                    SearchTextField(
                      onchanged: (s) {
                        if (s != null) {
                          _adminController.handleUserProfilesSearch(name: s);
                        }
                      },
                      hintText: "${"search".tr} ...",
                      prefixIcon: const Icon(
                        EvaIcons.search,
                        color: Color(0xffAFAFAF),
                      ),
                      // suffixIcon: GestureDetector(
                      //   onTap: () {},
                      //   child: const Image(
                      //     width: 15,
                      //     height: 15,
                      //     image: AssetImage("assets/images/filter-icon.png"),
                      //   ),
                      // ),
                    ),
                    spaceY(10.sp),
                    Expanded(
                      child: GetBuilder<AdminController>(builder: (c) {
                        return c.getUserProfilesFlag
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : c.userProfilesToShow.isEmpty
                                ? const Center(child: NoItemsWidget())
                                : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) =>
                                        AdminUserCard(
                                      img: c.userProfilesToShow[index]
                                          .userInformation!.personalPhoto!,
                                      name:
                                          c.userProfilesToShow[index].fullName!,
                                      phone: c.userProfilesToShow[index]
                                          .userInformation!.phone!,
                                      onTap: () async {
                                        Me? userProfile = await c.showAdminUser(
                                            id: c.userProfilesToShow[index].id!,
                                            indicator: true);
                                        if (userProfile != null) {
                                          Get.to(() => AdminUserDetailsPage(
                                                userProfile: userProfile,
                                              ));
                                        }
                                      },
                                      trailing: Theme(
                                        data: ThemeData(
                                            primaryColor: Colors.white),
                                        child: PopupMenuButton(
                                          constraints: BoxConstraints(
                                            minWidth: 2.0 * 56.0,
                                            maxWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          itemBuilder: (BuildContext cc) => [
                                            PopupMenuItem<int>(
                                              value: 0,
                                              child: Row(
                                                children: [
                                                  Icon(EvaIcons.slashOutline,
                                                      size: 15.sp),
                                                  spaceX(5.sp),
                                                  coloredText(
                                                      text:
                                                          c.userProfilesToShow[index]
                                                                      .block ==
                                                                  0
                                                              ? 'block'.tr
                                                              : "un_block".tr,
                                                      fontSize: 12.0.sp),
                                                ],
                                              ),
                                              onTap: () async {
                                                bool b = await c.blockProfile(
                                                  id: c
                                                      .userProfilesToShow[index]
                                                      .id!,
                                                  block:
                                                      c.userProfilesToShow[index]
                                                                  .block ==
                                                              0
                                                          ? 1
                                                          : 0,
                                                  userIndicator: 'user',
                                                );
                                                if (b) {
                                                  // ignore: use_build_context_synchronously
                                                  Utils.doneDialog(
                                                      context: context);
                                                }
                                              },
                                            ),
                                          ],
                                          child: const Icon(
                                            EvaIcons.moreVertical,
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Column(
                                      children: [
                                        spaceY(5.sp),
                                        const Divider(color: Color(0xffE5E5E5)),
                                        spaceY(5.sp),
                                      ],
                                    ),
                                    itemCount: c.userProfilesToShow.length,
                                  );
                      }),
                    ),
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

class AdminUserCard extends StatelessWidget {
  const AdminUserCard({
    super.key,
    required this.img,
    required this.name,
    required this.phone,
    this.trailing,
    this.onTap,
  });
  final String img;
  final String name;
  final String phone;
  final Widget? trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 55.0.sp,
            height: 55.0.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
            ),
          ),
          spaceX(10.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredText(text: name, fontSize: 12.0.sp),
              spaceY(10.sp),
              coloredText(
                  text: phone,
                  fontSize: 11.0.sp,
                  color: const Color(0xff919191)),
            ],
          ),
          const Spacer(),
          trailing ?? Container()
        ],
      ),
    );
  }
}
