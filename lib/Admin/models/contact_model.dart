class ContactModel {
  int? id;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;

  ContactModel(
      {this.id, this.phoneNumber, this.email, this.createdAt, this.updatedAt});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
