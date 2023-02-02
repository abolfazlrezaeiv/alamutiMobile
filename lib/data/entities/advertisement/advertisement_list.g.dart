// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AdvertisementListResponse _$$_AdvertisementListResponseFromJson(
        Map<String, dynamic> json) =>
    _$_AdvertisementListResponse(
      advertisements: (json['advertisements'] as List<dynamic>)
          .map((e) => Advertisement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AdvertisementListResponseToJson(
        _$_AdvertisementListResponse instance) =>
    <String, dynamic>{
      'advertisements': instance.advertisements,
    };
