class RegisterRequestModel {
  final String phonenumber;

  RegisterRequestModel({required this.phonenumber});

  RegisterRequestModel.fromJson(Map<String, dynamic> json)
      : phonenumber = json['phoneNumber'];

  Map<String,dynamic> toJson() {
    return {
      'phoneNumber': phonenumber,
    };
  }
}
