class UserRegisterData {
  String? fullName;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? phone;
  String? userType;
  String? jobName;
  String? nationalityId;
  String? cityId;
  String? regionId;
  String? pieceNumber;
  String? street;
  String? building;
  String? automatedAddressNumber;
  String? idNumberNationality;
  var idPhotoNationality;
  var personalPhoto;
  String? referenceNumber;

  UserRegisterData({
    this.fullName,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.phone,
    this.userType,
    this.jobName,
    this.nationalityId,
    this.cityId,
    this.regionId,
    this.pieceNumber,
    this.street,
    this.building,
    this.automatedAddressNumber,
    this.idNumberNationality,
    this.referenceNumber,
    this.personalPhoto,
    this.idPhotoNationality,
  });

  UserRegisterData.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    phone = json['phone'];
    userType = json['user_type'];
    jobName = json['job_name'];
    nationalityId = json['nationality_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    pieceNumber = json['piece_number'];
    street = json['street'];
    building = json['building'];
    automatedAddressNumber = json['automated_address_number'];
    idNumberNationality = json['id_number_nationality'];
    idPhotoNationality = json['id_photo_nationality'];
    personalPhoto = json['personal_photo'];
    referenceNumber = json['reference_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['phone'] = this.phone;
    data['user_type'] = this.userType;
    data['job_name'] = this.jobName;
    data['nationality_id'] = this.nationalityId;
    data['city_id'] = this.cityId;
    data['region_id'] = this.regionId;
    data['piece_number'] = this.pieceNumber;
    data['street'] = this.street;
    data['building'] = this.building;
    data['automated_address_number'] = this.automatedAddressNumber;
    data['id_number_nationality'] = this.idNumberNationality;
    data['reference_number'] = this.referenceNumber;
    return data;
  }
}
