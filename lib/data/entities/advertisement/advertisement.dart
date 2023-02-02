import 'package:freezed_annotation/freezed_annotation.dart';

part 'advertisement.freezed.dart';
part 'advertisement.g.dart';

@unfreezed
class Advertisement with _$Advertisement {
  factory Advertisement({
    required int id,
    required String title,
    required String description,
    required int price,
    required String? photo1,
    required String? photo2,
    required String? listViewPhoto,
    required String daySended,
    required String adsType,
    required int area,
    required String userId,
    required bool published,
    required String? phoneNumber,
    required String village,
  }) = _Advertisement;

  factory Advertisement.fromJson(Map<String, Object?> json) =>
      _$AdvertisementFromJson(json);
}
