import 'package:khedma/models/me.dart';

class CheckoutModel {
  int? id;
  int? userId;
  int? companyId;
  String? startDate;
  String? endDate;
  String? address;
  int? receiptMethod;
  String? amountPaid;
  String? amount;
  String? invoiceId;
  int? approve;
  int? paid;
  String? createdAt;
  String? updatedAt;
  List<Order>? order;

  CheckoutModel(
      {this.id,
      this.userId,
      this.companyId,
      this.startDate,
      this.endDate,
      this.address,
      this.receiptMethod,
      this.amountPaid,
      this.amount,
      this.order,
      this.invoiceId,
      this.approve,
      this.paid,
      this.createdAt,
      this.updatedAt});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    address = json['address'];
    receiptMethod = json['receipt_method'];
    amountPaid = json['amount_paid'];
    amount = json['amount'];
    invoiceId = json['invoice_id'];
    approve = json['approve'];
    paid = json['paid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['address'] = this.address;
    data['receipt_method'] = this.receiptMethod;
    data['amount_paid'] = this.amountPaid;
    data['amount'] = this.amount;
    data['invoice_id'] = this.invoiceId;
    data['approve'] = this.approve;
    data['paid'] = this.paid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
