class LoginResponseModel {
  String? token;
  String? refreshtoken;

  LoginResponseModel({this.token, this.refreshtoken});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshtoken = json['refreshToken'];
  }
}
