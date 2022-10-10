import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/bloc/login_bloc.dart';
import 'package:tutorial_login_bloc/states/login_state.dart';
import 'package:tutorial_login_bloc/ui/login_form.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: LoginForm(),
    );
  }
}
