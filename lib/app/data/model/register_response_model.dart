class RegisterResponseModel {
  String? phonenumber;
  int? userid;

  RegisterResponseModel({this.phonenumber, this.userid});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    userid = json['userid'];
  }
}
