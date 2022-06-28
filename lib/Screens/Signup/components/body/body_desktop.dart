import 'package:flutter/material.dart';
import 'package:flutter_demo/Screens/Login/login_screen.dart';
import 'package:flutter_demo/Screens/Signup/components/background.dart';
import 'package:flutter_demo/Screens/Signup/components/or_divider.dart';
import 'package:flutter_demo/Screens/Signup/components/social_icon.dart';
import 'package:flutter_demo/components/already_have_an_account_acheck.dart';
import 'package:flutter_demo/components/rounded_button.dart';
import 'package:flutter_demo/components/rounded_input_field.dart';
import 'package:flutter_demo/components/rounded_password_field.dart';
import 'package:flutter_demo/responsive/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyDesktop extends StatefulWidget {
  const BodyDesktop({Key? key}) : super(key: key);

  @override
  State<BodyDesktop> createState() => _BodyDesktopState();
}

class _BodyDesktopState extends State<BodyDesktop> {
  var codigo = TextEditingController();
  var clave = TextEditingController();

  late FocusNode codigoFocus;
  late FocusNode claveFocus;

  @override
  void initState() {
    super.initState();
    codigoFocus = FocusNode();
    claveFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    codigoFocus.dispose();
    claveFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context)
                ? size.width * 0.12
                : size.width * 0.07,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: Responsive.isDesktop(context) ? 2 : 1,
                child: SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.5,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedInputField(
                        text: codigo,
                        hintText: "Tú código",
                        onChanged: (value) {},
                        myFocusNode: codigoFocus),
                    RoundedPasswordField(
                        text: clave,
                        obscureText: true,
                        onChanged: (value) {},
                        myFocusNode: claveFocus),
                    RoundedButton(
                      text: "REGISTRAR",
                      press: () {},
                      height: size.height * 0.07,
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const LoginScreen();
                        //     },
                        //   ),
                        // );
                      },
                    ),
                    // const OrDivider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/facebook.svg",
                    //       press: () {},
                    //     ),
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/twitter.svg",
                    //       press: () {},
                    //     ),
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/google-plus.svg",
                    //       press: () {},
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
