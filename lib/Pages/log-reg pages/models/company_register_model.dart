class CompanyRegisterData {
  String? userType;
  String? firstName;
  String? lastName;
  String? phone;
  String? nationalityId;
  String? idNumber;
  String? dateOfBirth;
  String? companyName;
  String? companyPhone;
  String? companyEmail;
  String? url;
  String? companyType;
  String? cityId;
  String? regionId;
  String? pieceNumber;
  String? street;
  String? building;
  String? automatedAddressNumber;
  String? commercialRegistrationNumber;
  String? taxNumber;
  String? licenseNumber;
  String? identityConfirmation;
  String? password;
  String? passwordConfirmation;
  String? bankId;
  String? iban;
  String? unifiedNumber;
  String? accountNumber;
  String? bankAccountName;
  var companyLogo;
  var passportImage;
  var frontSideIdImage;
  var backSideIdImage;
  var signatureOfficial;
  var signatureAuthorization;
  var commercialLicense;
  var articlesOfAssociation;

  CompanyRegisterData({
    this.userType,
    this.firstName,
    this.lastName,
    this.unifiedNumber,
    this.phone,
    this.nationalityId,
    this.idNumber,
    this.dateOfBirth,
    this.companyName,
    this.companyPhone,
    this.companyEmail,
    this.url,
    this.companyType = "recruitment",
    this.cityId,
    this.regionId,
    this.pieceNumber,
    this.street,
    this.building,
    this.automatedAddressNumber,
    this.commercialRegistrationNumber,
    this.taxNumber,
    this.licenseNumber,
    this.identityConfirmation = "id",
    this.password,
    this.passwordConfirmation,
    this.companyLogo,
    this.passportImage,
    this.frontSideIdImage,
    this.backSideIdImage,
    this.signatureOfficial,
    this.signatureAuthorization,
    this.commercialLicense,
    this.articlesOfAssociation,
    this.bankId,
    this.iban,
    this.accountNumber,
    this.bankAccountName,
  });

  CompanyRegisterData.fromJson(Map<String, dynamic> json) {
    bankId = json['bank_id'];
    iban = json['iban'];
    accountNumber = json['account_number'];
    bankAccountName = json['bank_account_name'];
    unifiedNumber = json['unified_number'];
    userType = json['user_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    nationalityId = json['nationality_id'];
    idNumber = json['id_number'];
    dateOfBirth = json['date_of_birth'];
    companyName = json['company_name'];
    companyPhone = json['company_phone'];
    companyEmail = json['company_email'];
    url = json['url'];
    companyType = json['company_type'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    pieceNumber = json['piece_number'];
    street = json['street'];
    building = json['building'];
    automatedAddressNumber = json['automated_address_number'];
    commercialRegistrationNumber = json['commercial_registration_number'];
    taxNumber = json['tax_number'];
    licenseNumber = json['license_number'];
    identityConfirmation = json['identity_confirmation'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    companyLogo = json['company_logo'];
    passportImage = json['passport_image'];
    frontSideIdImage = json['front_side_id_image'];
    backSideIdImage = json['back_side_id_image'];
    commercialLicense = json['commercial_license'];
    articlesOfAssociation = json['articles_of_association'];
    signatureAuthorization = json['signature_authorization'];
    signatureOfficial = json['signature_official'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_id'] = bankId;
    data['iban'] = iban;
    data['account_number'] = accountNumber;
    data['bank_account_name'] = bankAccountName;
    data['unified_number'] = unifiedNumber;
    data['user_type'] = userType;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['nationality_id'] = nationalityId;
    data['id_number'] = idNumber;
    data['date_of_birth'] = dateOfBirth;
    data['company_name'] = companyName;
    data['company_phone'] = companyPhone;
    data['company_email'] = companyEmail;
    data['url'] = url;
    data['company_type'] = companyType;
    data['city_id'] = cityId;
    data['region_id'] = regionId;
    data['piece_number'] = pieceNumber;
    data['street'] = street;
    data['building'] = building;
    data['automated_address_number'] = automatedAddressNumber;
    data['commercial_registration_number'] = commercialRegistrationNumber;
    data['tax_number'] = taxNumber;
    data['license_number'] = licenseNumber;
    data['identity_confirmation'] = identityConfirmation;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;

    return data;
  }
}
