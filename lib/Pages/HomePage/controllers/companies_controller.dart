// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/cart_model.dart';
import 'package:khedma/widgets/cleaning_company_service_widget.dart';

class CompaniesController extends GetxController {
  final Dio dio = Utils().dio;
  List<CompanyModel> recruitmentCompanies = [];
  List<CompanyModel> recruitmentCompaniesToShow = [];

  String companyPrice = "0";
  List<CartModel> carts = [];
  bool getCartsFlag = false;
  Future getcarts() async {
    try {
      getCartsFlag = true;
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getCart,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      List<CartModel> tmp = [];
      for (var i in res.data['data']) {
        CartModel t = CartModel.fromJson(i);
        tmp.add(t);
      }
      carts = tmp;

      logSuccess("carts get done");
      getCartsFlag = false;
      update();
    } on DioException catch (e) {
      getCartsFlag = false;
      logError(e.response!.data);
      update();
      logError("carts failed");
    }
  }

  Future geCompanyPrice({required int companyId}) async {
    try {
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getCompanySetting(companyId),
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      companyPrice = res.data['data']['representative_from_company_price'];
      logSuccess("companyPrice" + companyPrice.toString());
      update();
    } on DioException catch (e) {
      getCartsFlag = false;
      logError(e.response!.data);
      update();
      logError("failed");
    }
  }

