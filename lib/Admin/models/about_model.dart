class AboutModel {
  int? id;
  String? about;
  String? createdAt;
  String? updatedAt;

  AboutModel({this.id, this.about, this.createdAt, this.updatedAt});

  AboutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about'] = this.about;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
