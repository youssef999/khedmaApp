import 'dart:developer' as developer;
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/login_page.dart';
import 'package:khedma/Utils/notification_service.dart';
import 'package:khedma/models/send_items_model.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:local_auth_android/local_auth_android.dart';
// import 'package:local_auth_ios/local_auth_ios.dart';
// import 'package:path_provider/path_provider.dart';

// /
class Utils {
  static Future<void> takeContainer(
      ScreenshotController controller, String imageName) async {
    // ScreenshotController controller = ScreenshotController();
    // try {
    //   controller.capture().then(
    //     (value) async {
    //       final pickedDirectory = await FlutterFileDialog.pickDirectory();
    //       if (pickedDirectory != null) {
    //         logSuccess("asda");

    //         await FlutterFileDialog.saveFileToDirectory(
    //           directory: pickedDirectory,
    //           data: value!,
    //           mimeType: "image/png",
    //           fileName: imageName,
    //           replace: true,
    //           // params: SaveFileDialogParams(
    //           //     localOnly: false,
    //           //     // directory: pickedDirectory,
    //           //     data: value,
    //           //     // mimeType: mime(outputFile),
    //           //     fileName: imageName
    //           //     // replace: true,
    //           //     ),
    //         );
    //       }
    //     },
    //   );
    // } catch (e) {
    //   logError(e);
    // }
  }

  static bool getDeviceType() {
    // final data = MediaQueryData.fromView(View.of(Get.context! ));
    // return data.size.shortestSide < 600 ? 'phone' : 'tablet';
    return SizerUtil.deviceType == DeviceType.tablet;
  }

  static Widget kwdSuffix(String text) => SizedBox(
        width: 60.sp,
        // height: 40.sp,
        child: Center(
          child: coloredText(
              text: text,
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(Get.context!).colorScheme.primary.withOpacity(0.6)),
        ),
      );
  Future<XFile?> selectImageSheet() async {
    XFile? image;
    List<SendMenuItems> menuItems = [
      SendMenuItems(
        text: "camera".tr,
        icons: EvaIcons.camera,
        color: Colors.red,
        onTap: () async {
          bool b = await Utils.checkPermissionCamera();
          if (b) {
            image = await ImagePicker().pickImage(
                source: ImageSource.camera,
                maxHeight: 480,
                maxWidth: 640,
                imageQuality: 50);
          }
          Get.back();
        },
      ),
      SendMenuItems(
        text: "gallery".tr,
        icons: EvaIcons.image,
        color: Colors.green,
        onTap: () async {
          bool b = await Utils.checkPermissionGallery();
          if (b) {
            image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                maxHeight: 480,
                maxWidth: 640,
                imageQuality: 50);
          }
          Get.back();
        },
      )
    ];

    await showModalBottomSheet(
        context: Get.context!,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 4,
            color: const Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  spaceY(16),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  spaceY(10),
                  ListView.builder(
                    itemCount: menuItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          onTap: menuItems[index].onTap,
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: menuItems[index].color.shade50,
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              menuItems[index].icons,
                              size: 20,
                              color: menuItems[index].color.shade400,
                            ),
                          ),
                          title: Text(menuItems[index].text),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });

    return image;
  }

  static int age(DateTime today, DateTime dob) {
    final year = today.year - dob.year;

    return year;
  }

  static NotificationService notificationService = NotificationService();
  static void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        // Navigator.push(Get.context!,
        //     MaterialPageRoute(builder: (context) => NotificationsPage()));
      });
  // static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // static Future initializeNotifications(
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()!
  //       .requestPermission();
  //   var androidInitialize =
  //       const AndroidInitializationSettings('mipmap/ic_launcher');
  //   var iOSInitialize = const DarwinInitializationSettings();
  //   var initializationsSettings =
  //       InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  //   await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // }

  // static Future showBigTextNotification(
  //     {var id = 0,
  //     required String title,
  //     required String body,
  //     var payload,
  //     required FlutterLocalNotificationsPlugin fln}) async {
  //   AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       const AndroidNotificationDetails(
  //     'you_can_name_it_whatever1',
  //     'channel_name',
  //     playSound: true,
  //     // sound: RawResourceAndroidNotificationSound('notification'),
  //     importance: Importance.max,

  //     priority: Priority.high,
  //   );

  //   var not = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: DarwinNotificationDetails());
  //   await fln.show(0, title, body, not);
  // }

