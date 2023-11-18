import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/models/company_model.dart';
import 'package:khedma/models/city.dart';
import 'package:khedma/models/company_service_model.dart';

class Me {
  int? id;
  String? fullName;
  String? signatureOfficial;
  String? email;
  String? emailVerifiedAt;
  int? status;
  int? block;
  String? phone;
  String? adminPhoto;
  String? createdAt;
  String? updatedAt;
  String? userType;
  UserInformation? userInformation;
  CompanyInformation? companyInformation;
  List<Favourite>? favouriteCompany;
  List<Favourite>? favouriteEmployee;
  List<RecruuitmentBooking> booking = [];
  List<ReviewCompany>? reviewCompany;

  Me({
    this.id,
    this.fullName,
    this.signatureOfficial,
    this.email,
    this.phone,
    this.adminPhoto,
    this.reviewCompany,
    this.emailVerifiedAt,
    this.status,
    this.block,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.userInformation,
    this.companyInformation,
    this.favouriteCompany,
    this.favouriteEmployee,
  });

  Me.fromJson(Map<String, dynamic> json) {
    if (json['review_company'] != null) {
      reviewCompany = <ReviewCompany>[];
      json['review_company'].forEach((v) {
        reviewCompany!.add(new ReviewCompany.fromJson(v));
      });
    }
    id = json['id'];
    block = json['block'];
    fullName = json['full_name'];
    signatureOfficial = json['signatureـofficial'];
    email = json['email'];
    phone = json['phone'];
    adminPhoto = json['photo'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    userInformation = json['user_information'] != null
        ? UserInformation.fromJson(json['user_information'])
        : null;
    companyInformation = json['company_information'] != null
        ? CompanyInformation.fromJson(json['company_information'])
        : null;
    if (json['favourite_company'] != null) {
      favouriteCompany = <Favourite>[];
      json['favourite_company'].forEach((v) {
        favouriteCompany!.add(Favourite.fromJson(v));
      });
    }
    if (json['favourite_employee'] != null) {
      favouriteEmployee = <Favourite>[];
      json['favourite_employee'].forEach((v) {
        favouriteEmployee!.add(Favourite.fromJson(v));
      });
    }
    if (json['booking_me'] != null) {
      booking = <RecruuitmentBooking>[];
      json['booking_me'].forEach((v) {
        RecruuitmentBooking x = RecruuitmentBooking.fromJson(v);
        booking.add(x);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (data['id'] != null) data['id'] = id;
    if (data['block'] != null) data['block'] = block;
    if (data['full_name'] != null) data['full_name'] = fullName;
    if (data['signatureـofficial'] != null)
      data['signatureـofficial'] = signatureOfficial;
    if (data['email'] != null) data['email'] = email;
    if (data['email_verified_at'] != null) {
      data['email_verified_at'] = emailVerifiedAt;
    }
    if (this.reviewCompany != null) {
      data['review_company'] =
          this.reviewCompany!.map((v) => v.toJson()).toList();
    }
    data['booking_me'] = booking.map((v) => v.toJson()).toList();
    if (data['status'] != null) data['status'] = status;
    if (data['created_at'] != null) data['created_at'] = createdAt;
    if (data['updated_at'] != null) data['updated_at'] = updatedAt;
    if (data['user_type'] != null) data['user_type'] = userType;
    if (userInformation != null) {
      data['user_information'] = userInformation!.toJson();
    }
    if (companyInformation != null) {
      data['company_information'] = companyInformation!.toJson();
    }
    if (favouriteCompany != null) {
      data['favourite_company'] =
          favouriteCompany!.map((v) => v.toJson()).toList();
    }
    if (favouriteEmployee != null) {
      data['favourite_employee'] =
          favouriteEmployee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInformation {
  int? id;
  String? phone;
  String? userType;
  String? jobName;
  int? nationalityId;
  int? userId;
  int? cityId;
  int? regionId;
  String? pieceNumber;
  String? street;
  String? building;
  String? automatedAddressNumber;
  String? idNumberNationality;
  String? idPhotoNationality;
  var personalPhoto;
  String? referenceNumber;
  String? phoneVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userName;
  UserInformation(
      {this.id,
      this.phone,
      this.userType,
      this.jobName,
      this.nationalityId,
      this.userId,
      this.cityId,
      this.regionId,
      this.pieceNumber,
      this.street,
      this.building,
      this.automatedAddressNumber,
      this.idNumberNationality,
      this.idPhotoNationality,
      this.personalPhoto,
      this.referenceNumber,
      this.phoneVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.userName});

  UserInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    userType = json['user_type'];
    jobName = json['job_name'];
    nationalityId = json['nationality_id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    pieceNumber = json['piece_number'];
    street = json['street'];
    building = json['building'];
    automatedAddressNumber = json['automated_address_number'];
    idNumberNationality = json['id_number_nationality'];
    idPhotoNationality =
        "https://khdmah.online/api/images/user/${json['id_photo_nationality']}";
    personalPhoto =
        "https://khdmah.online/api/images/user/${json['personal_photo']}";
    referenceNumber = json['reference_number'];
    phoneVerifiedAt = json['phone_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['job_name'] = jobName;
    data['nationality_id'] = nationalityId;
    data['user_id'] = userId;
    data['city_id'] = cityId;
    data['region_id'] = regionId;
    data['piece_number'] = pieceNumber;
    data['street'] = street;
    data['building'] = building;
    data['automated_address_number'] = automatedAddressNumber;
    data['id_number_nationality'] = idNumberNationality;
    // data['id_photo_nationality'] = idPhotoNationality;
    // data['personal_photo'] = personalPhoto;
    data['reference_number'] = referenceNumber;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_name'] = userName;

    return data;
  }
}

class CompanyInformation {
  int? id;
  int? busy;
  int? approveAdmin;
  String? firstName;
  String? lastName;
  String? phone;
  String? idNumber;
  String? dateOfBirth;
  String? companyPhone;
  String? companyPhoneVerifiedAt;
  String? url;
  String? companyType;
  String? pieceNumber;
  String? street;
  String? building;
  String? automatedAddressNumber;
  String? commercialRegistrationNumber;
  String? taxNumber;
  String? licenseNumber;
  var companyLogo;
  var signatureOfficial;
  var signatureAuthorization;
  var commercialLicense;
  var articlesOfAssociation;
  var contractMyfatoorah;
  var contractKhedmah;
  int? verifyContract;
  String? identityConfirmation;
  String? frontSideIdImage;
  String? backSideIdImage;
  String? passportImage;
  int? nationalityId;
  int? companyId;
  int? cityId;
  int? regionId;
  String? createdAt;
  String? updatedAt;
  String? companyName;
  List<EmployeeModel>? employees;
  City? city;

  CompanyInformation(
      {this.id,
      this.firstName,
      this.busy,
      this.city,
      this.contractKhedmah,
      this.contractMyfatoorah,
      this.employees,
      this.approveAdmin,
      this.verifyContract,
      this.lastName,
      this.phone,
      this.idNumber,
      this.dateOfBirth,
      this.companyPhone,
      this.companyPhoneVerifiedAt,
      this.url,
      this.companyType,
      this.pieceNumber,
      this.street,
      this.building,
      this.automatedAddressNumber,
      this.commercialRegistrationNumber,
      this.taxNumber,
      this.licenseNumber,
      this.companyLogo,
      this.signatureOfficial,
      this.signatureAuthorization,
      this.commercialLicense,
      this.articlesOfAssociation,
      this.identityConfirmation,
      this.frontSideIdImage,
      this.backSideIdImage,
      this.passportImage,
      this.nationalityId,
      this.companyId,
      this.cityId,
      this.regionId,
      this.createdAt,
      this.updatedAt,
      this.companyName});

  CompanyInformation.fromJson(Map<String, dynamic> json) {
    if (json['city'] != null) {
      city = City.fromJson(json['city']);
    }
    if (json['employee'] != null) {
      employees = <EmployeeModel>[];
      json['employee'].forEach((v) {
        employees!.add(EmployeeModel.fromJson(v));
      });
    }
    verifyContract = json['verify_contract'];
    approveAdmin = json['approve_admin'];
    contractKhedmah = json['contract_khedmah'];
    contractMyfatoorah = json['contract_myfatoorah'];
    id = json['id'];
    busy = json['busy'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    idNumber = json['id_number'];
    dateOfBirth = json['date_of_birth'];
    companyPhone = json['company_phone'];
    companyPhoneVerifiedAt = json['company_phone_verified_at'];
    url = json['url'];
    companyType = json['company_type'];
    pieceNumber = json['piece_number'];
    street = json['street'];
    building = json['building'];
    automatedAddressNumber = json['automated_address_number'];
    commercialRegistrationNumber = json['commercial_registration_number'];
    taxNumber = json['tax_number'];
    licenseNumber = json['license_number'];
    companyLogo = "${json['company_logo']}"
            .startsWith("https://khdmah.online/api/images/company/logo/")
        ? "${json['company_logo']}"
        : "https://khdmah.online/api/images/company/logo/${json['company_logo']}";
    signatureOfficial = "${json['signatureـofficial']}"
            .startsWith("https://khdmah.online/api/images/company/")
        ? "${json['signatureـofficial']}"
        : "https://khdmah.online/api/images/company/${json['signatureـofficial']}";

    signatureAuthorization = "${json['signature_authorization']}"
            .startsWith("https://khdmah.online/api/images/company/")
        ? "${json['signature_authorization']}"
        : "https://khdmah.online/api/images/company/${json['signature_authorization']}";
    commercialLicense = "${json['commercial_license']}"
            .startsWith("https://khdmah.online/api/images/company/")
        ? "${json['commercial_license']}"
        : "https://khdmah.online/api/images/company/${json['commercial_license']}";

    articlesOfAssociation = "${json['articles_of_association']}"
            .startsWith("https://khdmah.online/api/images/company/")
        ? "${json['articles_of_association']}"
        : "https://khdmah.online/api/images/company/${json['articles_of_association']}";

    identityConfirmation = json['identity_confirmation'];
    if (json['front_side_id_image'] != null) {
      frontSideIdImage =
          "https://khdmah.online/api/images/company/${json['front_side_id_image']}";
    }
    if (json['back_side_id_image'] != null) {
      backSideIdImage =
          "https://khdmah.online/api/images/company/${json['back_side_id_image']}";
    }
    if (json['passport_image'] != null) {
      passportImage =
          "https://khdmah.online/api/images/company/${json['passport_image']}/";
    }
    nationalityId = json['nationality_id'];
    companyId = json['company_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (city != null) data['city'] = city!.toJson();

    if (employees != null) {
      data['employee'] = employees!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['verify_contract'] = verifyContract;
    data['contract_khedmah'] = contractKhedmah;
    data['contract_myfatoorah'] = contractMyfatoorah;
    data['busy'] = busy;
    data['approve_admin'] = approveAdmin;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['id_number'] = idNumber;
    data['date_of_birth'] = dateOfBirth;
    data['company_phone'] = companyPhone;
    data['company_phone_verified_at'] = companyPhoneVerifiedAt;
    data['url'] = url;
    data['company_type'] = companyType;
    data['piece_number'] = pieceNumber;
    data['street'] = street;
    data['building'] = building;
    data['automated_address_number'] = automatedAddressNumber;
    data['commercial_registration_number'] = commercialRegistrationNumber;
    data['tax_number'] = taxNumber;
    data['license_number'] = licenseNumber;
    // data['company_logo'] = this.companyLogo;
    data['identity_confirmation'] = identityConfirmation;
    data['front_side_id_image'] = frontSideIdImage;
    data['back_side_id_image'] = backSideIdImage;
    data['passport_image'] = passportImage;
    data['nationality_id'] = nationalityId;
    data['company_id'] = companyId;
    data['city_id'] = cityId;
    data['region_id'] = regionId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['company_name'] = companyName;
    data['approve_admin'] = approveAdmin;
    return data;
  }
}

class Favourite {
  int? id;
  int? type;
  int? typeId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  CompanyModel? company;
  EmployeeModel? employee;
  Favourite({
    this.id,
    this.type,
    this.typeId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.employee,
  });

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeId = json['type_id'];
    userId = json['user_id'];
    if (json['company'] != null) {
      company = CompanyModel.fromJson(json['company']);
    }
    if (json['employee'] != null) {
      employee = EmployeeModel.fromJson(json['employee']);
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = id;
    if (type != null) data['type'] = type;
    if (typeId != null) data['type_id'] = typeId;
    if (userId != null) data['user_id'] = userId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (company != null) data["company"] = company!.toJson();
    if (employee != null) data["employee"] = employee!.toJson();
    return data;
  }
}

class RecruuitmentBooking {
  int? id;
  String? status;
  int? employeeId;
  String? pendingInvoiceId;
  String? bookedInvoiceId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? pendingAmount;
  String? bookingAmount;
  EmployeeModel? employee;
  RecruuitmentBooking(
      {this.id,
      this.status,
      this.employeeId,
      this.pendingInvoiceId,
      this.bookedInvoiceId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.pendingAmount,
      this.employee,
      this.bookingAmount});

  RecruuitmentBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    employeeId = json['employee_id'];
    pendingInvoiceId = json['pending_invoice_id'];
    bookedInvoiceId = json['booked_invoice_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pendingAmount = json['pending_amount'];
    bookingAmount = json['booking_amount'];
    employee = json['employee'] != null
        ? EmployeeModel.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) data['id'] = id;
    if (status != null) data['status'] = status;
    if (employeeId != null) data['employee_id'] = employeeId;
    if (pendingInvoiceId != null) data['pending_invoice_id'] = pendingInvoiceId;
    if (bookedInvoiceId != null) data['booked_invoice_id'] = bookedInvoiceId;
    if (userId != null) data['user_id'] = userId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (pendingAmount != null) data['pending_amount'] = pendingAmount;
    if (bookingAmount != null) data['booking_amount'] = bookingAmount;
    if (employee != null) data['employee'] = employee!.toJson();
    return data;
  }
}

class CleaningBooking {
  int? id;
  int? userId;
  int? companyId;
  String? startDate;
  String? endDate;
  Me? user;
  List<Order>? order;

  CleaningBooking(
      {this.id,
      this.userId,
      this.companyId,
      this.startDate,
      this.endDate,
      this.user,
      this.order});

  CleaningBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    user = json['user'] != null ? Me.fromJson(json['user']) : null;
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? quantity;
  int? checkoutId;
  int? serviceId;
  CompanyServiceModel? services;

  Order({this.quantity, this.checkoutId, this.serviceId, this.services});

  Order.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    checkoutId = json['checkout_id'];
    serviceId = json['service_id'];
    services = json['services'] != null
        ? new CompanyServiceModel.fromJson(json['services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['checkout_id'] = this.checkoutId;
    data['service_id'] = this.serviceId;
    if (this.services != null) {
      data['services'] = this.services!.toJson();
    }
    return data;
  }
}

class ReviewCompany {
  int? id;
  int? reviewValue;
  String? review;
  int? companyId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Me? user;

  ReviewCompany(
      {this.id,
      this.reviewValue,
      this.review,
      this.companyId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  ReviewCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewValue = json['review_value'];
    review = json['review'];
    companyId = json['company_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new Me.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review_value'] = this.reviewValue;
    data['review'] = this.review;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
