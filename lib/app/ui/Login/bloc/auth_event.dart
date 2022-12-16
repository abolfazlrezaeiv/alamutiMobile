part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class LoginStatusCheckEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginByPhoneNumberEvent extends AuthEvent {
  final AuthByPhoneNumberRequestModel authByPhoneNumberRequestModel;

  LoginByPhoneNumberEvent({required this.authByPhoneNumberRequestModel});
  @override
  List<Object?> get props => [authByPhoneNumberRequestModel];
}

class LogoutEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OtpCodeEntered extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
