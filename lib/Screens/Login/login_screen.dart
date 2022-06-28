import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/Screens/Login/components/body/body.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatelessWidget {
  final Store<AppState> store;
  const LoginScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: Body(store: store),
    );
  }
}
