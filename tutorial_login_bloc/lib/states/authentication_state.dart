import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

// if the authentication state was uninitialized, the user might be seeing a splash screen.
class AuthenticationUninitialized extends AuthenticationState {}

// if the authentication state was authenticated, the user might see a home screen.
class AuthenticationAuthenticated extends AuthenticationState {}

// if the authentication state was unauthenticated, the user might see a login form.
class AuthenticationUnauthenticated extends AuthenticationState {}

// if the authentication state was loading, the user might be seeing a progress indicator.
class AuthenticationLoading extends AuthenticationState {}
