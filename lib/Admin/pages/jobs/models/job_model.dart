import 'package:khedma/models/global_admin_items_model.dart';

class JobModel extends GlobalAdminItem {
  var icon;
  JobModel({
    int? id,
    String? nameEn,
    String? nameAr,
    String? createdAt,
    String? updatedAt,
    var icon,
  }) : super(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            createdAt: createdAt,
            updatedAt: updatedAt);

  JobModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    icon = "https://khdmah.online/api/images/job/${json['icon']}";
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    // data['icon'] = icon;
    return data;
  }
}
