import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  List<Object>? data;
  AuthenticationEvent({this.data}) : super();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({required this.token}) : super(data: [token]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
