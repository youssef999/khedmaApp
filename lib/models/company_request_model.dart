import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/models/me.dart';

class CompanyRequest {
  int? id;
  int? approve;
  int? userId;
  int? employeeId;
  EmployeeModel? employee;
  Me? user;

  CompanyRequest(
      {this.id,
      this.approve,
      this.userId,
      this.employeeId,
      this.employee,
      this.user});

  CompanyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    approve = json['approve'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    employee = json['employee'] != null
        ? new EmployeeModel.fromJson(json['employee'])
        : null;
    user = json['user'] != null ? new Me.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['approve'] = this.approve;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class DocumentModel {
  int? id;
  int? approve;
  int? userId;
  int? employeeId;
  Me? user;
  List<String>? names;
  List<String>? files;
  DocumentModel({
    this.id,
    this.approve,
    this.userId,
    this.employeeId,
    this.user,
    this.names,
    this.files,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    approve = json['approve'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    user = json['user'] != null ? Me.fromJson(json['user']) : null;
    if (json['name'] != null) names = json['name'].cast<String>();
    if (json['file'] != null) {
      files = List<String>.from(json['file'])
          .map((e) => 'https://khdmah.online/api/images/documents/$e')
          .toList();
      ;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['approve'] = approve;
    data['user_id'] = userId;
    data['employee_id'] = employeeId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['name'] = names;
    data['file'] = files;
    return data;
  }
}
