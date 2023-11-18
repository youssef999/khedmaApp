class ContactMessageModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? message;
  String? createdAt;
  String? updatedAt;

  ContactMessageModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.message,
      this.createdAt,
      this.updatedAt});

  ContactMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
