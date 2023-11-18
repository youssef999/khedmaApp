class AccountStatmentModel {
  int? id;
  String? amount;
  String? depositType;
  String? beneficiary;
  String? depositor;
  String? about;
  String? createdAt;
  String? updatedAt;

  AccountStatmentModel(
      {this.id,
      this.amount,
      this.depositType,
      this.beneficiary,
      this.depositor,
      this.about,
      this.createdAt,
      this.updatedAt});

  AccountStatmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    depositType = json['deposit_type'];
    beneficiary = json['beneficiary'];
    depositor = json['depositor'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;
    data['deposit_type'] = depositType;
    data['beneficiary'] = beneficiary;
    data['depositor'] = depositor;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
