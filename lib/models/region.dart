import 'package:khedma/models/city.dart';

class Region {
  int? id;
  String? nameEn;
  String? nameAr;
  int? cityId;
  String? createdAt;
  String? updatedAt;
  City? city;

  Region(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.cityId,
      this.createdAt,
      this.updatedAt,
      this.city});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}
