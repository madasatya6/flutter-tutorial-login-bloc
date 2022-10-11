import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/states/authentication_state.dart';
import 'package:tutorial_login_bloc/ui/loading_indicator.dart';

class PublicMidleware extends StatelessWidget {
  final Widget child;
  const PublicMidleware({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return RedirectToHome();
        }

        return child;
      },
    );
  }
}

class RedirectToHome extends StatefulWidget {
  const RedirectToHome({Key? key}) : super(key: key);

  @override
  State<RedirectToHome> createState() => _RedirectToHomeState();
}

class _RedirectToHomeState extends State<RedirectToHome> {
  @override
  void initState() {
    Future.delayed(Duration(microseconds: 500))
        .then((value) => Navigator.pushReplacementNamed(context, '/home'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator();
  }
}
