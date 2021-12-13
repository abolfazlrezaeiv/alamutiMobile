import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:get/get.dart';

class AdvertisementProvider {
  TokenProvider tokenProvider = Get.put(TokenProvider());

  getAll() async {
    var response = await tokenProvider.api.get(
      'http://192.168.1.102:5113/api/Advertisement',
    );
    print(response.data);
  }
}
