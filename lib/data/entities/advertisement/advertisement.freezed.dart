// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advertisement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Advertisement _$AdvertisementFromJson(Map<String, dynamic> json) {
  return _Advertisement.fromJson(json);
}

/// @nodoc
mixin _$Advertisement {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  set description(String value) => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  set price(int value) => throw _privateConstructorUsedError;
  String? get photo1 => throw _privateConstructorUsedError;
  set photo1(String? value) => throw _privateConstructorUsedError;
  String? get photo2 => throw _privateConstructorUsedError;
  set photo2(String? value) => throw _privateConstructorUsedError;
  String? get listViewPhoto => throw _privateConstructorUsedError;
  set listViewPhoto(String? value) => throw _privateConstructorUsedError;
  String get daySended => throw _privateConstructorUsedError;
  set daySended(String value) => throw _privateConstructorUsedError;
  String get adsType => throw _privateConstructorUsedError;
  set adsType(String value) => throw _privateConstructorUsedError;
  int get area => throw _privateConstructorUsedError;
  set area(int value) => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  set userId(String value) => throw _privateConstructorUsedError;
  bool get published => throw _privateConstructorUsedError;
  set published(bool value) => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  set phoneNumber(String? value) => throw _privateConstructorUsedError;
  String get village => throw _privateConstructorUsedError;
  set village(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdvertisementCopyWith<Advertisement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvertisementCopyWith<$Res> {
  factory $AdvertisementCopyWith(
          Advertisement value, $Res Function(Advertisement) then) =
      _$AdvertisementCopyWithImpl<$Res, Advertisement>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      int price,
      String? photo1,
      String? photo2,
      String? listViewPhoto,
      String daySended,
      String adsType,
      int area,
      String userId,
      bool published,
      String? phoneNumber,
      String village});
}

/// @nodoc
class _$AdvertisementCopyWithImpl<$Res, $Val extends Advertisement>
    implements $AdvertisementCopyWith<$Res> {
  _$AdvertisementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? photo1 = freezed,
    Object? photo2 = freezed,
    Object? listViewPhoto = freezed,
    Object? daySended = null,
    Object? adsType = null,
    Object? area = null,
    Object? userId = null,
    Object? published = null,
    Object? phoneNumber = freezed,
    Object? village = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      photo1: freezed == photo1
          ? _value.photo1
          : photo1 // ignore: cast_nullable_to_non_nullable
              as String?,
      photo2: freezed == photo2
          ? _value.photo2
          : photo2 // ignore: cast_nullable_to_non_nullable
              as String?,
      listViewPhoto: freezed == listViewPhoto
          ? _value.listViewPhoto
          : listViewPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      daySended: null == daySended
          ? _value.daySended
          : daySended // ignore: cast_nullable_to_non_nullable
              as String,
      adsType: null == adsType
          ? _value.adsType
          : adsType // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      published: null == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      village: null == village
          ? _value.village
          : village // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdvertisementCopyWith<$Res>
    implements $AdvertisementCopyWith<$Res> {
  factory _$$_AdvertisementCopyWith(
          _$_Advertisement value, $Res Function(_$_Advertisement) then) =
      __$$_AdvertisementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      int price,
      String? photo1,
      String? photo2,
      String? listViewPhoto,
      String daySended,
      String adsType,
      int area,
      String userId,
      bool published,
      String? phoneNumber,
      String village});
}

/// @nodoc
class __$$_AdvertisementCopyWithImpl<$Res>
    extends _$AdvertisementCopyWithImpl<$Res, _$_Advertisement>
    implements _$$_AdvertisementCopyWith<$Res> {
  __$$_AdvertisementCopyWithImpl(
      _$_Advertisement _value, $Res Function(_$_Advertisement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? photo1 = freezed,
    Object? photo2 = freezed,
    Object? listViewPhoto = freezed,
    Object? daySended = null,
    Object? adsType = null,
    Object? area = null,
    Object? userId = null,
    Object? published = null,
    Object? phoneNumber = freezed,
    Object? village = null,
  }) {
    return _then(_$_Advertisement(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      photo1: freezed == photo1
          ? _value.photo1
          : photo1 // ignore: cast_nullable_to_non_nullable
              as String?,
      photo2: freezed == photo2
          ? _value.photo2
          : photo2 // ignore: cast_nullable_to_non_nullable
              as String?,
      listViewPhoto: freezed == listViewPhoto
          ? _value.listViewPhoto
          : listViewPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      daySended: null == daySended
          ? _value.daySended
          : daySended // ignore: cast_nullable_to_non_nullable
              as String,
      adsType: null == adsType
          ? _value.adsType
          : adsType // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      published: null == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      village: null == village
          ? _value.village
          : village // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Advertisement implements _Advertisement {
  _$_Advertisement(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.photo1,
      required this.photo2,
      required this.listViewPhoto,
      required this.daySended,
      required this.adsType,
      required this.area,
      required this.userId,
      required this.published,
      required this.phoneNumber,
      required this.village});

  factory _$_Advertisement.fromJson(Map<String, dynamic> json) =>
      _$$_AdvertisementFromJson(json);

  @override
  int id;
  @override
  String title;
  @override
  String description;
  @override
  int price;
  @override
  String? photo1;
  @override
  String? photo2;
  @override
  String? listViewPhoto;
  @override
  String daySended;
  @override
  String adsType;
  @override
  int area;
  @override
  String userId;
  @override
  bool published;
  @override
  String? phoneNumber;
  @override
  String village;

  @override
  String toString() {
    return 'Advertisement(id: $id, title: $title, description: $description, price: $price, photo1: $photo1, photo2: $photo2, listViewPhoto: $listViewPhoto, daySended: $daySended, adsType: $adsType, area: $area, userId: $userId, published: $published, phoneNumber: $phoneNumber, village: $village)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdvertisementCopyWith<_$_Advertisement> get copyWith =>
      __$$_AdvertisementCopyWithImpl<_$_Advertisement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdvertisementToJson(
      this,
    );
  }
}

abstract class _Advertisement implements Advertisement {
  factory _Advertisement(
      {required int id,
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
      required String village}) = _$_Advertisement;

  factory _Advertisement.fromJson(Map<String, dynamic> json) =
      _$_Advertisement.fromJson;

  @override
  int get id;
  set id(int value);
  @override
  String get title;
  set title(String value);
  @override
  String get description;
  set description(String value);
  @override
  int get price;
  set price(int value);
  @override
  String? get photo1;
  set photo1(String? value);
  @override
  String? get photo2;
  set photo2(String? value);
  @override
  String? get listViewPhoto;
  set listViewPhoto(String? value);
  @override
  String get daySended;
  set daySended(String value);
  @override
  String get adsType;
  set adsType(String value);
  @override
  int get area;
  set area(int value);
  @override
  String get userId;
  set userId(String value);
  @override
  bool get published;
  set published(bool value);
  @override
  String? get phoneNumber;
  set phoneNumber(String? value);
  @override
  String get village;
  set village(String value);
  @override
  @JsonKey(ignore: true)
  _$$_AdvertisementCopyWith<_$_Advertisement> get copyWith =>
      throw _privateConstructorUsedError;
}
