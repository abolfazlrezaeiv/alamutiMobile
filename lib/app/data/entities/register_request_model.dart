class AuthByPhoneNumberRequestModel {
  final String phonenumber;

  AuthByPhoneNumberRequestModel({required this.phonenumber});

  AuthByPhoneNumberRequestModel.fromJson(Map<String, dynamic> json)
      : phonenumber = json['phoneNumber'];

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phonenumber,
    };
  }
}