//   // static Future<void> takeContainer(
//   //     ScreenshotController controller, String imageName) async {
//   //   controller.capture().then((value) async {
//   //     final filePath = await FlutterFileDialog.saveFile(
//   //       params: SaveFileDialogParams(
//   //           localOnly: false,
//   //           // directory: pickedDirectory,
//   //           data: value,
//   //           // mimeType: mime(outputFile),
//   //           fileName: imageName
//   //           // replace: true,
//   //           ),
//   //     );
//   //   });
//   // }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) return null;
    final numreg = RegExp(r'\d');
    final bigAlphareg = RegExp(r'[A-Z]');
    final smallAlpgareg = RegExp(r'[a-z]');
    if (value.length < 8) {
      return ("password should be at least 8 characters");
    } else if (value.length > 20) {
      return ("password should be no more 20 characters");
    } else if (!numreg.hasMatch(value)) {
      return ("password should have at least 1 numbers");
    } else if (!smallAlpgareg.hasMatch(value)) {
      return ("password should have at least 1 small letter");
    } else if (!bigAlphareg.hasMatch(value)) {
      return ("password should have at least 1 capital letter");
    }
    return null;
  }

  static void showSnackBar({required String message, double? fontSize}) {
    final snackBar = SnackBar(
      content: coloredText(
        fontSize: fontSize,
        text: message,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

//   static Future<bool> reLoginHelper(DioError e) async {
//     logError(e.response!.data["message"] == "Please Login");
//     // var email = await AuthService().loadEmail();
//     // var password = await AuthService().loadPassword();
//     // var rem = await AuthService().loadRememberMe();
//     // if (email != "" && password != "") {
//     //   await AuthService().login(email, password, rem);
//     //   return true;
//     // } else {
//     MyDialogs.showWarningDialoge(
//         onProceed: () {
//           Get.offAll(() => LoginPage());
//         },
//         message: "you_have_to_login_again".tr,
//         yesBTN: "login".tr);
//     return false;
//     // }
//   }
  final Dio dio = Dio();
  Utils() {
    dio.options.headers['content-Type'] = 'multipart/form-data';

    readToken().then(
        (value) => dio.options.headers["authorization"] = "Bearer $value");
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  static const _storage = FlutterSecureStorage();
  static Future<String?> readToken() async {
    String? value = await _storage.read(key: "token");
    return value;
  }

  static Future deleteToken() async {
    await _storage.delete(key: "token");
  }

  static Future saveToken({required String token}) async {
    await _storage.write(key: "token", value: token);
  }

  static Future<String?> readFingerprint() async {
    String? value = await _storage.read(key: "fingerprint");
    return value;
  }

  static Future deleteFingerprint() async {
    await _storage.delete(key: "fingerprint");
  }

  static Future saveFingerprint({required String fingerpring}) async {
    await _storage.write(key: "fingerprint", value: fingerpring);
  }

  static Future<String?> readFBToken() async {
    String? value = await _storage.read(key: "fb_token");
    return value;
  }

  static Future deleteFBToken() async {
    await _storage.delete(key: "fb_token");
  }

  static Future saveFBToken({required String token}) async {
    await _storage.write(key: "fb_token", value: token);
  }

  static Future<String?> readLanguage() async {
    String? value = await _storage.read(key: "language");
    return value;
  }

  static Future deleteLanguage() async {
    await _storage.delete(key: "language");
  }

  static Future saveLanguage({required String language}) async {
    await _storage.write(key: "language", value: language);
  }

  static Future<String?> readRemmemberMe() async {
    String? value = await _storage.read(key: "rem");
    return value;
  }

  static Future deleteRemmemberMe() async {
    await _storage.delete(key: "rem");
  }

  static Future saveRemmemberMe({required String rem}) async {
    await _storage.write(key: "rem", value: rem);
  }

  static void showDialogBox(
      {required BuildContext context,
      List<Widget>? actions,
      Widget? content,
      Widget? title}) {
    showDialog<void>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: title,
            content: SizedBox(
              width: 100.w,
              child: content,
            ),
            actions: actions,
            surfaceTintColor: Colors.white,
          );
        });
  }

  static void circularIndicator() {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
  }

  static Future<bool> checkPermissionCamera() async {
    // FocusScope.of(context).requestFocus(FocusNode());

    PermissionStatus? statusCamera = await Permission.camera.request();

    bool isGranted = statusCamera == PermissionStatus.granted;
    return isGranted;
  }

  static Future<bool> checkPermissionGallery() async {
    // FocusScope.of(context).requestFocus(FocusNode());
    PermissionStatus? statusPhotos;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        /// use [Permissions.storage.status]
        ///
        statusPhotos = await Permission.storage.request();
      } else {
        /// use [Permissions.photos.status]
        statusPhotos = await Permission.photos.request();
      }
    }

    bool isGranted = statusPhotos == PermissionStatus.granted;
    return isGranted;
  }

  static void customDialog(
      {TextStyle? titleStyle,
      CustomViewPosition? customViewPosition,
      required Widget child,
      String? title,
      Color? color,
      List<Widget>? actions,
      required BuildContext context,
      dynamic Function(dynamic)? onClose}) {
    Dialogs.materialDialog(
      onClose: onClose,

      // barrierColor: Colors.red,
      titleStyle: titleStyle ??
          coloredText(
                  text: "text", textAlign: TextAlign.start, fontSize: 13.0.sp)
              .style!,
      customViewPosition:
          customViewPosition ?? CustomViewPosition.BEFORE_MESSAGE,
      customView: Theme(
        data: ThemeData(
            useMaterial3: false,
            dialogTheme: DialogTheme(
                surfaceTintColor: Colors.red,
                backgroundColor: Theme.of(context).colorScheme.primary)),
        child: child,
      ),
      title: title,
      color: color ?? Colors.white,
      context: context,
      actions: actions,
      dialogWidth: 100.0.w,
    );
  }

  static void doneDialog(
      {TextStyle? titleStyle,
      int backTimes = 1,
      CustomViewPosition? customViewPosition,
      Color? color,
      required BuildContext context,
      void Function()? onTap,
      dynamic Function(dynamic)? onClose}) {
    Dialogs.materialDialog(
      onClose: onClose,

      // barrierColor: Colors.red,
      titleStyle: titleStyle ??
          coloredText(
                  text: "text", textAlign: TextAlign.start, fontSize: 13.0.sp)
              .style!,
      customViewPosition:
          customViewPosition ?? CustomViewPosition.BEFORE_MESSAGE,
      customView: Theme(
        data: Theme.of(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceY(20),
              Icon(
                EvaIcons.checkmarkCircle,
                color: Theme.of(context).colorScheme.secondary,
                size: 40.sp,
              ),
              spaceY(20),
              coloredText(text: "done".tr, fontSize: 12.0.sp),
              coloredText(
                text: "successfully".tr,
                fontSize: 14.0.sp,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
      color: color ?? Colors.white,
      context: context,
      actions: [
        primaryButton(
          onTap: onTap ??
              () {
                for (var i = 0; i < backTimes; i++) {
                  Get.back();
                }
              },
          width: 40.0.w,
          height: 50,
          radius: 10.w,
          color: Theme.of(context).colorScheme.primary,
          text: coloredText(
            text: "ok".tr,
            color: Colors.white,
          ),
        ),
      ],
      dialogWidth: 100.0.w,
    );
  }

  static void loginFirstDialoge(
      {TextStyle? titleStyle,
      int backTimes = 1,
      CustomViewPosition? customViewPosition,
      Color? color,
      required BuildContext context,
      dynamic Function(dynamic)? onClose}) {
    Dialogs.materialDialog(
      onClose: onClose,

      // barrierColor: Colors.red,
      titleStyle: titleStyle ??
          coloredText(
                  text: "text", textAlign: TextAlign.start, fontSize: 13.0.sp)
              .style!,
      customViewPosition:
          customViewPosition ?? CustomViewPosition.BEFORE_MESSAGE,
      customView: Theme(
        data: Theme.of(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceY(20),
              Icon(
                EvaIcons.checkmarkCircle,
                color: Theme.of(context).colorScheme.secondary,
                size: 40.sp,
              ),
              spaceY(20),
              coloredText(text: "login_first".tr, fontSize: 12.0.sp),
              spaceY(20),
            ],
          ),
        ),
      ),
      color: color ?? Colors.white,
      context: context,
      actions: [
        primaryButton(
          onTap: () {
            Get.offAll(() => const LoginPage());
          },
          width: 40.0.w,
          height: 50,
          radius: 10.w,
          color: Theme.of(context).colorScheme.primary,
          text: coloredText(
            text: "ok".tr,
            color: Colors.white,
          ),
        ),
      ],
      dialogWidth: 100.0.w,
    );
  }

  void rateDialoge({
    required BuildContext context,
    void Function()? onOk,
    required int companyId,
  }) {
    int rate = 0;
    String desc = "";
    final GlobalController _globalController = Get.find();

    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: coloredText(
                text: "rate_us".tr,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    allowHalfRating: false,
                    initialRating: 0,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return const Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return const Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        default:
                          return const Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                    },
                    onRatingUpdate: (rating) {
                      rate = rating.toInt();
                    },
                  ),
                  spaceY(10.sp),
                  TextFormField(
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
                ],
              ),
            ),
            actions: [
              primaryButton(
                onTap: () async {
                  await _globalController.storeReview(
                      companyId: companyId, reviewValue: rate, review: desc);
                  Get.back();
                },
                width: 40.0.w,
                height: 50,
                radius: 10.w,
                color: Theme.of(context).colorScheme.primary,
                text: coloredText(
                  text: "ok".tr,
                  color: Colors.white,
                ),
              ),
            ],
            surfaceTintColor: Colors.white,
          );
        });
  }

  void reportDialoge({
    required BuildContext context,
    void Function()? onOk,
    required int companyId,
  }) {
    String desc = "";
    final GlobalController _globalController = Get.find();

    showDialog<void>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Center(
              child: coloredText(
                text: "report".tr,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      desc = value;
                    },
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length < 15)
                        return "must be at least 15 characters";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
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
                ],
              ),
            ),
            actions: [
              primaryButton(
                onTap: () async {
                  Get.back();
                  bool b = await _globalController.storeReport(
                    companyId: companyId,
                    report: desc,
                  );
                  logError(b);
                  if (b) {
                    Utils.doneDialog(context: context);
                  }
                },
                width: 40.0.w,
                height: 50,
                radius: 10.w,
                color: Theme.of(context).colorScheme.primary,
                text: coloredText(
                  text: "ok".tr,
                  color: Colors.white,
                ),
              ),
            ],
            surfaceTintColor: Colors.white,
          );
        });
  }
}

