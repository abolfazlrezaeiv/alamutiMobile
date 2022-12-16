import 'package:alamuti/app/data/entities/register_request_model.dart';
import 'package:alamuti/app/data/provider/login_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginProvider loginProvider;
  AuthBloc({required this.loginProvider}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is LoginStatusCheckEvent) {
        loginProvider.isLogged ? emit(LoggedInUser()) : emit(LoggedOutUser());
      }

      if (event is LoginByPhoneNumberEvent) {
        loginProvider
            .authenticateByPhoneNumber(event.authByPhoneNumberRequestModel);
      }
    });
  }
}
