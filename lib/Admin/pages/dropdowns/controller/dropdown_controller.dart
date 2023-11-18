import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/certificate_.dart';
import 'package:khedma/models/complexion.dart';
import 'package:khedma/models/marital_status.dart';
import 'package:khedma/models/relegion.dart';

class DropDownsController extends GetxController {
  final Dio dio = Utils().dio;

  GlobalController _globalController = Get.find();
  Future<bool> createReligion({required RelegionModel relegionModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(relegionModel.toJson());

      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeReligion,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getRelegions();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteRelegion({required RelegionModel relegionModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(relegionModel.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteReligion(relegionModel.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getRelegions();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateRelegion({required RelegionModel relegionModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(relegionModel.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateReligion(relegionModel.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getRelegions();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> createCertificate(
      {required CertificateModel certificateModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(certificateModel.toJson());

      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeCertificate,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getCertificates();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteCertificate(
      {required CertificateModel certificateModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(certificateModel.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteCertificate(certificateModel.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getCertificates();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateCertificate(
      {required CertificateModel certificateModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(certificateModel.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateCertificate(certificateModel.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getCertificates();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> createComplexion(
      {required ComplexionModel complexionModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(complexionModel.toJson());

      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeComplexion,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getComplexion();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteComplexion(
      {required ComplexionModel complexionModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(complexionModel.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteComplexion(complexionModel.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getComplexion();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateComplexion(
      {required ComplexionModel complexionModel}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(complexionModel.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));

      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateComplexion(complexionModel.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getComplexion();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> createMarital({required MaritalStatusModel marital}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(marital.toJson());

      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeMaritalStatus,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getMaritalStatuss();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteMarital({required MaritalStatusModel marital}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(marital.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteMaritalStatus(marital.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getMaritalStatuss();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateMarital({required MaritalStatusModel marital}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(marital.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));

      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateMaritalStatus(marital.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      await _globalController.getMaritalStatuss();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }
}
