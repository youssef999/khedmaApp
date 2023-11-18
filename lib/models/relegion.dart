import 'package:khedma/models/global_admin_items_model.dart';

class RelegionModel extends GlobalAdminItem {
  RelegionModel({int? id, String? nameEn, String? nameAr})
      : super(id: id, nameAr: nameAr, nameEn: nameEn);

  RelegionModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
