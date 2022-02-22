class LoginResponseModel {
  final String? token;
  final String? refreshtoken;
  final bool success;

  LoginResponseModel(this.token, this.refreshtoken, this.success);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      json['token'],
      json['refreshToken'],
      json['success'],
    );
  }
}
