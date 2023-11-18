// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Pages/HomePage/models/advertisment_model.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:sizer/sizer.dart';

class AdvertismentController extends GetxController {
  final Dio dio = Utils().dio;
  List<AdvertismentModel> companyAds = [];
  List<AdvertismentModel> pendingCompanyAds = [];
  List<AdvertismentModel> refusedCompanyAds = [];

  Future<String?> createAdvertisment(
      {required AdvertismentModel advertisment}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(advertisment.toJson());
      XFile? image = advertisment.image;
      String? token = await Utils.readToken();

      if (image != null) {
        body.files.add(MapEntry(
          "image",
          await d.MultipartFile.fromFile(
            image.path,
            filename: image.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      var res = await dio.post(
        EndPoints.storeCompanyAdvertisment,
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
        onSendProgress: (count, total) {
          logSuccess("${count}/${total}");
        },
      );

      // await getAdvertisments();
      Get.back();
      return res.data['InvoiceURL'];
    } on DioException catch (e) {
      logError(e.response!.data);
      BuildContext context = Get.context!;
      List<String> errorText = [];
      Map errors = e.response!.data["errors"];
      errors.forEach((key, value) {
        List l = List.from(value);
        errorText.add(l.join("\n"));
      });
      Get.back();
      Utils.customDialog(
          title: "Errors",
          titleStyle: coloredText(
            text: errorText.join("\n"),
            textAlign: TextAlign.left,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ).style,
          actions: [
            primaryButton(
              onTap: () => Get.back(),
              text: coloredText(
                text: "close".tr,
                color: Colors.white,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: coloredText(
                text: errorText.join("\n"),
                textAlign: TextAlign.left,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          context: context);
    }
    return null;
  }

  Future<bool> updateAdvertisment(
      {required AdvertismentModel advertisment}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(advertisment.toJson());
      String? token = await Utils.readToken();
      body.fields.add(MapEntry("_method", "PUT"));
      XFile? image;
      if (advertisment.image.runtimeType != String) {
        image = advertisment.image;
        if (image != null) {
          body.files.add(MapEntry(
            "image",
            await d.MultipartFile.fromFile(
              image.path,
              filename: image.name,
              contentType: MediaType('image', '*'),
            ),
          ));
        }
      }
      logSuccess(advertisment.toJson());
      await dio.post(
        EndPoints.updateCompanyAdvertisment(advertisment.id!),
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      await getCompanyAdvertisments();
      Get.back();
      return true;
    } on DioException catch (e) {
      Get.back();
      logError(e.response!.data);
      BuildContext context = Get.context!;
      List<String> errorText = [];
      Map errors = e.response!.data["errors"];
      errors.forEach((key, value) {
        List l = List.from(value);
        errorText.add(l.join("\n"));
      });
      Get.back();
      Utils.customDialog(
          title: "Errors",
          titleStyle: coloredText(
            text: errorText.join("\n"),
            textAlign: TextAlign.left,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ).style,
          actions: [
            primaryButton(
              onTap: () => Get.back(),
              text: coloredText(
                text: "close".tr,
                color: Colors.white,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: coloredText(
                text: errorText.join("\n"),
                textAlign: TextAlign.left,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          context: context);
    }
    return false;
  }

  bool getCompanyAdvertismentsFlag = false;
  Future getCompanyAdvertisments() async {
    try {
      getCompanyAdvertismentsFlag = true;
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getAllCompanyAdvertisments,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      List<AdvertismentModel> tmp = [];
      for (var i in res.data['data']) {
        AdvertismentModel t = AdvertismentModel.fromJson(i);
        tmp.add(t);
      }
      companyAds = tmp.reversed.toList();
      // companyAds.sort();
      pendingCompanyAds = companyAds
          .where(
            (element) =>
                (element.adminApprove == null &&
                    DateTime.parse(element.startDate!)
                        .isAfter(DateTime.now())) ||
                element.refund == 1,
          )
          .toList();
      refusedCompanyAds = companyAds
          .where((element) =>
              (element.adminApprove == 0 ||
                  DateTime.parse(element.startDate!)
                      .isBefore(DateTime.now())) &&
              element.refund == 0)
          .toList();
      logSuccess("Company Advertisments get done");
      getCompanyAdvertismentsFlag = false;
      update();
    } on DioException {
      getCompanyAdvertismentsFlag = false;
      update();
      logError("Company Advertisments failed");
    }
  }

  List<AdvertismentModel> adminAds = [];
  List<AdvertismentModel> adminRefundAds = [];
  List<AdvertismentModel> adminRequestedAds = [];

  bool getAdminAdvertismentsFlag = false;
  Future getAdminAdvertisments() async {
    try {
      getAdminAdvertismentsFlag = true;
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getAllAdminAdvertisments,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      List<AdvertismentModel> tmp = [];
      for (var i in res.data['data']) {
        AdvertismentModel t = AdvertismentModel.fromJson(i);
        tmp.add(t);
      }
      adminAds = tmp;
      adminRequestedAds = adminAds
          .where((element) =>
              element.adminApprove == null &&
              DateTime.parse(element.startDate!).isAfter(DateTime.now()))
          .toList();
      adminRefundAds =
          adminAds.where((element) => element.refund == 1).toList();
      logSuccess("Admin Advertisments get done");
      getAdminAdvertismentsFlag = false;
      update();
    } on DioException catch (e) {
      logError(e.response!.data);
      getAdminAdvertismentsFlag = false;
      update();
      logError("Admin Advertisments failed");
    }
  }

  Future<bool> approveAdvertismnt({
    required int approve,
    String? desc,
    required int advertismentId,
  }) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap({
        "admin_approve": approve,
        if (desc != null) "desc": desc,
        "_method": "PUT",
      });
      String? token = await Utils.readToken();

      await Dio().post(
        EndPoints.updateAdminAdvertisment(advertismentId),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await getAdminAdvertisments();
      Get.back();
      return true;
    } on DioException catch (e) {
      Get.back();
      logError(e.response!.data);
    }
    return false;
  }

  Future<bool> refundAdvertismnt({
    required int refund,
    required int advertismentId,
  }) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap({
        "admin_refund": refund,
        "_method": "PUT",
      });
      String? token = await Utils.readToken();

      await Dio().post(
        EndPoints.refundAdminAdvertisment(advertismentId),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await getAdminAdvertisments();
      Get.back();
      return true;
    } on DioException catch (e) {
      Get.back();
      logError(e.response!.data);
    }
    return false;
  }

  Future<bool> requestRefund({
    required int id,
  }) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap({
        "_method": "PUT",
      });
      String? token = await Utils.readToken();

      await Dio().post(
        EndPoints.refundCompanyAdvertisment(id),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await getCompanyAdvertisments();
      Get.back();
      return true;
    } on DioException catch (e) {
      Get.back();
      logError(e.response!.data);
    }
    return false;
  }

  // int _mySortComparison(AdvertismentModel a, AdvertismentModel b) {
  //   final propertyA = DateTime.parse(a.createdAt!);
  //   final propertyB = DateTime.parse(b.createdAt!);
  //   if (propertyA.isBefore(propertyB)) {
  //     return -1;
  //   } else {
  //     return 1;
  //   }
  // }
}
