import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/models/drawer_menu_item.dart';
import 'package:khedma/Admin/pages/Addressess/admin_addresses_page.dart';
import 'package:khedma/Admin/pages/Company%20Types/admin_company_types_page.dart';
import 'package:khedma/Admin/pages/about/admin_about_page.dart';
import 'package:khedma/Admin/pages/account%20statment/admin_account_statment_page.dart';
import 'package:khedma/Admin/pages/admin_main_page.dart';
import 'package:khedma/Admin/pages/advertisments/admin_advertisment_page.dart';
import 'package:khedma/Admin/pages/bookings/admin_medicals_page.dart';
import 'package:khedma/Admin/pages/categories/admin_categories_page.dart';
import 'package:khedma/Admin/pages/commissions/admin_commissions_page.dart';
import 'package:khedma/Admin/pages/company%20profiles/admin_company_profiles_page.dart';
import 'package:khedma/Admin/pages/contact/admin_contact_page.dart';
import 'package:khedma/Admin/pages/dropdowns/admin_dropdowns_page.dart';
import 'package:khedma/Admin/pages/languages/admin_languages_page.dart';
import 'package:khedma/Admin/pages/menu_page.dart';
import 'package:khedma/Admin/pages/refunds/admin_refunds_page.dart';
import 'package:khedma/Admin/pages/reports/admin_reports_page.dart';
import 'package:khedma/Admin/pages/signiture/admin_signiture.dart';
import 'package:khedma/Admin/pages/user%20profiles/admin_user_profiles_page.dart';
import 'package:khedma/Admin/pages/zoom_drawer_controller.dart';
import 'package:sizer/sizer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  MyZoomDrawerController zoomDrawerController =
      Get.put(MyZoomDrawerController());
  DrawerMenuItem _currnetAdminMenuItem = MyAdminMenuItems.userProfiles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: GetBuilder<MyZoomDrawerController>(
        builder: (c) {
          return ZoomDrawer(
            angle: 0,
            borderRadius: 30,
            controller: c.zoomDrawerController,
            menuScreenWidth: 60.0.w,
            isRtl: Get.locale != const Locale('en', 'US'),
            slideWidth: 60.0.w,
            menuScreen: MenuPage(
              currentItem: _currnetAdminMenuItem,
              onSelectedItem: (value) {
                setState(() {
                  _currnetAdminMenuItem = value;
                });
                // zoomDrawerController.zoomDrawerController.close!();
                getAdminScreen();
              },
            ),
            mainScreen: AdminMainPage(),
          );
        },
      ),
    );
  }

//   void getScreen() {
//     switch (_currnetMenuItem) {
//       case MyMenuItems.invoices:
//         if (_globalDataController.me.invoices == 1 ||
//             _globalDataController.me.isSuperAdmin == 1)
//           Get.to(() => InvoicesPage());
//         else
//           GFToast.showToast("permissions_text".tr, context,
//               toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;
//       case MyMenuItems.wallet:
//         // if (_globalDataController.me.wallet == 1 ||
//         //     _globalDataController.me.isSuperAdmin == 1)
//         Get.to(() => WalletMainPage());
//         // else
//         //   GFToast.showToast("permissions_text".tr, context,
//         //       toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;
//       case MyMenuItems.sPay:
//         Get.to(() => SPayPage());

//         break;
//       case MyMenuItems.orderList:
//         if (_globalDataController.me.orders == 1 ||
//             _globalDataController.me.isSuperAdmin == 1)
//           Get.to(() => OrderListsMainPage());
//         else
//           GFToast.showToast("permissions_text".tr, context,
//               toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;
//       case MyMenuItems.products:
//         if (_globalDataController.me.products == 1 ||
//             _globalDataController.me.isSuperAdmin == 1)
//           Get.to(() => ProductsMainPage());
//         else
//           GFToast.showToast("permissions_text".tr, context,
//               toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;
//       case MyMenuItems.customers:
//         if (_globalDataController.me.customers == 1 ||
//             _globalDataController.me.isSuperAdmin == 1)
//           Get.to(() => CustomersMainPage());
//         else
//           GFToast.showToast("permissions_text".tr, context,
//               toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;
//       // case MyMenuItems.commissions:
//       //   if (_globalDataController.me.commissions == 1 ||
//       //       _globalDataController.me.isSuperAdmin == 1)
//       //     Get.to(() => CommisionsMainPage());
//       //   else
//       //     GFToast.showToast("permissions_text".tr, context,
//       //         toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//       //   break;
//       case MyMenuItems.accountStatement:
//         if (_globalDataController.me.accountStatements == 1 ||
//             _globalDataController.me.isSuperAdmin == 1)
//           Get.to(() => AccountStateMainPage());
//         else
//           GFToast.showToast("permissions_text".tr, context,
//               toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;

//       case MyMenuItems.multiFactorAuthentication:
//         Get.to(() => MultiFactorAuthMainPage());

//         break;
//       case MyMenuItems.contact:
//         Get.to(() => ContactPage());

//         break;
//       case MyMenuItems.about:
//         Get.to(() => AboutSafqa());

//         break;
//       case MyMenuItems.settings:
//         Get.to(() => SettingsPage());

//         break;
//       case MyMenuItems.refunds:
//         if (_globalDataController.me.refund == 1 ||
//             _globalDataController.me.isSuperAdmin == 1)
//           Get.to(() => RefundsMainPage());
//         else
//           GFToast.showToast("permissions_text".tr, context,
//               toastDuration: 2, toastPosition: GFToastPosition.BOTTOM);
//         break;

//       default:
//         MainPage();
//     }
//   }

  void getAdminScreen() {
    switch (_currnetAdminMenuItem) {
      case MyAdminMenuItems.userProfiles:
        Get.to(() => const AdminUserProfilesPage());
        break;
      case MyAdminMenuItems.companyProfiles:
        Get.to(() => const AdminCompanyProfilesPage());
        break;
      case MyAdminMenuItems.categories:
        Get.to(() => const AdminCategoriesPage());
        break;
      case MyAdminMenuItems.medicalRequests:
        Get.to(() => const AdminMedicalRequests());
        break;
      case MyAdminMenuItems.advertisements:
        Get.to(() => const AdminAdvertismentsPage());
        break;
      case MyAdminMenuItems.acountStatment:
        Get.to(() => const AdminAccountStatmentPage());
        break;
      case MyAdminMenuItems.refund:
        Get.to(() => const AdminRefundsPage());
        break;
      case MyAdminMenuItems.companyTypes:
        Get.to(() => const AdminCompanyTypesPage());
        break;
      case MyAdminMenuItems.reportPage:
        Get.to(() => const AdminReportsPage());
        break;
      case MyAdminMenuItems.addresses:
        Get.to(() => const AdminAddressesPage());
        break;
      case MyAdminMenuItems.languages:
        Get.to(() => const AdminLanguagesPage());
        break;
      case MyAdminMenuItems.contactUs:
        Get.to(() => const AdminContactUsPage());
        break;
      case MyAdminMenuItems.about:
        Get.to(() => const AdminAboutPage());
        break;
      case MyAdminMenuItems.commissions:
        Get.to(() => const AdminCommissionsPage());
        break;
      case MyAdminMenuItems.dropDowns:
        Get.to(() => const AdminDropDownsPage());
        break;
      case MyAdminMenuItems.signiture:
        Get.to(() => const AdminSigniturePage());
        break;

      default:
        break;
    }
  }
}
