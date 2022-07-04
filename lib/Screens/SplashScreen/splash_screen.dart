import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/constants.dart';

class SplashScreen extends StatefulWidget {
  final Store<AppState> store;
  const SplashScreen({Key? key, required this.store}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    sleepWidget();
  }

  void sleepWidget() {
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString("token") != null) {
          widget.store.dispatch(
            RestoreToken(
              true,
              false,
              Student(
                  prefs.getString("token")!,
                  prefs.getString("docNumId")!,
                  prefs.getString("persPaterno")!,
                  prefs.getString("persMaterno")!,
                  prefs.getString("persNombre")!),
            ),
          );
          navigatorHome();
        } else {
          navigatorWelcome();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /**
             * 
             */
            SvgPicture.asset(
              "assets/images/logo_only.svg",
              height: 180,
            ),
            /**
             * 
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "U",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 34),
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  "P",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 34),
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  "L",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 34),
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  "A",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 34),
                ),
              ],
            ),
            /**
             * 
             */
            const Text(
              "UNIVERSIDAD PERUANA LOS ANDES",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 7,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            /**
             * 
             */
            if (Platform.isIOS)
              const CupertinoActivityIndicator(
                radius: 15,
              )
            else
              const CircularProgressIndicator(
                color: Color.fromRGBO(0, 125, 188, 1),
              )
          ],
        ),
      ),
    );
  }

  void navigatorHome() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  void navigatorWelcome() {
    Navigator.pushReplacementNamed(context, "/welcome");
  }
}
