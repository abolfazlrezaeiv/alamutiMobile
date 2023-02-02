import 'package:alamuti/data/datasources/storage/cache_manager.dart';
import 'package:get_storage/get_storage.dart';

class LoginRequestModel {
  String? phone;
  String? password;
  var storage = GetStorage();
  LoginRequestModel({this.phone, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = storage.read(CacheManagerKey.PHONENUMBER.toString());
    data['verificationCode'] = this.password;
    return data;
  }
}
