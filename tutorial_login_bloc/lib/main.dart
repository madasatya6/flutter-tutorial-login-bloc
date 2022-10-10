import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_login_bloc/events/authentication_event.dart';
import 'package:tutorial_login_bloc/repository/user_repository.dart';
import 'package:tutorial_login_bloc/bloc/authentication_bloc.dart';
import 'package:tutorial_login_bloc/bloc/login_bloc.dart';
import 'package:tutorial_login_bloc/states/authentication_state.dart';
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

// reference https://medium.com/flutter-community/flutter-login-tutorial-with-flutter-bloc-ea606ef701ad
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
  late AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    // authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository)),
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
                  userRepository: userRepository,
                  authenticationBloc: authenticationBloc,
                )),
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage(userRepository: userRepository);
            }

            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }

            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }

            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }

            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
