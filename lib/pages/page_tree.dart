import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/pages/background.dart';
import 'package:flutter_demo/pages/perfil/card_perfil.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageTree extends StatefulWidget {
  final Store<AppState> store;
  const PageTree({Key? key, required this.store}) : super(key: key);

  @override
  State<PageTree> createState() => _PageTreeState();
}

class _PageTreeState extends State<PageTree> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  //TITULO
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/logo_only.svg",
                              height: size.height * 0.14,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
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
                                const Text(
                                  "UNIVERSIDAD PERUANA LOS ANDES",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 7,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /**
                   * 
                   */
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: kPrimaryColor, width: 2),
                            ),
                          ),
                          child: const Text(
                            "PERFIL",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/perfil.svg",
                              width: 80,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  /**
                   * 
                   */
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: kPrimaryColor, width: 2),
                            ),
                          ),
                          child: const Text(
                            "DATOS PERSONALES",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ),
                        /**
                       * 
                       */
                        CardPerfil(title: "Código", description: "R01655A"),
                        SizedBox(
                          height: 10,
                        ),
                        /**
                       * 
                       */
                        CardPerfil(
                            title: "Nombres", description: "ANTONELLA MIDHEI"),
                        SizedBox(
                          height: 10,
                        ),

                        /**
                       * 
                       */
                        CardPerfil(
                            title: "Apellido Paterno",
                            description: "GUTIERREZ"),
                        SizedBox(
                          height: 10,
                        ),

                        /**
                       * 
                       */
                        CardPerfil(
                            title: "Apellido Materno", description: "QUISPE"),
                        SizedBox(
                          height: 10,
                        ),

                        /**
                       * 
                       */
                        CardPerfil(title: "DNI", description: "76759222"),
                        SizedBox(
                          height: 10,
                        ),

                        /**
                       * 
                       */
                        CardPerfil(
                            title: "Fecha de nacimiento",
                            description: "23/11/2003"),
                        SizedBox(
                          height: 10,
                        ),

                        /**
                       * 
                       */
                        CardPerfil(title: "Edad", description: "18"),
                        SizedBox(
                          height: 10,
                        ),

                        /**
                       * 
                       */
                        CardPerfil(
                            title: "Estado civil", description: "Soltero"),
                      ],
                    ),
                  ),

                  /**
                   * 
                   */
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        closeSession();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.power_settings_new,
                            color: Colors.white,
                          ),
                          Text("Cerrar Sesión")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    widget.store.dispatch(SignOut(false, true, Student("", "", "", "", "")));

    navigationLogin();
  }

  void navigationLogin() {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
