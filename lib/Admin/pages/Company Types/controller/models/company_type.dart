class CompanyType {
  int? id;
  String? nameEn;
  int? isParent;
  String? nameAr;
  String? uniqueName;
  int? companyTypeId;
  String? createdAt;
  String? updatedAt;

  CompanyType({
    this.id,
    this.nameEn,
    this.isParent,
    this.nameAr,
    this.uniqueName,
    this.companyTypeId,
    this.createdAt,
    this.updatedAt,
  });

  CompanyType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    uniqueName = json['name_unique'];
    companyTypeId = json['company_type_id'];
    isParent = json['parent_company'];
    nameAr = json['name_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['parent_company'] = isParent;
    // data['name_unique'] = uniqueName;
    // data['name_unique'] = companyTypeId;
    data['name_ar'] = nameAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
