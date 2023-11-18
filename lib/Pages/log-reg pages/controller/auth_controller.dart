import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/firebase_api.dart';
import 'package:path/path.dart';

import '../../../Utils/end_points.dart';
import '../models/company_register_model.dart';
import '../models/user_register_model.dart';

class AuthController extends GetxController {
  Dio dio = Utils().dio;
  static final List<String> _scopes = <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/userinfo.profile',
    // "https://www.googleapis.com/auth/user.gender.read",
    // "https://www.googleapis.com/auth/user.birthday.read",
  ];
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: _scopes,
  );
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  GoogleSignInAccount? get currentUser => _currentUser;
  bool get isAuthorized => _isAuthorized;

  static bool needCompleteData(String? token) {
    if (token == null) return false;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    logSuccess(decodedToken);
    return decodedToken['complite_data'] != null;
  }

  NotificationController _notificationController = Get.find();
  Future handleGoogleSignIn(
      {required bool saveToken, required bool login}) async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      await FirebaseApi().initNotifications(_notificationController);

      GoogleSignInAuthentication auth = await user!.authentication;
      if (auth.accessToken != null) {
        Get.dialog(const Center(
          child: CircularProgressIndicator(),
        ));
        String? fcsToken = await Utils.readFBToken();
        logError("accessToken: " + auth.accessToken.toString());
        logError("fcsToken: " + fcsToken.toString());
        var res = await dio.post(EndPoints.loginGoogle,
            options: Options(headers: {
              "accessToken": auth.accessToken,
              "fcsToken": fcsToken,
            }));
        String token = res.data["access_token"];
        logError(res.data);
        await Utils.saveToken(token: token);
        GlobalController g = Get.find();
        if (login) await g.getMe();

        if (saveToken) {
          await Utils.saveRemmemberMe(rem: saveToken ? "yes" : "no");
          // String? x = await Utils.readRemmemberMe();
        }
        // await handleSignOut();
        Get.back();

        return token;
      } else {
        logError("login error");
      }
    } on DioException catch (error) {
      logError(error.response!.data);
      return null;
    }
  }

  Future userRegister({required UserRegisterData userRegisterData}) async {
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      userRegisterData.userType = "user";
      logSuccess(userRegisterData.toJson());
      final body = d.FormData.fromMap(userRegisterData.toJson());
      XFile? idPhotoNationality = userRegisterData.idPhotoNationality;
      XFile? personaPhoto = userRegisterData.personalPhoto;

      if (idPhotoNationality != null) {
        body.files.add(MapEntry(
          "id_photo_nationality",
          await d.MultipartFile.fromFile(
            idPhotoNationality.path,
            filename: idPhotoNationality.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (personaPhoto != null) {
        body.files.add(MapEntry(
          "personal_photo",
          await d.MultipartFile.fromFile(
            personaPhoto.path,
            filename: personaPhoto.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      await dio.post(
        EndPoints.registerUser,
        data: body,
        options: Options(
          headers: {"Accept": "application/json"},
        ),
      );

      Get.back();
      return true;
    } on DioException catch (error) {
      Get.back();
      logError(error.response!.data);

      // Utils.showSnackBar(message: error.response!.data["message"]);
      return error.response!.data;
    }
  }

  Future usercompleteData({required UserRegisterData userCompleteData}) async {
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      userCompleteData.userType = "user";
      logSuccess(userCompleteData.toJson());
      final body = d.FormData.fromMap(userCompleteData.toJson());
      XFile? idPhotoNationality = userCompleteData.idPhotoNationality;
      XFile? personaPhoto = userCompleteData.personalPhoto;

      if (idPhotoNationality != null) {
        body.files.add(MapEntry(
          "id_photo_nationality",
          await d.MultipartFile.fromFile(
            idPhotoNationality.path,
            filename: idPhotoNationality.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (personaPhoto != null) {
        body.files.add(MapEntry(
          "personal_photo",
          await d.MultipartFile.fromFile(
            personaPhoto.path,
            filename: personaPhoto.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      String? token = await Utils.readToken();

      await dio.post(EndPoints.completeDataUser,
          data: body,
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));

      Get.back();
      return true;
    } on DioException catch (error) {
      Get.back();
      logError(error.response!.data);

      // Utils.showSnackBar(message: error.response!.data["message"]);
      return error.response!.data;
    }
  }

  Future companycompleteData(
      {required CompanyRegisterData companyCompleteData}) async {
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      companyCompleteData.userType = "company";
      logSuccess(companyCompleteData.toJson());
      final body = d.FormData.fromMap(companyCompleteData.toJson());
      XFile? companyLogo = companyCompleteData.companyLogo;
      XFile? passportImage = companyCompleteData.passportImage;
      XFile? frontSideIdImage = companyCompleteData.frontSideIdImage;
      XFile? backSideIdImage = companyCompleteData.backSideIdImage;

      if (companyLogo != null) {
        body.files.add(MapEntry(
          "company_logo",
          await d.MultipartFile.fromFile(
            companyLogo.path,
            filename: companyLogo.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (passportImage != null) {
        body.files.add(MapEntry(
          "passport_image",
          await d.MultipartFile.fromFile(
            passportImage.path,
            filename: passportImage.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (frontSideIdImage != null) {
        body.files.add(MapEntry(
          "front_side_id_image",
          await d.MultipartFile.fromFile(
            frontSideIdImage.path,
            filename: frontSideIdImage.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (backSideIdImage != null) {
        body.files.add(MapEntry(
          "back_side_id_image",
          await d.MultipartFile.fromFile(
            backSideIdImage.path,
            filename: backSideIdImage.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }

      String? token = await Utils.readToken();

      await dio.post(EndPoints.completeDataCompany,
          data: body,
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));

      Get.back();
      return true;
    } on DioException catch (error) {
      Get.back();
      logError(error.response!.data);

      // Utils.showSnackBar(message: error.response!.data["message"]);
      return error.response!.data;
    }
  }

  Future companyRegister(
      {required CompanyRegisterData companyRegisterData}) async {
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      companyRegisterData.userType = "company";
      logSuccess(companyRegisterData.toJson());
      final body = d.FormData.fromMap(companyRegisterData.toJson());
      XFile? companyLogo = companyRegisterData.companyLogo;
      XFile? passportImage = companyRegisterData.passportImage;
      XFile? frontSideIdImage = companyRegisterData.frontSideIdImage;
      XFile? backSideIdImage = companyRegisterData.backSideIdImage;
      PlatformFile? commercialLicense = companyRegisterData.commercialLicense;

      PlatformFile? articlesOfAssociation =
          companyRegisterData.articlesOfAssociation;
      PlatformFile? signatureAuthorization =
          companyRegisterData.signatureAuthorization;
      File? signatureOfficial = companyRegisterData.signatureOfficial;

      if (companyLogo != null) {
        body.files.add(MapEntry(
          "company_logo",
          await d.MultipartFile.fromFile(
            companyLogo.path,
            filename: companyLogo.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (passportImage != null) {
        body.files.add(MapEntry(
          "passport_image",
          await d.MultipartFile.fromFile(
            passportImage.path,
            filename: passportImage.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (frontSideIdImage != null) {
        body.files.add(MapEntry(
          "front_side_id_image",
          await d.MultipartFile.fromFile(
            frontSideIdImage.path,
            filename: frontSideIdImage.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (backSideIdImage != null) {
        body.files.add(MapEntry(
          "back_side_id_image",
          await d.MultipartFile.fromFile(
            backSideIdImage.path,
            filename: backSideIdImage.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (commercialLicense != null) {
        body.files.add(MapEntry(
          "commercial_license",
          await d.MultipartFile.fromFile(
            commercialLicense.path!,
            filename: commercialLicense.name,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (signatureAuthorization != null) {
        body.files.add(MapEntry(
          "signature_authorization",
          await d.MultipartFile.fromFile(
            signatureAuthorization.path!,
            filename: signatureAuthorization.name,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (articlesOfAssociation != null) {
        body.files.add(MapEntry(
          "articles_of_association",
          await d.MultipartFile.fromFile(
            articlesOfAssociation.path!,
            filename: articlesOfAssociation.name,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (signatureOfficial != null) {
        body.files.add(MapEntry(
          "signatureـofficial",
          await d.MultipartFile.fromFile(
            signatureOfficial.path,
            filename: basename(signatureOfficial.path),
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      await dio.post(
        EndPoints.registerCompany,
        data: body,
        options: Options(
          headers: {"Accept": "application/json"},
        ),
        onSendProgress: (count, total) {
          logSuccess("$count/$total");
        },
      );

      Get.back();
      return true;
    } on DioException catch (error) {
      Get.back();
      logError(error.response!.data);

      // Utils.showSnackBar(message: error.response!.data["message"]);
      return error.response!.data;
    }
  }

  Future<bool> confirmEmail(
      {required String email, required String code}) async {
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData.fromMap({
        "email": email,
        "verification_code": code,
      });

      var res = await dio.post(EndPoints.confirmEmail,
          data: body,
          options: Options(headers: {"Accept": "application/json"}));
      logSuccess(res.data);
      Get.back();
      return true;
    } on DioException catch (error) {
      Get.back();
      Utils.showSnackBar(
        message: error.response!.data["message"],
      );

      // Utils.showSnackBar(message: error.response!.data["message"]);
      return false;
    }
  }

  Future<LoginStates> handleNormalSignIn({
    required String userName,
    required String password,
    required bool saveToken,
  }) async {
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      await FirebaseApi().initNotifications(_notificationController);

      final body = d.FormData.fromMap({
        "email": userName,
        "password": password,
      });
      String? fcsToken = await Utils.readFBToken();
      var res = await dio.post(
        EndPoints.login,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "fcsToken": fcsToken,
          },
        ),
      );

      if (res.data["message"] == "check your Email to reset your password") {
        Get.back();

        return LoginStates.needsVerify;
      } else if (res.data["access_token"] != null) {
        String token = res.data["access_token"];
        await Utils.saveToken(token: token);
        GlobalController g = Get.find();
        await g.getMe();
        if (saveToken) {
          await Utils.saveRemmemberMe(rem: saveToken ? "yes" : "no");
        }
        Get.back();

        return LoginStates.login;
      } else {
        Get.back();

        return LoginStates.error;
      }
    } on DioException catch (error) {
      Get.back();
      logError(error.response!.data);
      if (error.response!.data["message"] == "This User Is Not Found") {
        return LoginStates.accountNotFound;
      } else if (error.response!.data["error"] == "Unauthorized") {
        return LoginStates.credsError;
      } else if (error.response!.data["message"] ==
          "This User Is Not Found or blocked") {
        return LoginStates.blocked;
      } else {
        return LoginStates.error;
      }

      // Utils.showSnackBar(message: error.response!.data["message"]);
    }
  }

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      logError(e.toString());
    }
  }

  AuthController() {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(_scopes);
      }

      _currentUser = account;
      _isAuthorized = isAuthorized;

      if (isAuthorized) {}
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }
}

enum LoginStates {
  login,
  accountNotFound,
  credsError,
  needsVerify,
  blocked,
  error
}