// class AppUtil {
//   static Future<String> createFolderInAppDocDir(String folderName) async {
//     //Get this App Document Directory
//     final Directory? _appDocDir = await getExternalStorageDirectory();
//     //App Document Directory + folder name
//     final Directory _appDocDirFolder = Directory(
//         '${_appDocDir!.parent.parent.parent.parent.path}/$folderName/');

//     if (await _appDocDirFolder.exists()) {
//       //if folder already exists return path
//       logSuccess("existed");
//       return _appDocDirFolder.path;
//     } else {
//       //if folder not exists create folder and then return its path
//       try {
//         logWarning(_appDocDirFolder.path);
//         final Directory _appDocDirFolder =
//             await _appDocDirFolder.create(recursive: true);
//         logSuccess("created");
//         return _appDocDirFolder.path;
//       } catch (e) {
//         logError(e);
//         final Directory _appDocDirFolder =
//             Directory('${_appDocDir.path}/$folderName/');
//         if (await _appDocDirFolder.exists()) {
//           //if folder already exists return path
//           logSuccess("existed");
//           return _appDocDirFolder.path;
//         } else {
//           final Directory _appDocDirFolder =
//               await _appDocDirFolder.create(recursive: true);
//           logSuccess("created");
//           return _appDocDirFolder.path;
//         }
//       }
//     }
//   }
// }

