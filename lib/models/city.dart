import 'package:khedma/models/country.dart';

class City {
  int? id;
  String? nameEn;
  String? nameAr;
  int? countryId;
  Country? country;

  City({this.id, this.nameEn, this.nameAr, this.countryId, this.country});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    countryId = json['country_id'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['country_id'] = this.countryId;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}
