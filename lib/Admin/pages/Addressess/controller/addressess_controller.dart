import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/models/city.dart';
import 'package:khedma/models/country.dart';
import 'package:khedma/models/region.dart';

class AddressessController extends GetxController {
  final Dio dio = Utils().dio;

  GlobalController _globalController = Get.find();
  Future<bool> createCity({required City city, required int countryId}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(city.toJson());
      body.fields.add(MapEntry("country_id", countryId.toString()));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeCity,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCities();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteCity({required City city}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(city.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteCity(city.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCities();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateCity({required City city}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(city.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateCity(city.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCities();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> createRegion({required Region region}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(region.toJson());
      body.fields.add(MapEntry("city_id", "1"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeRegion,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getRegions();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteRegion({required Region region}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(region.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteRegion(region.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getRegions();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateRegion({required Region region}) async {
    try {
      Utils.circularIndicator();
      String? token = await Utils.readToken();
      final body = d.FormData.fromMap(region.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));
      await dio.post(
        EndPoints.updateRegion(region.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getRegions();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> createCountry({required Country country}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(country.toJson());
      XFile? flag = country.flag;

      if (flag != null) {
        body.files.add(MapEntry(
          "flag",
          await d.MultipartFile.fromFile(
            flag.path,
            filename: flag.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeCountry,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCountries();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteCountry({required Country country}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(country.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteCountry(country.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCountries();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateCountry({required Country country}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(country.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));
      XFile? flag;
      if (country.flag.runtimeType != String) flag = country.flag;
      String? token = await Utils.readToken();
      if (flag != null) {
        body.files.add(MapEntry(
          "flag",
          await d.MultipartFile.fromFile(
            flag.path,
            filename: flag.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      await dio.post(
        EndPoints.updateCountry(country.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCountries();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }
}