// class LocalAuthApi {
//   static final _auth = LocalAuthentication();

//   static Future<bool> hasBiometrics() async {
//     try {
//       return await _auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }

//   static Future<List<BiometricType>> getBiometrics() async {
//     try {
//       return await _auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       return <BiometricType>[];
//     }
//   }

//   static Future<bool> authenticate() async {
//     final isAvailable = await hasBiometrics();
//     if (!isAvailable) return false;

//     try {
//       return await _auth.authenticate(
//           localizedReason: 'Scan Fingerprint to Authenticate',
//           options: const AuthenticationOptions(
//             useErrorDialogs: true,
//           ),
//           authMessages: const <AuthMessages>[
//             AndroidAuthMessages(
//               signInTitle: 'Oops! Biometric authentication required!',
//               cancelButton: 'No thanks',
//             ),
//             IOSAuthMessages(
//               cancelButton: 'No thanks',
//             ),
//           ]);
//     } on PlatformException catch (e) {
//       logError(e.message!);
//       return false;
//     }
//   }
// }

// // class Noti {
// //   static Future initialize(
// //       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
// //     var androidInitialize =
// //          AndroidInitializationSettings('mipmap/ic_launcher');
// //     var iOSInitialize =  DarwinInitializationSettings();
// //     var initializationsSettings =  InitializationSettings(
// //         android: androidInitialize, iOS: iOSInitialize);
// //     await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
// //   }

