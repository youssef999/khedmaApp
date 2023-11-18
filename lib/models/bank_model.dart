class BankModel {
  int? id;
  int? bankId;
  String? bankName;

  BankModel({this.id, this.bankId, this.bankName});

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['bank_name'] = this.bankName;
    return data;
  }
}