  Future<bool> updateCompanyPrice(
      {required int price, required int companyId}) async {
    try {
      Utils.circularIndicator();
      String? token = await Utils.readToken();

      await dio.post(
        EndPoints.updateCompanySetting,
        data: d.FormData.fromMap({"representative_from_company_price": price}),
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      await geCompanyPrice(companyId: companyId);
      Get.back();
      update();
      return true;
    } on DioException catch (e) {
      getCartsFlag = false;
      logError(e.response!.data);
      Get.back();
      update();
      logError("failed");
    }
    return false;
  }

  Future<bool> createCompanyService({required MyService service}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(
          {"service_id": service.serviceId, "quantity": service.quantity});
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeCart,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      bookService(service);
      await getcarts();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteCart({
    required MyService service,
  }) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData();
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();

      await dio.post(
        EndPoints.deleteCart(carts
            .where((element) => element.services!.id == service.serviceId)
            .first
            .id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      deleteService(service);
      await getcarts();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  void bookService(MyService service) {
    servicesBooked.add(service);
    update();
  }

  void deleteService(MyService service) {
    if (servicesBooked.contains(service)) {
      servicesBooked.remove(service);
    }
    update();
  }

  int getCartTotal() {
    int total = 0;
    for (var i in servicesBooked) {
      total = total + (int.parse(i.price) * i.quantity);
    }
    return total;
  }

  filterRecruitmentCompaniesByCity({required String city}) {
    List<CompanyModel> tmp = [];
    for (var i in recruitmentCompanies) {
      if (i.companyInformation!.city!.nameAr == city ||
          i.companyInformation!.city!.nameEn == city) {
        tmp.add(i);
      }

      recruitmentCompaniesToShow = tmp;

      update();
    }
  }

  handleRecruitmentCompaniesSearch({required String name}) {
    List<CompanyModel> tmp = [];
    for (var i in recruitmentCompaniesToShow) {
      logSuccess(name);
      logWarning(i.toJson());
      if (i.fullName!.contains(name)) {
        tmp.add(i);
      }
      if (name == "") {
        recruitmentCompaniesToShow = recruitmentCompanies;
      } else {
        recruitmentCompaniesToShow = tmp;
      }
      update();
    }
  }

  bool getRecruitmentCompaniesFlag = false;
  Future getRecruitmentCompanies({bool indicator = true}) async {
    try {
      if (indicator) getRecruitmentCompaniesFlag = true;
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getAllRecruitmentCompanies,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      List<CompanyModel> tmp = [];
      for (var i in res.data['data']) {
        CompanyModel t = CompanyModel.fromJson(i);
        logWarning(t.toJson());
        tmp.add(t);
      }
      recruitmentCompanies = tmp;
      recruitmentCompaniesToShow = tmp;
      logSuccess("Recruitment Companies get done");
      if (indicator) getRecruitmentCompaniesFlag = false;
      update();
    } on DioException {
      getRecruitmentCompaniesFlag = false;
      update();
      logError("Recruitment Companies failed");
    }
  }

  Future<CompanyModel?> showCompany(
      {required int id, required bool indicator}) async {
    try {
      if (indicator) Utils.circularIndicator();
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.showCompany(id),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (indicator) Get.back();
      logWarning(res.data);
      if (res.data['data'] != null) {
        CompanyModel c = CompanyModel.fromJson(res.data['data']);
        await getcarts();
        servicesBooked.clear();
        if (c.companyInformation!.companyType == "cleaning") {
          carts.forEach(
            (element) {
              if (c.id == element.services!.companyId) {
                logSuccess(c.id.toString());
                logSuccess(element.services!.companyId.toString());
                bookService(
                  MyService(
                    price: element.services!.price!,
                    quantity: int.parse(element.quantity!),
                    name: Get.locale == const Locale("en", "US")
                        ? element.services!.adminService!.nameEn!
                        : element.services!.adminService!.nameAr!,
                    image: element.services!.adminService!.image,
                    serviceId: element.services!.id!,
                  ),
                );
              }
            },
          );
        }
        return CompanyModel.fromJson(res.data["data"]);
      } else {
        CompanyModel c = CompanyModel.fromJson(res.data);
        await getcarts();
        servicesBooked.clear();
        if (c.companyInformation!.companyType == "cleaning") {
          carts.forEach(
            (element) {
              if (c.id == element.services!.companyId) {
                logSuccess(c.id.toString());
                logSuccess(element.services!.companyId.toString());
                bookService(
                  MyService(
                    price: element.services!.price!,
                    quantity: int.parse(element.quantity!),
                    name: Get.locale == const Locale("en", "US")
                        ? element.services!.adminService!.nameEn!
                        : element.services!.adminService!.nameAr!,
                    image: element.services!.adminService!.image,
                    serviceId: element.services!.id!,
                  ),
                );
              }
            },
          );
        }
        return CompanyModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      if (indicator) Get.back();
      logError(e.response!.data);
    } catch (e) {
      logError(e);
    }
    return null;
  }

  /////////////cleaning section
  List<MyService> servicesBooked = [];
  List<CompanyModel> cleanCompanies = [];
  List<CompanyModel> cleanCompaniesToShow = [];
  // filterCleanCompaniesByCity({required String city}) {
  //   List<CompanyModel> tmp = [];
  //   for (var i in cleanCompaniesToShow) {
  //     if (i.companyInformation!.city!.nameAr == city ||
  //         i.companyInformation!.city!.nameEn == city) {
  //       tmp.add(i);
  //     }

  //     cleanCompaniesToShow = tmp;

  //     update();
  //   }
  // }

  handleCleanCompaniesSearch({
    required String name,
    required String companyType,
    required String city,
  }) {
    List<CompanyModel> tmp = [];
    cleanCompaniesToShow = cleanCompanies;
    logSuccess(companyType);
    if (companyType != "") {
      cleanCompaniesToShow = cleanCompaniesToShow
          .where((element) =>
              element.companyInformation!.companyType == companyType)
          .toList();
    }
    update();
    if (city != "") {
      cleanCompaniesToShow = cleanCompaniesToShow
          .where((element) =>
              element.companyInformation!.city!.nameAr == city ||
              element.companyInformation!.city!.nameEn == city)
          .toList();
    }
    update();
    logSuccess(cleanCompaniesToShow.length);
    for (var i in cleanCompaniesToShow) {
      if (i.fullName!.contains(name)) {
        tmp.add(i);
      }
      if (name == "") {
        cleanCompaniesToShow = cleanCompaniesToShow;
      } else {
        cleanCompaniesToShow = tmp;
      }
      update();
    }
  }

  bool getCleanCompaniesFlag = false;
  Future getCleaningCompanies({bool indicator = true}) async {
    try {
      if (indicator) getCleanCompaniesFlag = true;
      String? token = await Utils.readToken();

      var res = await dio.get(
        EndPoints.getAllCleaningCompanies,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      List<CompanyModel> tmp = [];
      for (var i in res.data['data']) {
        CompanyModel t = CompanyModel.fromJson(i);
        tmp.add(t);
      }
      cleanCompanies = tmp;
      cleanCompaniesToShow = tmp;
      handleCleanCompaniesSearch(name: "", companyType: "", city: "");
      logSuccess("Cleaning Companies get done");
      if (indicator) getCleanCompaniesFlag = false;
      update();
    } on DioException catch (e) {
      if (indicator) getCleanCompaniesFlag = false;
      update();
      logError(e.response!.data);
      logError("Cleaning Companies failed");
    }
  }

  Future<bool?> checkOut({
    required int id,
    required String startDate,
    required String endDate,
    required String address,
    required int receiptMethod,
  }) async {
    try {
      Utils.circularIndicator();
      String? token = await Utils.readToken();
      d.FormData body = d.FormData.fromMap({
        "start_date": startDate,
        "end_date": endDate,
        "address": address,
        "receipt_method": receiptMethod,
      });
      logSuccess(token!);

      var res = await dio.post(
        EndPoints.checkout(id),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      Get.back();
      logSuccess(res.data);
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return null;
  }
}
