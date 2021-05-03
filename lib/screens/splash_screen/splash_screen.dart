import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnship/logic/bloc/blocs.dart';
import 'package:learnship/screens/navigation_screen/navigation_screen.dart';
import 'package:learnship/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // print(state);
          if (state.status == AuthStatus.unauthenticated) {
            //Go to the Login
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            //Go to the Nav Screen
            Navigator.of(context).pushNamed(NavigationScreen.routeName);
          }
        },
        child: Scaffold(
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
