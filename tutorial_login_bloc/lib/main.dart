import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/bloc/login_bloc.dart';
import 'package:tutorial_login_bloc/ui/splash_page.dart';
import 'package:tutorial_login_bloc/ui/home_page.dart';

class SimpleBlocDelegate extends BlocDelegate {}

void main() {
  runApp(const MyApp());
}

// reference https://medium.com/flutter-community/flutter-login-tutorial-with-flutter-bloc-ea606ef701ad
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
