import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Admin/pages/categories/models/categories_model.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';

class CategoriesController extends GetxController {
  final Dio dio = Utils().dio;
  List<CategoryModel> categories = [];
  GlobalController _globalController = Get.find();

  Future<bool> createCategory({required CategoryModel category}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(category.toJson());

      XFile? icon = category.image;

      if (icon != null) {
        body.files.add(MapEntry(
          "image",
          await d.MultipartFile.fromFile(
            icon.path,
            filename: icon.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeCategory,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCategories();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteCategory({required CategoryModel category}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(category.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteCategory(category.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCategories();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.message!);
      Get.back();
    }
    return false;
  }

  Future<bool> updateCategory({required CategoryModel category}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(category.toJson());

      XFile? icon;
      if (category.image.runtimeType != String) {
        icon = category.image;
        if (icon != null) {
          body.files.add(MapEntry(
            "image",
            await d.MultipartFile.fromFile(
              icon.path,
              filename: icon.name,
              contentType: MediaType('image', '*'),
            ),
          ));
        }
      }

      body.fields.add(const MapEntry("_method", "PUT"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateCategory(category.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getCategories();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.message!);
      Get.back();
    }
    return false;
  }

  bool getCategoriesFlag = false;
  Future getCategories() async {
    try {
      getCategoriesFlag = true;
      String? token = await Utils.readToken();
      var res = await dio.get(
        EndPoints.getAllCategories,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      List<CategoryModel> tmp = [];
      for (var i in res.data['data']) {
        CategoryModel t = CategoryModel.fromJson(i);
        tmp.add(t);
      }
      categories = tmp;
      logSuccess("Categories get done");
      getCategoriesFlag = false;
      update();
    } on DioException {
      getCategoriesFlag = false;
      update();
      logError("Categories failed");
    }
  }
}
