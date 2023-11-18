class Country {
  int? id;
  String? nameEn;
  String? nameAr;
  String? nationalityEn;
  String? nationalityAr;
  var flag;
  String? code;
  String? currency;
  String? shortCurrency;
  String? shortName;

  Country(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.nationalityEn,
      this.nationalityAr,
      this.flag,
      this.code,
      this.currency,
      this.shortCurrency,
      this.shortName});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    nationalityEn = json['nationality_en'];
    nationalityAr = json['nationality_ar'];
    flag = "https://khdmah.online/image/country/${json['flag']}";
    code = json['code'];
    currency = json['currency'];
    shortCurrency = json['short_currency'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['nationality_en'] = this.nationalityEn;
    data['nationality_ar'] = this.nationalityAr;

    data['code'] = this.code;
    data['currency'] = this.currency;
    data['short_currency'] = this.shortCurrency;
    data['short_name'] = this.shortName;
    return data;
  }
}
