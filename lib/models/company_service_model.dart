import 'package:khedma/Admin/pages/categories/models/categories_model.dart';

class CompanyServiceModel {
  int? id;
  String? price;
  int? serviceId;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  CategoryModel? adminService;

  CompanyServiceModel(
      {this.id,
      this.price,
      this.serviceId,
      this.companyId,
      this.createdAt,
      this.updatedAt,
      this.adminService});

  CompanyServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    serviceId = json['service_id'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminService = json['admin_service'] != null
        ? CategoryModel.fromJson(json['admin_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['price'] = price;
    data['service_id'] = serviceId;
    data['company_id'] = companyId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (adminService != null) {
      data['admin_service'] = adminService!.toJson();
    }
    return data;
  }
}
