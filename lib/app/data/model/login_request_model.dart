import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:get_storage/get_storage.dart';

class LoginRequestModel {
  String? phone;
  String? password;
  var storage = GetStorage();
  LoginRequestModel({this.phone, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = storage.read(CacheManagerKey.PHONENUMBER.toString());
    data['password'] = this.password;
    return data;
  }
}
