import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Admin/pages/jobs/models/job_model.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/end_points.dart';
import 'package:khedma/Utils/utils.dart';

class JobsController extends GetxController {
  final Dio dio = Utils().dio;
  List<JobModel> jobs = [];
  GlobalController _globalController = Get.find();
  Future<bool> createJob({required JobModel job}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(job.toJson());

      XFile? icon = job.icon;

      if (icon != null) {
        body.files.add(MapEntry(
          "icon",
          await d.MultipartFile.fromFile(
            icon.path,
            filename: icon.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.storeJob,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getjobs();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> deleteJob({required JobModel job}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(job.toJson());
      body.fields.add(const MapEntry("_method", "DELETE"));
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.deleteJob(job.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getjobs();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  Future<bool> updateJob({required JobModel job}) async {
    try {
      Utils.circularIndicator();
      final body = d.FormData.fromMap(job.toJson());
      body.fields.add(const MapEntry("_method", "PUT"));
      XFile? icon;
      if (job.icon.runtimeType != String) icon = job.icon;

      if (icon != null) {
        body.files.add(MapEntry(
          "icon",
          await d.MultipartFile.fromFile(
            icon.path,
            filename: icon.name,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      String? token = await Utils.readToken();
      await dio.post(
        EndPoints.updateJob(job.id!),
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      await _globalController.getjobs();
      Get.back();
      return true;
    } on DioException catch (e) {
      logError(e.response!.data);
      Get.back();
    }
    return false;
  }

  // bool getjobsFlag = false;
  // Future getjobs() async {
  //   try {
  //     getjobsFlag = true;
  //     var res = await dio.get(EndPoints.getAllJobs);
  //     List<JobModel> tmp = [];
  //     for (var i in res.data['data']) {
  //       JobModel t = JobModel.fromJson(i);
  //       tmp.add(t);
  //     }
  //     jobs = tmp;
  //     logSuccess("Jobs get done");
  //     getjobsFlag = false;
  //     update();
  //   } on DioException {
  //     getjobsFlag = false;
  //     update();
  //     logError("Jobs failed");
  //   }
  // }
}
