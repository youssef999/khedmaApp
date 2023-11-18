import 'package:khedma/models/global_admin_items_model.dart';

class MaritalStatusModel extends GlobalAdminItem {
  MaritalStatusModel({int? id, String? nameEn, String? nameAr})
      : super(id: id, nameAr: nameAr, nameEn: nameEn);

  MaritalStatusModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
