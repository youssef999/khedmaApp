class AdvertismentModel {
  int? id;
  int? refund;
  int? adminRefund;
  var image;
  int? durationByDay = 0;
  int? promotionType;
  String? externalLink;
  String? amount;
  int? confirm;
  String? desc;
  int? adminApprove;
  String? startDate;
  String? endDate;
  int? companyId;
  String? createdAt;
  String? updatedAt;

  AdvertismentModel({
    this.id,
    this.refund,
    this.adminRefund,
    this.amount,
    this.image,
    this.durationByDay = 0,
    this.promotionType,
    this.externalLink,
    this.confirm,
    this.adminApprove,
    this.startDate,
    this.endDate,
    this.desc,
    this.companyId,
    this.createdAt,
    this.updatedAt,
  });

  AdvertismentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    desc = json['desc'];
    image = "https://khdmah.online/api/images/addvertisment/${json['image']}";
    refund = json['refund'];
    adminRefund = json['admin_refund'];
    durationByDay = json['duration_by_day'];
    promotionType = json['promotion_type'];
    externalLink = json['external_link'];
    confirm = json['confirm'];
    adminApprove = json['admin_approve'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) data['id'] = id;
    if (amount != null) data['amount'] = amount;
    if (refund != null) data['refund'] = refund;
    if (adminRefund != null) data['admin_refund'] = adminRefund;
    if (desc != null) data['desc'] = desc;
    if (durationByDay != null) data['duration_by_day'] = durationByDay;
    if (promotionType != null) data['promotion_type'] = promotionType;
    if (externalLink != null) data['external_link'] = externalLink;
    if (startDate != null) data['start_date'] = startDate;

    return data;
  }
}
