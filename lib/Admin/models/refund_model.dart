import 'package:khedma/models/me.dart';

class RefundModel {
  int? id;
  int? employeeId;
  int? approved;
  String? desc;
  String? createdAt;
  var attchment;
  Me? user;
  RefundModel({
    this.id,
    this.user,
    this.desc,
    this.createdAt,
    this.attchment,
    this.employeeId,
    this.approved,
  });

  RefundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    approved = json['approve'];

    attchment = json['file'] == null
        ? null
        : "https://khdmah.online/api/file/employee/refund/${json['file']}";
    if (json['user'] != null) {
      user = Me.fromJson(json['user']);
    }

    desc = json['docs'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['approve'] = approved;

    data['docs'] = desc;
    data['user'] = user!.toJson();

    data['created_at'] = createdAt;
    return data;
  }
}
