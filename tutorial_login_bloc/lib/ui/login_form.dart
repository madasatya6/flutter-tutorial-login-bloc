import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/bloc/login_bloc.dart';
import 'package:tutorial_login_bloc/events/login_event.dart';
import 'package:tutorial_login_bloc/states/login_state.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
          });
        }

        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: _passwordController,
                obscureText: true,
              ),
              MaterialButton(
                onPressed: () {
                  _onLoginButtonPressed(context);
                },
                child: Text('Login'),
              ),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      callback();
    });
  }

  _onLoginButtonPressed(BuildContext context) {
    context.read<LoginBloc>().add(LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ));
  }
}
