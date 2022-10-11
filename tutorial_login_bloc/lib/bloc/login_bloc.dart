import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/events/login_event.dart';
import 'package:tutorial_login_bloc/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final BuildContext context;

  LoginBloc({required this.userRepository, required this.context})
      : assert(userRepository != null),
        assert(context != null),
        super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);

        context.read<AuthenticationBloc>().add(LoggedIn(token: token));

        emit(LoginSuccess());
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
