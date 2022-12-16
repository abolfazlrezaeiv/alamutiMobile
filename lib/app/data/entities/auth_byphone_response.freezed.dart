// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_byphone_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthenticationByPhoneResponse _$AuthenticationByPhoneResponseFromJson(
    Map<String, dynamic> json) {
  return _AuthenticationByPhoneResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationByPhoneResponse {
  String? get phonenumber => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationByPhoneResponseCopyWith<AuthenticationByPhoneResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationByPhoneResponseCopyWith<$Res> {
  factory $AuthenticationByPhoneResponseCopyWith(
          AuthenticationByPhoneResponse value,
          $Res Function(AuthenticationByPhoneResponse) then) =
      _$AuthenticationByPhoneResponseCopyWithImpl<$Res,
          AuthenticationByPhoneResponse>;
  @useResult
  $Res call({String? phonenumber, String? userId});
}

/// @nodoc
class _$AuthenticationByPhoneResponseCopyWithImpl<$Res,
        $Val extends AuthenticationByPhoneResponse>
    implements $AuthenticationByPhoneResponseCopyWith<$Res> {
  _$AuthenticationByPhoneResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phonenumber = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      phonenumber: freezed == phonenumber
          ? _value.phonenumber
          : phonenumber // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthenticationByPhoneResponseCopyWith<$Res>
    implements $AuthenticationByPhoneResponseCopyWith<$Res> {
  factory _$$_AuthenticationByPhoneResponseCopyWith(
          _$_AuthenticationByPhoneResponse value,
          $Res Function(_$_AuthenticationByPhoneResponse) then) =
      __$$_AuthenticationByPhoneResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? phonenumber, String? userId});
}

/// @nodoc
class __$$_AuthenticationByPhoneResponseCopyWithImpl<$Res>
    extends _$AuthenticationByPhoneResponseCopyWithImpl<$Res,
        _$_AuthenticationByPhoneResponse>
    implements _$$_AuthenticationByPhoneResponseCopyWith<$Res> {
  __$$_AuthenticationByPhoneResponseCopyWithImpl(
      _$_AuthenticationByPhoneResponse _value,
      $Res Function(_$_AuthenticationByPhoneResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phonenumber = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$_AuthenticationByPhoneResponse(
      phonenumber: freezed == phonenumber
          ? _value.phonenumber
          : phonenumber // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthenticationByPhoneResponse
    implements _AuthenticationByPhoneResponse {
  const _$_AuthenticationByPhoneResponse(
      {required this.phonenumber, required this.userId});

  factory _$_AuthenticationByPhoneResponse.fromJson(
          Map<String, dynamic> json) =>
      _$$_AuthenticationByPhoneResponseFromJson(json);

  @override
  final String? phonenumber;
  @override
  final String? userId;

  @override
  String toString() {
    return 'AuthenticationByPhoneResponse(phonenumber: $phonenumber, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthenticationByPhoneResponse &&
            (identical(other.phonenumber, phonenumber) ||
                other.phonenumber == phonenumber) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phonenumber, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthenticationByPhoneResponseCopyWith<_$_AuthenticationByPhoneResponse>
      get copyWith => __$$_AuthenticationByPhoneResponseCopyWithImpl<
          _$_AuthenticationByPhoneResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthenticationByPhoneResponseToJson(
      this,
    );
  }
}

abstract class _AuthenticationByPhoneResponse
    implements AuthenticationByPhoneResponse {
  const factory _AuthenticationByPhoneResponse(
      {required final String? phonenumber,
      required final String? userId}) = _$_AuthenticationByPhoneResponse;

  factory _AuthenticationByPhoneResponse.fromJson(Map<String, dynamic> json) =
      _$_AuthenticationByPhoneResponse.fromJson;

  @override
  String? get phonenumber;
  @override
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$_AuthenticationByPhoneResponseCopyWith<_$_AuthenticationByPhoneResponse>
      get copyWith => throw _privateConstructorUsedError;
}
