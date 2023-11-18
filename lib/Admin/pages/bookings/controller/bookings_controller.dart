import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khedma/Utils/utils.dart';

class BookingsController extends GetxController {
  final Dio dio = Utils().dio;
  // List<CategoryModel> categories = [];

  // Future createCategory({required CategoryModel category}) async {
  //   try {
  //     Utils.circularIndicator();
  //     final body = d.FormData.fromMap(category.toJson());

  //     await dio.post(EndPoints.storeCategory, data: body);

  //     await getCategories();
  //     Get.back();
  //   } on DioException catch (e) {
  //     logError(e.message!);
  //     Get.back();
  //   }
  // }

  // Future deleteCategory(
  //     {required CategoryModel category, required int id}) async {
  //   try {
  //     Utils.circularIndicator();
  //     final body = d.FormData.fromMap(category.toJson());
  //     body.fields.add(const MapEntry("_method", "DELETE"));
  //     await dio.post(EndPoints.deleteCategory(id), data: body);

  //     await getCategories();
  //     Get.back();
  //   } on DioException catch (e) {
  //     logError(e.message!);
  //     Get.back();
  //   }
  // }

  // Future updateCategory(
  //     {required CategoryModel category, required int id}) async {
  //   try {
  //     Utils.circularIndicator();
  //     final body = d.FormData.fromMap(category.toJson());
  //     body.fields.add(const MapEntry("_method", "PUT"));
  //     await dio.post(EndPoints.updateCategory(id), data: body);

  //     await getCategories();
  //     Get.back();
  //   } on DioException catch (e) {
  //     logError(e.message!);
  //     Get.back();
  //   }
  // }

  // bool getCategoriesFlag = false;
  // Future getCategories() async {
  //   try {
  //     getCategoriesFlag = true;
  //     var res = await dio.get(EndPoints.getAllCategories);
  //     List<CategoryModel> tmp = [];
  //     for (var i in res.data['data']) {
  //       CategoryModel t = CategoryModel.fromJson(i);
  //       tmp.add(t);
  //     }
  //     categories = tmp;
  //     logSuccess("Categories get done");
  //     getCategoriesFlag = false;
  //     update();
  //   } on DioException {
  //     getCategoriesFlag = false;
  //     update();
  //     logError("Categories failed");
  //   }
  // }
}
