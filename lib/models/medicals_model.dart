import 'package:khedma/models/me.dart';

class MedicalsModel {
  int? id;
  int? employeeId;
  int? userId;
  String? amount;
  String? invoiceId;
  int? completed;
  String? createdAt;
  String? updatedAt;
  Me? user;

  MedicalsModel(
      {this.id,
      this.employeeId,
      this.userId,
      this.amount,
      this.invoiceId,
      this.completed,
      this.createdAt,
      this.updatedAt,
      this.user});

  MedicalsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    userId = json['user_id'];
    amount = json['amount'];
    invoiceId = json['invoice_id'];
    completed = json['completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new Me.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['invoice_id'] = invoiceId;
    data['completed'] = completed;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
