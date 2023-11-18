class SettingAdmin {
  int? id;
  int? typeCommssionRecruitment;
  int? typeCommssionCleaning;
  String? commssionRecruitment;
  String? commssionCleaning;
  String? advertisementPrice;
  int? endDatePendingEmployee;
  String? pricePendingEmployee;
  String? medicalExaminationPrice;
  String? khedmaPrice;
  String? createdAt;
  String? updatedAt;

  SettingAdmin(
      {this.id,
      this.typeCommssionRecruitment,
      this.typeCommssionCleaning,
      this.commssionRecruitment,
      this.commssionCleaning,
      this.medicalExaminationPrice,
      this.advertisementPrice,
      this.endDatePendingEmployee,
      this.pricePendingEmployee,
      this.khedmaPrice,
      this.createdAt,
      this.updatedAt});

  SettingAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeCommssionRecruitment = json['type_commssion_recruitment'];
    typeCommssionCleaning = json['type_commssion_cleaning'];
    commssionRecruitment = json['commssion_recruitment'];
    khedmaPrice = json['representative_from_khedmah_price'];
    commssionCleaning = json['commssion_cleaning'];
    advertisementPrice = json['advertisement_price'];
    endDatePendingEmployee = json['end_date_pending_employee'];
    pricePendingEmployee = json['employee_reservation_amount'];
    medicalExaminationPrice = json['medical_examination_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['type_commssion_recruitment'] = typeCommssionRecruitment;
    data['type_commssion_cleaning'] = typeCommssionCleaning;
    data['commssion_recruitment'] = commssionRecruitment;
    data['representative_from_khedmah_price'] = khedmaPrice;
    data['commssion_cleaning'] = commssionCleaning;
    data['advertisement_price'] = advertisementPrice;
    data['medical_examination_price'] = medicalExaminationPrice;
    data['end_date_pending_employee'] = endDatePendingEmployee;
    data['employee_reservation_amount'] = pricePendingEmployee;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
