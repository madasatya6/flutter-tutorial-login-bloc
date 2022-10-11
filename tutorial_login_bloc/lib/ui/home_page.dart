import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';
import 'package:tutorial_login_bloc/ui/about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Container(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/about');
                },
                child: Text("Go to About"),
              ),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  authenticationBloc.add(LoggedOut());
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
