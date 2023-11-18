import 'package:khedma/models/company_service_model.dart';

class CartModel {
  int? id;
  String? quantity;
  int? paid;
  int? serviceId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  CompanyServiceModel? services;

  CartModel(
      {this.id,
      this.quantity,
      this.paid,
      this.serviceId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.services});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    paid = json['paid'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    services = json['services'] != null
        ? new CompanyServiceModel.fromJson(json['services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['paid'] = this.paid;
    data['service_id'] = this.serviceId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services!.toJson();
    }
    return data;
  }
}
