import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';
import 'package:tutorial_login_bloc/states/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(super.initialState) : super() {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await UserRepository().hasToken();
      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      await UserRepository().persistToken(event.token);
      emit(AuthenticationAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await UserRepository().deleteToken();
      emit(AuthenticationUnauthenticated());
    });
  }

  @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();
}
