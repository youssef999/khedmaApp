import 'package:khedma/Admin/pages/jobs/models/job_model.dart';
import 'package:khedma/Admin/pages/languages/models/language_model.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/models/company_request_model.dart';
import 'package:khedma/models/country.dart';
import 'package:khedma/models/me.dart';

class EmployeeModel {
  int? id;
  String? nameEn;
  String? nameAr;
  String? dateOfBirth;
  String? timeWorkPerDay;
  String? hourSalary;
  int? numOfChildren;
  int? hight;
  int? weight;
  String? salaryMonth;
  String? numberYearContract;
  String? contractAmount;
  String? contractDuration;
  int? previousWorkAbroad;
  int? durationOfEmployment;
  String? residenceContract;
  String? finalContract;
  String? desc;

  var image;
  var passportImege;
  String? passportNum;
  RecruuitmentBooking? status;
  String? passportIssueDate;
  String? passportExpiryDate;
  int? isOffer;
  int? amountAfterDiscount;
  int? waitingList;
  String? waitingEnd;
  int? available;
  int? refund;
  int? nationalityId;
  int? birthPlace;
  int? livingTown;
  int? passportPlaceOfIssue;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  int? complexionId;
  int? religionId;
  int? maritalStatus;
  int? educationCertification;
  Favourite? favourite;
  CompanyModel? company;
  DocumentModel? document;
  Country? nationality;
  List<LanguageModel>? languages = [];
  List<JobModel>? jobs = [];

