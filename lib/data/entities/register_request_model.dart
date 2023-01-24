class RegisterRequestModel {
  String? phonenumber;

  RegisterRequestModel({this.phonenumber});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;

    return data;
  }
}
