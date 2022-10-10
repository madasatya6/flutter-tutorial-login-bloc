import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/events/login_event.dart';
import 'package:tutorial_login_bloc/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.userRepository, required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);

        authenticationBloc.add(LoggedIn(token: token));
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }

  @override
  LoginState get inititalState => LoginInitial();

  @override
  Future<void> close() {
    return super.close();
  }
}
