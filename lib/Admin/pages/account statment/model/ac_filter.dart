class AccountStatmentFilter {
  int? minPrice;
  String? minDate;
  String? maxDate;
  String? date;
  int? maxPrice;
  // int? gender;

  String? status;
  bool filterActive = true;

  AccountStatmentFilter({
    this.minPrice,
    this.minDate,
    this.maxDate,
    this.date,
    this.maxPrice,

    // this.gender,

    this.status,
    this.filterActive = true,
  }) {}

  AccountStatmentFilter.fromJson(Map<String, dynamic> json) {
    minPrice = json['minPrice'];
    minPrice = json['minPrice'];
    minDate = json['minDate'];
    minDate = json['minDate'];
    maxDate = json['maxDate'];
    maxDate = json['maxDate'];
    date = json['date'];
    maxPrice = json['maxPrice'];

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['minPrice'] = minPrice;
    data['minPrice'] = minPrice;
    data['minDate'] = minDate;
    data['minDate'] = minDate;
    data['maxDate'] = maxDate;
    data['maxDate'] = maxDate;
    data['date'] = date;
    data['maxPrice'] = maxPrice;

    data['status'] = status;

    return data;
  }
}
