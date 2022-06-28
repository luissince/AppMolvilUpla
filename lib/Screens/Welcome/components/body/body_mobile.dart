import 'package:flutter/material.dart';
import 'package:flutter_demo/Screens/Welcome/components/background.dart';
import 'package:flutter_demo/components/rounded_button.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_svg/svg.dart';

class BodyMobile extends StatelessWidget {
  const BodyMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    height: size.height * 0.45,
                  ),
                  const Text(
                    "UPLA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  const Text(
                    "En un sola plataforma",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    child: const Text(
                      "Cualquiera puede unirse a los millones de miembros de nuestra comunidad para aprender habilidades de vanguardia.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: 15,
                  //   height: 15,
                  //   margin: const EdgeInsets.only(left: 5, right: 5),
                  //   decoration: BoxDecoration(
                  //     color: kPrimaryColor,
                  //     borderRadius: BorderRadius.circular(150.0),
                  //   ),
                  // ),
                  Container(
                    width: 15,
                    height: 15,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: RoundedButton(
                text: "Iniciar",
                press: () async {
                  Navigator.pushReplacementNamed(context, "/login");
                  // Navigator.of(context).pushReplacement(
                  //   // context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const LoginScreen();
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
