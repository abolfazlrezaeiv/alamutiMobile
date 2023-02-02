import 'package:alamuti/data/entities/advertisement/advertisement.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'advertisement_list.freezed.dart';
part 'advertisement_list.g.dart';

@unfreezed
class AdvertisementListResponse with _$AdvertisementListResponse {
  factory AdvertisementListResponse({
    required List<Advertisement> advertisements,
  }) = _AdvertisementListResponse;

  factory AdvertisementListResponse.fromJson(Map<String, Object?> json) =>
      _$AdvertisementListResponseFromJson(json);
}
