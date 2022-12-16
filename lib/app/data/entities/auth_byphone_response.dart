import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_byphone_response.freezed.dart';
part 'auth_byphone_response.g.dart';

@freezed
class AuthenticationByPhoneResponse with _$AuthenticationByPhoneResponse {
  const factory AuthenticationByPhoneResponse({
    required String? phonenumber,
    required String? userId,
  }) = _AuthenticationByPhoneResponse;

  factory AuthenticationByPhoneResponse.fromJson(Map<String, Object?> json) =>
      _$AuthenticationByPhoneResponseFromJson(json);
}
