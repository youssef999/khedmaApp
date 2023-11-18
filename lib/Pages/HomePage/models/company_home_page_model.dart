import 'package:khedma/models/company_request_model.dart';

class CompanyHomePageModel {
  int? allEmplyeesCount;
  int? availableEmployeesCount;
  int? pendingEmployeesCount;
  int? bookedEmployeesCount;
  List<CompanyRequest>? requests;

  CompanyHomePageModel(
      {this.allEmplyeesCount,
      this.availableEmployeesCount,
      this.pendingEmployeesCount,
      this.bookedEmployeesCount,
      this.requests});

  CompanyHomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      if (json['employees']['all_emplyees_count'] != null) {
        allEmplyeesCount = json['employees']['all_emplyees_count'];
      }
      if (json['employees']['available_employees_count'] != null) {
        availableEmployeesCount =
            json['employees']['available_employees_count'];
      }
      if (json['employees']['pending_employees_count'] != null) {
        pendingEmployeesCount = json['employees']['pending_employees_count'];
      }
      if (json['employees']['booked_employees_count'] != null) {
        bookedEmployeesCount = json['employees']['booked_employees_count'];
      }
    }
    if (json['requests'] != null) {
      requests = <CompanyRequest>[];
      json['requests'].forEach((v) {
        requests!.add(CompanyRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all_emplyees_count'] = allEmplyeesCount;
    data['available_employees_count'] = availableEmployeesCount;
    data['pending_employees_count'] = pendingEmployeesCount;
    data['booked_employees_count'] = bookedEmployeesCount;
    if (requests != null) {
      data['requests'] = requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
