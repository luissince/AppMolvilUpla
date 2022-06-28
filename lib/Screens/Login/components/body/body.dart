import 'package:flutter/material.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/responsive/responsive.dart';
import 'package:flutter_demo/Screens/Login/components/body/body_mobile.dart';
import 'package:flutter_demo/Screens/Login/components/body/body_desktop.dart';
import 'package:redux/redux.dart';

class Body extends StatelessWidget {
  final Store<AppState> store;
  const Body({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: BodyMobile(store: store),
      tablet: BodyDesktop(store: store),
      desktop: BodyDesktop(store: store),
    );
  }
}
