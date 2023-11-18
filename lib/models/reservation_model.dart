import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/models/me.dart';

class ReservationExtintionModel {
  int? id;
  int? days;
  String? reason;
  var file;
  int? adminApprove;
  int? userId;
  int? employeeId;
  String? createdAt;
  String? updatedAt;
  EmployeeModel? employee;
  Me? user;

  ReservationExtintionModel(
      {this.id,
      this.days,
      this.reason,
      this.file,
      this.adminApprove,
      this.userId,
      this.employeeId,
      this.createdAt,
      this.updatedAt,
      this.employee,
      this.user});

  ReservationExtintionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    days = json['days'];
    reason = json['reason'];
    file = "https://khdmah.online/api/images/reservation/${json['file']}";
    adminApprove = json['admin_approve'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['employee'] != null
        ? EmployeeModel.fromJson(json['employee'])
        : null;
    user = json['user'] != null ? Me.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (days != null) data['days'] = days;
    if (reason != null) data['reason'] = reason;
    if (adminApprove != null) data['admin_approve'] = adminApprove;
    if (userId != null) data['user_id'] = userId;
    if (employeeId != null) data['employee_id'] = employeeId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
