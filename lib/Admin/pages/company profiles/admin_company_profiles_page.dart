import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/company%20profiles/admin_company_details.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/me.dart';
import 'package:khedma/widgets/no_items_widget.dart';
import 'package:khedma/widgets/search_text_field.dart';
import 'package:sizer/sizer.dart';

class AdminCompanyProfilesPage extends StatefulWidget {
  const AdminCompanyProfilesPage({super.key});

  @override
  State<AdminCompanyProfilesPage> createState() =>
      _AdminCompanyProfilesPageState();
}

class _AdminCompanyProfilesPageState extends State<AdminCompanyProfilesPage> {
  final AdminController _adminController = Get.find();
  @override
  void initState() {
    _adminController.getCompanyProfiles();
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
                    text: "company_profiles".tr,
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
                          _adminController.handleCompanyProfilesSearch(name: s);
                        }
                      },
                      hintText: "${"search".tr} ...",
                      prefixIcon: const Icon(
                        EvaIcons.search,
                        color: Color(0xffAFAFAF),
                      ),
                    ),
                    spaceY(10.sp),
                    Expanded(
                      child: GetBuilder<AdminController>(builder: (c) {
                        return c.getCompanyProfilesFlag
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : c.companyProfilesToShow.isEmpty
                                ? const Center(
                                    child: NoItemsWidget(),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) =>
                                        AdminCompanyCard(
                                      img:
                                          // ignore: prefer_interpolation_to_compose_strings
                                          // "https://khdmah.online/api/images/company/logo/" +
                                          c.companyProfilesToShow[index]
                                              .companyInformation!.companyLogo,
                                      name: c.companyProfilesToShow[index]
                                          .fullName!,
                                      phone: c.companyProfilesToShow[index]
                                          .companyInformation!.companyPhone!,
                                      onTap: () async {
                                        Me? companyProfile =
                                            await c.showAdminCompany(
                                                id: c
                                                    .companyProfilesToShow[
                                                        index]
                                                    .id!,
                                                indicator: true);
                                        if (companyProfile != null) {
                                          Get.to(() => AdminCompanyDetailsPage(
                                                companyProfile: companyProfile,
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
                                                          c.companyProfilesToShow[index]
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
                                                      .companyProfilesToShow[
                                                          index]
                                                      .id!,
                                                  block:
                                                      c.companyProfilesToShow[index]
                                                                  .block ==
                                                              0
                                                          ? 1
                                                          : 0,
                                                  userIndicator: 'company',
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
                                    itemCount: c.companyProfilesToShow.length,
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

class AdminCompanyCard extends StatelessWidget {
  const AdminCompanyCard({
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
          Spacer(),
          trailing ?? Container()
        ],
      ),
    );
  }
}
