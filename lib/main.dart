import 'package:flutter/material.dart';
import 'package:flutter_demo/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter_demo/Screens/Login/login_screen.dart';
import 'package:flutter_demo/Screens/Signup/signup_screen.dart';
import 'package:flutter_demo/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

AppState counterReducer(AppState previousState, dynamic action) {
  if (action is RestoreToken) {
    return AppState(
      action.isLoading,
      action.isSignout,
      Student(
          action.student.token,
          action.student.docNumId,
          action.student.persPaterno,
          action.student.persMaterno,
          action.student.persNombre),
    );
  } else if (action is SignIn) {
    return AppState(
      action.isLoading,
      action.isSignout,
      Student(
          action.student.token,
          action.student.docNumId,
          action.student.persPaterno,
          action.student.persMaterno,
          action.student.persNombre),
    );
  } else if (action is SignOut) {
    return AppState(
      action.isLoading,
      action.isSignout,
      Student(
          action.student.token,
          action.student.docNumId,
          action.student.persPaterno,
          action.student.persMaterno,
          action.student.persNombre),
    );
  }
  return previousState;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Store<AppState> store =
      Store<AppState>(counterReducer, initialState: AppState.initialState());

  _MyAppState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'App Upla',
        theme: ThemeData(
            // primarySwatch: Colors.blue,
            primaryColor: Colors.black),
        home: SplashScreen(store: store),
        routes: <String, WidgetBuilder>{
          '/welcome': (BuildContext context) => const WelcomeScreen(),
          '/login': (BuildContext context) => LoginScreen(store: store),
          '/signup': (BuildContext context) => const SignUpScreen(),
          '/home': (BuildContext context) => HomePage(store: store),
        },
      ),
    );
  }
}
