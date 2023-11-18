class GlobalAdminItem {
  int? id;
  String? nameEn;
  String? nameAr;

  String? createdAt;
  String? updatedAt;

  GlobalAdminItem({
    this.id,
    this.nameEn,
    this.nameAr,
    this.createdAt,
    this.updatedAt,
  });

  GlobalAdminItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