// //   static Future showBigTextNotification(
// //       {var id = 0,
// //       required String title,
// //       required String body,
// //       var payload,
// //       required FlutterLocalNotificationsPlugin fln}) async {
// //     AndroidNotificationDetails androidPlatformChannelSpecifics =
// //          AndroidNotificationDetails(
// //       'you_can_name_it_whatever1',
// //       'channel_name',

// //       playSound: true,
// //       // sound: RawResourceAndroidNotificationSound('notification'),
// //       importance: Importance.max,
// //       priority: Priority.high,
// //     );

// //     var not = NotificationDetails(
// //         android: androidPlatformChannelSpecifics,
// //         iOS: DarwinNotificationDetails());
// //     await fln.show(0, title, body, not);
// //   }
// // }

void logSuccess(Object msg) {
  developer.log('\x1B[32m${msg.toString()}\x1B[0m');
}

void logInfo(Object msg) {
  developer.log('\x1B[34m${msg.toString()}\x1B[0m');
}

void logWarning(Object msg) {
  developer.log('\x1B[33m${msg.toString()}\x1B[0m');
}

void logError(Object msg) {
  developer.log('\x1B[31m${msg.toString()}\x1B[0m');
}

Widget spaceX(double x) {
  return SizedBox(width: x);
}

Widget spaceY(double y) {
  return SizedBox(height: y);
}

Widget primaryButton(
    {required Widget text,
    Color? color,
    double? radius,
    double? width,
    double? height,
    Gradient? gradient,
    void Function()? onTap,
    AlignmentGeometry? alignment}) {
  return Align(
    alignment: alignment ?? Alignment.center,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15),
          gradient: gradient,
          color: color,
        ),
        width: width ?? 60.0.w,
        height: height ?? 45.0.sp,
        child: Center(child: text),
      ),
    ),
  );
}

Widget primaryBorderedButton(
    {required Widget text,
    required Color color,
    double? radius,
    double? width,
    double? height,
    void Function()? onTap,
    AlignmentGeometry? alignment}) {
  return Align(
    alignment: alignment ?? Alignment.center,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15),
          border: Border.all(color: color),
        ),
        width: width ?? 60.0.w,
        height: height ?? 45.0.sp,
        child: Center(child: text),
      ),
    ),
  );
}

Text coloredText(
    {required String text,
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? fontSize,
    TextAlign? textAlign,
    TextDirection? textDirection,
    TextOverflow? overflow,
    TextStyle? textstyle}) {
  return Text(
    text,
    textAlign: textAlign,
    softWrap: true,
    textDirection: textDirection,
    overflow: overflow,
    style: textstyle ??
        (Get.locale == const Locale('en', 'US')
            ? GoogleFonts.poppins(
                color: color ?? Colors.black,
                fontSize: fontSize ?? 13.0.sp,
                fontWeight: fontWeight,
                decoration: decoration,
                decorationColor: color,
              )
            : GoogleFonts.cairo(
                color: color ?? Colors.black,
                fontSize: fontSize ?? 13.0.sp,
                fontWeight: fontWeight,
                decoration: decoration,
                decorationColor: color,
              )),
  );
}

enum EmployeeType { recruitment, clean }

class Clipp extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double firstFactor = 0;
    double secondFactor = size.height - 35;
    double thirdFactor = 0;
    double fourthFactor = size.height - 35;
    path.moveTo(firstFactor, 0);
    path.quadraticBezierTo(thirdFactor, firstFactor, 0, firstFactor);
    path.lineTo(0, fourthFactor);
    path.quadraticBezierTo(
      size.width / 3,
      size.height,
      size.width,
      secondFactor,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
