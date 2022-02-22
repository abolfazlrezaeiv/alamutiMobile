class RegisterResponseModel {
  String phonenumber;

  RegisterResponseModel({required this.phonenumber});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(phonenumber: json['phonenumber']);
  }
}
