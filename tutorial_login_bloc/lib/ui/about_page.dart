import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Container(
        child: Center(
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go to Home"),
          ),
        ),
      ),
    );
  }
}
