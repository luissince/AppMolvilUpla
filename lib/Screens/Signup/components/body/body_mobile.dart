import 'package:flutter/material.dart';
import 'package:flutter_demo/Screens/Signup/components/background.dart';
import 'package:flutter_demo/components/already_have_an_account_acheck.dart';
import 'package:flutter_demo/components/rounded_button.dart';
import 'package:flutter_demo/components/rounded_input_field.dart';
import 'package:flutter_demo/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class BodyMobile extends StatefulWidget {
  const BodyMobile({Key? key}) : super(key: key);

  @override
  State<BodyMobile> createState() => _BodyMobileState();
}

class _BodyMobileState extends State<BodyMobile> {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "REGISTRAR",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.30,
              ),
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
        ),
      ),
    );
  }
}
