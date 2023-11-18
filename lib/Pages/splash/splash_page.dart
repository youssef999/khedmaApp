// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khedma/Admin/controllers/admin_controller.dart';
import 'package:khedma/Admin/pages/Addressess/controller/addressess_controller.dart';
import 'package:khedma/Admin/pages/Company%20Types/controller/company_types_controller.dart';
import 'package:khedma/Admin/pages/admin_home.dart';
import 'package:khedma/Admin/pages/categories/controller/categories_controller.dart';
import 'package:khedma/Admin/pages/dropdowns/controller/dropdown_controller.dart';
import 'package:khedma/Admin/pages/jobs/controller/jobs_controller.dart';
import 'package:khedma/Admin/pages/languages/controller/languages_controller.dart';
import 'package:khedma/Pages/HomePage/company%20home/company_home_page.dart';
import 'package:khedma/Pages/HomePage/controllers/advertisment_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/companies_controller.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/HomePage/user%20home/user_home_page.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/Select%20Language%20Page/select_language_page.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/controller/auth_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/forget%20password/controller/password_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/login_page.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:local_auth/local_auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final CompanyTypesController _companyTypesController =
      Get.put(CompanyTypesController());
  final EmployeesController _employeesController =
      Get.put(EmployeesController());
  final CompaniesController _companiesController =
      Get.put(CompaniesController());
  final GlobalController _globalController = Get.find();
  final NotificationController _notificationController = Get.find();

  AdminController _adminHomeController = Get.put(AdminController());
  LanguagesController _langsController = Get.put(LanguagesController());
  AddressessController _addressessController = Get.put(AddressessController());
  DropDownsController _dropDownsController = Get.put(DropDownsController());

  final JobsController _jobsController = Get.put(JobsController());
  final CategoriesController _categoriesController =
      Get.put(CategoriesController());
  final AdvertismentController _advertismentController =
      Get.put(AdvertismentController());
  final AuthController _authController = Get.put(AuthController());
  final ChatController _chatController = Get.find();
  final PasswordController _passwordController = Get.put(PasswordController());

  @override
  void initState() {
    super.initState();
    _globalController.getBanks();
    _globalController.getCountries();
    _globalController.getCities();
    _globalController.getRegions();
    _globalController.getCurrencySymbols();
    _companyTypesController.getCompanyTypes();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        String? rem = await Utils.readRemmemberMe();
        String? lang = await Utils.readLanguage();
        String? fingerPrint = await Utils.readFingerprint();
        bool localAuthenticated = true;
        if (fingerPrint != null) {
          localAuthenticated = await localAuth();
        }

        if (localAuthenticated) {
          if (lang == null) {
            Get.offAll(
              () => SelectLanguagePage(),
            );
          } else {
            await _globalController.setLocale();
            bool x = await _globalController.getMe();

            if (x) {
              if (rem == "yes") {
                if (_globalController.me.userType == "user") {
                  Get.offAll(
                    () => const UserHomePage(),
                  );
                } else if (_globalController.me.userType == "company") {
                  Get.offAll(
                    () => const CompanyHomePage(),
                  );
                } else if (_globalController.me.userType == "admin") {
                  Get.offAll(
                    () => AdminHomePage(),
                  );
                } else {
                  Get.off(() => LoginPage());
                }
              } else {
                Get.off(() => LoginPage());
              }
            } else {
              Get.off(() => LoginPage());
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash_background.png"),
              fit: BoxFit.cover),
        ),
        child: Align(
          child: Container(
            width: w / 1.5,
            height: h / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash_logo.png"),
                  fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> localAuth() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    // final bool canAuthenticate =
    //     canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (canAuthenticateWithBiometrics) {
      logWarning("can auth");
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        for (var i in availableBiometrics) {
          logWarning(i.name);
        }

        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'localizedReason'.tr,
          );
          return didAuthenticate;
        } on PlatformException catch (e) {
          logError(e.toString());
          return false;
        }
      }
    }
    return false;
  }
}
