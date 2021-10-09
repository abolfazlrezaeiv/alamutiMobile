import 'package:alamuti/core/error/failures.dart';
import 'package:alamuti/features/alamuti/domain/entities/advertisement.dart';

abstract class AdvertismentRepository {
  Future<Advertisement> getAllAdvertisement();
  Future<Advertisement> getAdvertisementById(int id);
}
