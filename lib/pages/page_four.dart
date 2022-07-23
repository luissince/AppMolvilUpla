import 'dart:async';

import 'package:flutter_demo/components/activity_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/pages/background.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PageFour extends StatefulWidget {
  final Store<AppState> store;
  const PageFour({Key? key, required this.store}) : super(key: key);

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  bool loading = false;
  bool responseOk = false;

  String codigo = "";
  String nombre = "";
  String apPaterno = "";
  String apMaterno = "";
  String edad = "";
  String fcNacimiento = "";

  @override
  void initState() {
    super.initState();
    loadInformation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SafeArea(
        child: loading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !responseOk
                          ? Column(
                              children: const [
                                ActivityIndicator(
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Cargando información...",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          : Column(
                              children: const [
                                Text(
                                  "Tiempo de espera agotado.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /**
                * 
                */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/images/logo_only.svg",
                              height: size.height * 0.08,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: size.height * 0.08,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://academico.upla.edu.pe/FotosAlum/037000${widget.store.state.student.docNumId}.jpg"),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ],
                      ),

                      /**
                * 
                */
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text(
                          "Perfil",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      /**
                * 
                */
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.more_horiz,
                                  size: 32,
                                  color: Color.fromRGBO(252, 127, 167, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Código",
                                        style: TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        codigo,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /**
                * 
                */
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.more_horiz,
                                  size: 32,
                                  color: Color.fromRGBO(252, 127, 167, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Nombres",
                                        style: TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        nombre,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /**
                * 
                */
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.more_horiz,
                                  size: 32,
                                  color: Color.fromRGBO(252, 127, 167, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Apellido Paterno",
                                        style: TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        apPaterno,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /**
                * 
                */
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.more_horiz,
                                  size: 32,
                                  color: Color.fromRGBO(252, 127, 167, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Apellido Materno",
                                        style: TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        apMaterno,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /**
                * 
                */
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.more_horiz,
                                  size: 32,
                                  color: Color.fromRGBO(252, 127, 167, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Edad",
                                        style: TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        edad,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /**
                * 
                */
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.more_horiz,
                                  size: 32,
                                  color: Color.fromRGBO(252, 127, 167, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Fecha de Nacimiento",
                                        style: TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        fcNacimiento,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      /**
                * 
                */
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text(
                          "Opción",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
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
                            shadowColor: Colors.white,
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
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Cerrar Sesión",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /**
                   * 
                   */
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> loadInformation() async {
    if (loading) {
      return;
    }

    try {
      setState(() {
        loading = true;
        responseOk = false;
      });

      var url =
          Uri.parse('https://cualquiera.upla.edu.pe/estudiante/datosFicha');
      var response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${widget.store.state.student.token}'
            },
            body: convert.jsonEncode(<String, String>{
              "codigo": widget.store.state.student.docNumId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = convert.jsonDecode(response.body);
        List<dynamic> list = List.from(jsonData);
        if (list.isNotEmpty) {
          setState(() {
            codigo = list[0]["cod"];
            nombre = list[0]["nom"];
            apPaterno = list[0]["ap_pat"];
            apMaterno = list[0]["ap_mat"];
            edad = list[0]["edad"].toString();
            fcNacimiento = list[0]["f_nac"];
            loading = false;
            responseOk = true;
          });
        } else {
          setState(() {
            loading = false;
            responseOk = true;
          });
        }
      } else {
        setState(() {
          responseOk = false;
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        responseOk = false;
      });
    }
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
