import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/constants.dart';

class PageOne extends StatefulWidget {
  final Store<AppState> store;
  const PageOne({Key? key, required this.store}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  bool loading = false;
  String plan = "";
  String facultad = "";
  String carrera = "";

  @override
  void initState() {
    super.initState();
    loadInformation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        loadInformation();
      },
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     closeSession();
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     primary: kPrimaryColor,
                      //     shadowColor: Colors.transparent,
                      //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      //   child: const Icon(
                      //     Icons.power_settings_new,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                //SELECCIÓN ALUMNO
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "INFORMACIÓN",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 137, 147),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "ESTUDIANTE",
                              style: TextStyle(
                                color: Color.fromRGBO(155, 166, 175, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: StoreConnector<AppState, Student>(
                                builder: (context, studen) {
                                  return Text(
                                    "Hi, ${studen.persNombre}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(21, 23, 83, 1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                                converter: (store) => store.state.student),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "PLAN DE ESTUDIOS",
                              style: TextStyle(
                                color: Color.fromRGBO(155, 166, 175, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              plan,
                              style: const TextStyle(
                                color: Color.fromRGBO(21, 23, 83, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "FACULTAD",
                              style: TextStyle(
                                color: Color.fromRGBO(155, 166, 175, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              facultad,
                              style: const TextStyle(
                                color: Color.fromRGBO(21, 23, 83, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "CARR./ ESP",
                              style: TextStyle(
                                color: Color.fromRGBO(155, 166, 175, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              carrera,
                              style: const TextStyle(
                                color: Color.fromRGBO(21, 23, 83, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //SELECCIÓN DE CURSOS
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "CLASES ACTUALES",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 137, 147),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(128, 205, 253, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: const [
                                Text(
                                  "TRUE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "10:30",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Text(
                                    "NEXT CLASS",
                                    style: TextStyle(
                                        color: Color.fromRGBO(155, 166, 175, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "Foundation of Nursing an.. Nursing an.. Nursing an..",
                                    style: TextStyle(
                                        color: Color.fromRGBO(21, 23, 83, 1),
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(128, 205, 253, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: const [
                                Text(
                                  "TRUE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "10:30",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Text(
                                    "NEXT CLASS",
                                    style: TextStyle(
                                        color: Color.fromRGBO(155, 166, 175, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "Foundation of Nursing an.. Nursing an.. Nursing an..",
                                    style: TextStyle(
                                        color: Color.fromRGBO(21, 23, 83, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //SECCIÓN DE DASHBOARD
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: const Text(
                    "DASHBOARD",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 137, 147),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.notifications,
                                  size: 35,
                                  color: Color.fromRGBO(128, 205, 253, 1),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 2.5,
                                        bottom: 2.5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      "5",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "Notifications",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      //
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 35,
                                  color: Color.fromRGBO(128, 205, 253, 1),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 2.5,
                                        bottom: 2.5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      "5",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      //
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.feedback,
                                  size: 35,
                                  color: Color.fromRGBO(128, 205, 253, 1),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 2.5,
                                        bottom: 2.5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      "5",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "Feedback",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      //
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.taxi_alert,
                                  size: 35,
                                  color: Color.fromRGBO(128, 205, 253, 1),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 2.5,
                                        bottom: 2.5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      "5",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "Taxi",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),

                //SECCIÓN EVENTOS
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    "EVENTOS",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 137, 147),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 125, 188, 1),
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 125, 188, 1),
                          Color.fromARGB(255, 174, 209, 227),
                          Color.fromRGBO(0, 125, 188, 1)
                        ],
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Positioned(
                          // left: 0,
                          child: SvgPicture.asset(
                            "assets/images/logo_only.svg",
                            width: 150,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        // Positioned(
                        //   child: Image.network(
                        //     'https://www.pngall.com/wp-content/uploads/2016/03/Book-PNG-9.png',
                        //     width: 200,
                        //   ),
                        // ),

                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Upcoming Event",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "check out upcoming campus events",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 138, 198, 224),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 125, 188, 1),
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 125, 188, 1),
                          Color.fromARGB(255, 174, 209, 227),
                          Color.fromRGBO(0, 125, 188, 1)
                        ],
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Positioned(
                          // left: 0,
                          child: SvgPicture.asset(
                            "assets/images/logo_only.svg",
                            width: 150,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        // Positioned(
                        //   child: Image.network(
                        //     'https://www.pngall.com/wp-content/uploads/2016/03/Book-PNG-9.png',
                        //     width: 200,
                        //   ),
                        // ),

                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Upcoming Event",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "check out upcoming campus events",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 138, 198, 224),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
      });

      var url = Uri.parse('https://cualquiera.upla.edu.pe/estudiante/consNota');
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
            plan = list[0]["mtr_Anio"] + "-" + list[0]["mtr_Periodo"];
            facultad = list[0]["nombreFacultad"];
            carrera = list[0]["nombreCarrera"];
            loading = false;
          });
        }
      } else {
        print(response.body);
      }
    } on TimeoutException catch (_) {}
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
