// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Advertisement _$$_AdvertisementFromJson(Map<String, dynamic> json) =>
    _$_Advertisement(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      photo1: json['photo1'] as String?,
      photo2: json['photo2'] as String?,
      listViewPhoto: json['listViewPhoto'] as String?,
      daySended: json['daySended'] as String,
      adsType: json['adsType'] as String,
      area: json['area'] as int,
      userId: json['userId'] as String,
      published: json['published'] as bool,
      phoneNumber: json['phoneNumber'] as String?,
      village: json['village'] as String,
    );

Map<String, dynamic> _$$_AdvertisementToJson(_$_Advertisement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'photo1': instance.photo1,
      'photo2': instance.photo2,
      'listViewPhoto': instance.listViewPhoto,
      'daySended': instance.daySended,
      'adsType': instance.adsType,
      'area': instance.area,
      'userId': instance.userId,
      'published': instance.published,
      'phoneNumber': instance.phoneNumber,
      'village': instance.village,
    };
