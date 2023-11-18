class CategoryModel {
  int? id;
  int? companyTypeID;
  String? nameEn;
  var image;
  String? nameAr;
  String? createdAt;
  String? updatedAt;

  CategoryModel({
    this.id,
    this.companyTypeID,
    this.nameEn,
    this.nameAr,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    companyTypeID = json['company_type_id'];
    nameAr = json['name_ar'];
    image = "https://khdmah.online/api/images/service/${json['image']}";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['company_type_id'] = companyTypeID;
    data['name_ar'] = nameAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
