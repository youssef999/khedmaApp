import 'package:khedma/models/me.dart';

class CompanyModel {
  int? id;
  String? fullName;
  String? userType;
  int? reviewCompanyCount;
  String? reviewCompanySumReviewValue;
  Favourite? favouriteCompany;
  CompanyInformation? companyInformation;
  List<CleaningService>? cleaningServices;
  List<ReviewCompany>? reviewCompany;
  CompanyModel({
    this.id,
    this.fullName,
    this.userType,
    this.reviewCompanyCount,
    this.reviewCompanySumReviewValue,
    this.companyInformation,
    this.favouriteCompany,
    this.reviewCompany,
    this.cleaningServices,
  });

  CompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['review_company'] != null) {
      reviewCompany = <ReviewCompany>[];
      json['review_company'].forEach((v) {
        reviewCompany!.add(ReviewCompany.fromJson(v));
      });
    }
    if (json['services'] != null) {
      cleaningServices = <CleaningService>[];
      json['services'].forEach((v) {
        cleaningServices!.add(CleaningService.fromJson(v));
      });
    }
    id = json['id'];
    fullName = json['full_name'];
    userType = json['user_type'];
    favouriteCompany = json['favourite_with_company'] != null &&
            List.from(json['favourite_with_company']).isNotEmpty
        ? Favourite.fromJson(json['favourite_with_company'][0])
        : null;

    reviewCompanyCount = json['review_company_count'];
    reviewCompanySumReviewValue = json['review_company_sum_review_value'];
    companyInformation = json['company_information'] != null
        ? CompanyInformation.fromJson(json['company_information'])
        : json['company_general'] != null
            ? CompanyInformation.fromJson(json['company_general'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.reviewCompany != null) {
      data['review_company'] =
          this.reviewCompany!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['full_name'] = fullName;
    data['favourite_with_company'] = favouriteCompany;
    data['user_type'] = userType;
    data['review_company_count'] = reviewCompanyCount;
    data['review_company_sum_review_value'] = reviewCompanySumReviewValue;
    if (companyInformation != null) {
      data['company_information'] = companyInformation!.toJson();
    }
    if (favouriteCompany != null) {
      data['favourite_with_company'] = favouriteCompany!.toJson();
    }
    if (cleaningServices != null) {
      data['services'] = cleaningServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CleaningService {
  int? id;
  String? price;
  int? serviceId;
  int? companyId;
  String? createdAt;
  String? updatedAt;

  CleaningService(
      {this.id,
      this.price,
      this.serviceId,
      this.companyId,
      this.createdAt,
      this.updatedAt});

  CleaningService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    serviceId = json['service_id'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['service_id'] = serviceId;
    data['company_id'] = companyId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
