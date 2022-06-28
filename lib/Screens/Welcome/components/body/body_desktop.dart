import 'package:flutter/material.dart';
import 'package:flutter_demo/Screens/Login/components/background.dart';
import 'package:flutter_demo/Screens/Login/login_screen.dart';
import 'package:flutter_demo/Screens/Signup/signup_screen.dart';
import 'package:flutter_demo/components/rounded_button.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyDesktop extends StatelessWidget {
  const BodyDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  "assets/icons/chat.svg",
                  height: size.height * 0.65,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'UPLA',
                      style: TextStyle(
                        fontSize: size.height * 0.075,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.01),
                    const Text(
                      "En un sola plataforma",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      width: 80,
                      height: 5,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Cualquiera puede unirse a los millones de miembros de nuestra comunidad para aprender habilidades de vanguardia.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.height * 0.035,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RoundedButton(
                      text: "INICIAR",
                      press: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      height: size.height * 0.097,
                    ),
                    // RoundedButton(
                    //   text: "",
                    //   color: kPrimaryLightColor,
                    //   textColor: Colors.black,
                    //   press: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return const SignUpScreen();
                    //         },
                    //       ),
                    //     );
                    //   },
                    //   height: size.height * 0.07,
                    // ),
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