  EmployeeModel({
    this.id,
    this.nationality,
    this.residenceContract,
    this.finalContract,
    this.nameEn,
    this.nameAr,
    this.dateOfBirth,
    this.timeWorkPerDay,
    this.hourSalary,
    this.numOfChildren,
    this.hight,
    this.document,
    this.company,
    this.weight,
    this.salaryMonth,
    this.numberYearContract,
    this.contractAmount,
    this.contractDuration,
    this.previousWorkAbroad,
    this.durationOfEmployment,
    this.image,
    this.passportImege,
    this.passportNum,
    this.status,
    this.desc,
    this.passportIssueDate,
    this.passportExpiryDate,
    this.isOffer,
    this.amountAfterDiscount,
    this.waitingList,
    this.waitingEnd,
    this.available,
    this.refund,
    this.nationalityId,
    this.birthPlace,
    this.livingTown,
    this.passportPlaceOfIssue,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.complexionId,
    this.religionId,
    this.maritalStatus,
    this.educationCertification,
    this.favourite,
    this.languages,
    this.jobs,
  }) {
    // languages = [];
    // jobs = [];
  }

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['status'] != null) {
      status = RecruuitmentBooking.fromJson(json['status']);
    }
    if (json['document'] != null) {
      document = DocumentModel.fromJson(json['document']);
    }
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    residenceContract = json['residence_contract'];
    finalContract = json["agreement_threed_contract"];
    dateOfBirth = json['date_of_birth'];
    timeWorkPerDay = json['time_work_per_day'];
    hourSalary = json['hour_salary'];
    numOfChildren = json['num_of_children'];
    hight = json['hight'];
    weight = json['weight'];
    salaryMonth = json['salary_month'];
    numberYearContract = json['number_year_contract'];
    contractAmount = json['contract_amount'];
    contractDuration = json['contract_duration'];
    previousWorkAbroad = json['previous_work_abroad'];
    durationOfEmployment = json['duration_of_employment'];
    image = "https://khdmah.online/api/images/employee/${json['image']}";
    passportImege =
        "https://khdmah.online/api/images/employee/passport/${json['passport_image']}";
    passportNum = json['passport_num'];
    passportIssueDate = json['passport_issue_date'];
    passportExpiryDate = json['passport_expiry_date'];
    isOffer = json['is_offer'];
    amountAfterDiscount = json['amount_after_discount'];
    waitingList = json['waiting_list'];
    waitingEnd = json['waiting_end'];
    available = json['available'];
    refund = json['refund'];
    nationalityId = json['nationality_id'];
    birthPlace = json['birth_place'];
    livingTown = json['living_town'];
    passportPlaceOfIssue = json['passport_place_of_issue'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    complexionId = json['complexion_id'];
    religionId = json['religion_id'];
    maritalStatus = json['marital_status'];
    educationCertification = json['education_certification'];
    desc = json['about'];

    if (json['favourite'] != null) {
      favourite = Favourite.fromJson(json['favourite']);
    }
    if (json['nationality'] != null) {
      nationality = Country.fromJson(json['nationality']);
    }
    if (json['company'] != null) {
      company = CompanyModel.fromJson(json['company']);
    }
    if (json['languages'] != null) {
      languages = <LanguageModel>[];
      json['languages'].forEach((v) {
        languages!.add(LanguageModel.fromJson(v));
      });
    }
    if (json['jobs'] != null) {
      jobs = <JobModel>[];
      json['jobs'].forEach((v) {
        jobs!.add(JobModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (id != null) data['id'] = id;
    if (residenceContract != null) {
      data['residence_contract'] = residenceContract;
    }
    if (finalContract != null) {
      data["agreement_threed_contract"] = finalContract;
    }
    if (status != null) data['status'] = status!.toJson();
    if (desc != null) data['about'] = desc;
    if (nameAr != null) data['name_ar'] = nameAr;
    if (nameEn != null) data['name_en'] = nameEn;
    if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
    if (timeWorkPerDay != null) data['time_work_per_day'] = timeWorkPerDay;
    if (hourSalary != null) data['hour_salary'] = hourSalary;
    if (numOfChildren != null) data['num_of_children'] = numOfChildren;
    if (hight != null) data['hight'] = hight;
    if (weight != null) data['weight'] = weight;
    if (salaryMonth != null) data['salary_month'] = salaryMonth;
    if (numberYearContract != null) {
      data['number_year_contract'] = numberYearContract;
    }
    if (contractAmount != null) data['contract_amount'] = contractAmount;
    if (contractDuration != null) data['contract_duration'] = contractDuration;
    if (previousWorkAbroad != null) {
      data['previous_work_abroad'] = previousWorkAbroad;
    }
    if (durationOfEmployment != null) {
      data['duration_of_employment'] = durationOfEmployment;
    }
    if (passportNum != null) data['passport_num'] = passportNum;
    if (nationality != null) data['nationality'] = nationality!.toJson();
    if (company != null) data['company'] = company!.toJson();
    if (passportIssueDate != null) {
      data['passport_issue_date'] = passportIssueDate;
    }
    if (passportExpiryDate != null) {
      data['passport_expiry_date'] = passportExpiryDate;
    }
    if (isOffer != null) data['is_offer'] = isOffer;
    if (amountAfterDiscount != null) {
      data['amount_after_discount'] = amountAfterDiscount;
    }
    if (waitingList != null) data['waiting_list'] = waitingList;
    if (waitingEnd != null) data['waiting_end'] = waitingEnd;
    if (available != null) data['available'] = available;
    if (refund != null) data['refund'] = refund;
    if (nationalityId != null) data['nationality_id'] = nationalityId;
    if (birthPlace != null) data['birth_place'] = birthPlace;
    if (livingTown != null) data['living_town'] = livingTown;
    if (passportPlaceOfIssue != null) {
      data['passport_place_of_issue'] = passportPlaceOfIssue;
    }
    if (companyId != null) data['company_id'] = companyId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (complexionId != null) data['complexion_id'] = complexionId;
    if (religionId != null) data['religion_id'] = religionId;
    if (maritalStatus != null) data['marital_status'] = maritalStatus;
    if (educationCertification != null) {
      data['education_certification'] = educationCertification;
    }
    if (favourite != null) data['favourite'] = favourite!.toJson();
    if (document != null) data['document'] = document!.toJson();
    if (languages != null) {
      for (var i = 0; i < languages!.length; i++) {
        data["languages[$i]"] = languages![i].id;
      }
    }
    if (jobs != null)
      for (var i = 0; i < jobs!.length; i++) {
        data["jobs[$i]"] = jobs![i].id;
      }
    if (languages != null)
      for (var i = 0; i < languages!.length; i++) {
        data["languagesName[$i]"] = languages![i].name;
      }
    if (jobs != null)
      for (var i = 0; i < jobs!.length; i++) {
        data["jobsName[$i]"] = jobs![i].nameEn;
      }
    // data['languages'] = languages!.map((e) => e.id).toList();
    // data['jobs'] = jobs!.map((e) => e.id).toList();
    return data;
  }
}
