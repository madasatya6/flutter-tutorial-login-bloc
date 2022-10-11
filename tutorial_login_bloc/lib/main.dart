import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';
import 'package:tutorial_login_bloc/middlewares/public_middleware.dart';
import 'package:tutorial_login_bloc/middlewares/session_middleware.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/bloc/login_bloc.dart';
import 'package:tutorial_login_bloc/states/authentication_state.dart';
import 'package:tutorial_login_bloc/ui/about_page.dart';
import 'package:tutorial_login_bloc/ui/loading_indicator.dart';
import 'package:tutorial_login_bloc/ui/login_page.dart';
import 'package:tutorial_login_bloc/ui/splash_page.dart';
import 'package:tutorial_login_bloc/ui/home_page.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp(
      userRepository: UserRepository(),
    )),
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

/**
 * @author madasatya6
 * 
 * flutter versi 1: https://medium.com/flutter-community/flutter-login-tutorial-with-flutter-bloc-ea606ef701ad
 * flutter versi 2: in this tutorial
 */
class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  const MyApp({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository get userRepository => widget.userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository)),
        BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(userRepository: userRepository, context: context)),
      ],
      child: StartApp(userRepository: userRepository),
    );
  }
}

class StartApp extends StatefulWidget {
  final UserRepository userRepository;
  const StartApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => PublicMidleware(
            child: SplashPage(userRepository: widget.userRepository)),
        '/login': (context) => PublicMidleware(
            child: LoginPage(userRepository: widget.userRepository)),
        '/home': (context) => SessionMidleware(child: HomePage()),
        '/about': (context) => SessionMidleware(child: AboutPage()),
      },
    );
  }
}
