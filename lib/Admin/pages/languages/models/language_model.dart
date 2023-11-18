import 'package:khedma/models/global_admin_items_model.dart';

class LanguageModel extends GlobalAdminItem {
  String? shortName;
  String? slug;
  String? name;

  LanguageModel(
      {int? id,
      String? nameEn,
      String? nameAr,
      this.shortName,
      this.slug,
      this.name})
      : super(id: id, nameAr: nameAr, nameEn: nameEn);

  LanguageModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    shortName = json['short_name'];
    slug = json['slug'];
    name = json['name'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();

    data['short_name'] = shortName;
    data['slug'] = slug;
    data['name'] = name;
    return data;
  }
}
