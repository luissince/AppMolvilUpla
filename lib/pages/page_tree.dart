import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
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

    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    /**
                     * 
                     */
                    SvgPicture.asset(
                      "assets/icons/perfil.svg",
                      height: size.height * 0.35,
                    ),
                    /**
                     * 
                     */
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "PERFIL",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    /**
                     * 
                     */
                    const Text("Datos Personales"),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: const [
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
                        title: "Apellido Paterno", description: "GUTIERREZ"),
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
                    CardPerfil(title: "Estado civil", description: "Soltero"),
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
