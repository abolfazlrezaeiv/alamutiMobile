import 'package:alamuti/data/apicall/advertisement_apicall.dart';
import 'package:alamuti/data/entities/advertisement.dart';
import 'package:alamuti/data/entities/list_page.dart';

class AdvertisementRepository {
  final AdvertisementAPICall apiCall;

  AdvertisementRepository(this.apiCall);
  Future<void> getDetails({required int id}) async {}

  Future<ListPage<Advertisement>> getAll(
      {int number = 1, int size = 8, String? category}) async {
    return await apiCall.getAll(number: number, size: size, category: category);
  }

  Future<ListPage<Advertisement>> search(
      {int number = 1, int size = 10, required String searchInput}) async {
    return await apiCall.search(searchInput: searchInput);
  }

  Future<ListPage<Advertisement>> getUserAds(
      {int number = 1, int size = 10}) async {
    return await apiCall.getUserAds(number: number, size: size);
  }

  Future<void> postAdvertisement(
      {required String title,
      required String description,
      required int price,
      required int area,
      required String listviewPhoto,
      required String photo1,
      required String village,
      required String photo2}) async {
    await apiCall.postAdvertisement(
      title: title,
      description: description,
      price: price,
      area: area,
      listviewPhoto: listviewPhoto,
      photo1: photo1,
      village: village,
      photo2: photo2,
    );
  }

  Future<void> deleteAds({required int id}) async {}

  Future<void> updateAdvertisement(
      {required String title,
      required int id,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String listviewPhoto,
      required String village,
      required String photo2}) async {}

  Future<void> sendReport({
    required int id,
    required String report,
  }) async {}
}
