import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/states/authentication_state.dart';
import 'package:tutorial_login_bloc/ui/loading_indicator.dart';

class SessionMidleware extends StatelessWidget {
  final Widget child;
  const SessionMidleware({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationUninitialized) {
          return RedirectToSplashscreen();
        }

        if (state is AuthenticationUnauthenticated) {
          return RedirectToLoginPage();
        }

        return child;
      },
    );
  }
}

class RedirectToSplashscreen extends StatefulWidget {
  const RedirectToSplashscreen({Key? key}) : super(key: key);

  @override
  State<RedirectToSplashscreen> createState() => _RedirectToSplashscreenState();
}

class _RedirectToSplashscreenState extends State<RedirectToSplashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100))
        .then((value) => Navigator.pushReplacementNamed(context, '/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator();
  }
}

class RedirectToLoginPage extends StatefulWidget {
  const RedirectToLoginPage({Key? key}) : super(key: key);

  @override
  State<RedirectToLoginPage> createState() => _RedirectToLoginPageState();
}

class _RedirectToLoginPageState extends State<RedirectToLoginPage> {
  @override
  void initState() {
    Future.delayed(Duration(microseconds: 100))
        .then((value) => Navigator.pushReplacementNamed(context, '/login'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator();
  }
}
