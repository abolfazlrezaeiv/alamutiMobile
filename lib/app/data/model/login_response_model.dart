class LoginResponseModel {
  String? token;
  String? refreshtoken;
  bool? success = false;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshtoken = json['refreshToken'];
    success = json['success'].toString().toLowerCase() == 'true';
  }
}
