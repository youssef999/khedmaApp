class EmployeesFilter {
  int? nationalityId;
  int? minAge;
  int? maxAge;
  // int? gender;
  int? maritalStatus;
  String? status;
  bool filterActive = true;
  List<String>? langs = [];
  List<String>? jobs = [];
  EmployeesFilter({
    this.nationalityId,
    this.minAge,
    this.maxAge,
    // this.langs,
    // this.gender,
    this.maritalStatus,
    this.status,
    this.filterActive = true,
  }) {
    langs = [];
    jobs = [];
  }

  EmployeesFilter.fromJson(Map<String, dynamic> json) {
    nationalityId = json['nationalityId'];

    minAge = json['minAge'];
    maxAge = json['maxAge'];

    // // gender = json['gender'];
    maritalStatus = json['maritalStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nationalityId'] = nationalityId;

    data['minAge'] = minAge;
    data['maxAge'] = maxAge;

    // // data['gender'] = gender;
    data['maritalStatus'] = maritalStatus;
    data['status'] = status;
    data['langs'] = langs;

    return data;
  }
}
