import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/models/advertisment_model.dart';
import 'package:khedma/models/me.dart';

class UserHomePageModel {
  List<UserStatsCompanyHomePageModel>? companiesRecruitment;
  List<UserStatsCompanyHomePageModel>? companiesGeneral;
  List<CompaniesParent>? companiesParant;
  List<EmployeeModel>? employees;
  List<AdvertismentModel>? ads;
  String? logoUrlCompany;
  String? imageUrlEmployee;
  String? imageUrlAds;

  UserHomePageModel(
      {this.companiesRecruitment,
      this.companiesGeneral,
      this.companiesParant,
      this.employees,
      this.ads,
      this.logoUrlCompany,
      this.imageUrlEmployee,
      this.imageUrlAds});

  UserHomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['companiesRecruitment'] != null) {
      companiesRecruitment = <UserStatsCompanyHomePageModel>[];
      json['companiesRecruitment'].forEach((v) {
        companiesRecruitment!.add(UserStatsCompanyHomePageModel.fromJson(v));
      });
    }
    if (json['companiesParant'] != null) {
      companiesParant = <CompaniesParent>[];
      json['companiesParant'].forEach((v) {
        companiesParant!.add(CompaniesParent.fromJson(v));
      });
    }
    if (json['companiesGeneral'] != null) {
      companiesGeneral = <UserStatsCompanyHomePageModel>[];
      json['companiesGeneral'].forEach((v) {
        companiesGeneral!.add(UserStatsCompanyHomePageModel.fromJson(v));
      });
    }
    if (json['employees'] != null) {
      employees = <EmployeeModel>[];
      json['employees'].forEach((v) {
        employees!.add(EmployeeModel.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = <AdvertismentModel>[];
      json['ads'].forEach((v) {
        ads!.add(AdvertismentModel.fromJson(v));
      });
    }
    logoUrlCompany = json['logoUrlCompany'];
    imageUrlEmployee = json['imageUrlEmployee'];
    imageUrlAds = json['imageUrlAds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.companiesRecruitment != null) {
      data['companiesRecruitment'] =
          this.companiesRecruitment!.map((v) => v.toJson()).toList();
    }
    if (this.companiesParant != null) {
      data['companiesParant'] =
          this.companiesParant!.map((v) => v.toJson()).toList();
    }
    if (this.companiesGeneral != null) {
      data['companiesGeneral'] =
          this.companiesGeneral!.map((v) => v.toJson()).toList();
    }
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    data['ads'] = this.ads;
    data['logoUrlCompany'] = this.logoUrlCompany;
    data['imageUrlEmployee'] = this.imageUrlEmployee;
    data['imageUrlAds'] = this.imageUrlAds;
    return data;
  }
}

class UserStatsCompanyHomePageModel {
  int? id;
  String? fullName;
  String? email;
  int? status;
  String? userType;
  int? reviewCompanyCount;
  String? reviewCompanySumReviewValue;
  CompanyInformation? companyInformation;

  UserStatsCompanyHomePageModel(
      {this.id,
      this.fullName,
      this.email,
      this.status,
      this.userType,
      this.reviewCompanyCount,
      this.reviewCompanySumReviewValue,
      this.companyInformation});

  UserStatsCompanyHomePageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    status = json['status'];
    userType = json['user_type'];
    reviewCompanyCount = json['review_company_count'];
    reviewCompanySumReviewValue = json['review_company_sum_review_value'];
    companyInformation = json['company_information'] != null
        ? CompanyInformation.fromJson(json['company_information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['review_company_count'] = this.reviewCompanyCount;
    data['review_company_sum_review_value'] = this.reviewCompanySumReviewValue;
    if (this.companyInformation != null) {
      data['company_information'] = this.companyInformation!.toJson();
    }
    return data;
  }
}

class Nationality {
  int? id;
  String? nameEn;
  String? nameAr;
  String? nationalityEn;
  String? nationalityAr;
  String? flag;
  String? code;
  String? currency;
  String? shortCurrency;
  String? shortName;

  Nationality(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.nationalityEn,
      this.nationalityAr,
      this.flag,
      this.code,
      this.currency,
      this.shortCurrency,
      this.shortName});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    nationalityEn = json['nationality_en'];
    nationalityAr = json['nationality_ar'];
    flag = json['flag'];
    code = json['code'];
    currency = json['currency'];
    shortCurrency = json['short_currency'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['nationality_en'] = this.nationalityEn;
    data['nationality_ar'] = this.nationalityAr;
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['currency'] = this.currency;
    data['short_currency'] = this.shortCurrency;
    data['short_name'] = this.shortName;
    return data;
  }
}

class CompaniesParent {
  int? id;
  String? nameEn;
  String? nameAr;
  String? nameUnique;
  int? parentCompany;
  int? companyTypeId;
  String? createdAt;
  String? updatedAt;

  CompaniesParent(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.nameUnique,
      this.parentCompany,
      this.companyTypeId,
      this.createdAt,
      this.updatedAt});

  CompaniesParent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    nameUnique = json['name_unique'];
    parentCompany = json['parent_company'];
    companyTypeId = json['company_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['name_unique'] = this.nameUnique;
    data['parent_company'] = this.parentCompany;
    data['company_type_id'] = this.companyTypeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
