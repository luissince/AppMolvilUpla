import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/Pagos.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/constants.dart';

class PageTwo extends StatefulWidget {
  final Store<AppState> store;
  const PageTwo({Key? key, required this.store}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool loading = false;
  List<Pagos> listPagos = [];

  @override
  void initState() {
    super.initState();
    loadCuotasPensiones();
  }

  @override
  void dispose() {
    super.dispose();
    print("close widget");
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.store.state.student.token);
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        loadCuotasPensiones();
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
                    "CONSULTA DE ESTADO DE DEUDA",
                    style: TextStyle(
                        color: Color.fromRGBO(155, 166, 175, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[100],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: const [
                                Text(
                                  "Upcomming",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "4",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "exams",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                const Text(
                                  "Homework",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                  ),
                                  child: const Text(
                                    "73%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "completed",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadCuotasPensiones() async {
    if (loading) {
      return;
    }

    try {
      setState(() {
        loading = true;
      });
      var url = Uri.parse('https://cualquiera.upla.edu.pe/cuotasPen');
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
        for (var u in jsonData) {
          setState(() {
            listPagos.add(
              Pagos(
                u["descripcion"],
                u["fecVenc"],
                u["tm"],
                u["importe"],
                u["mora"],
                u["subtotal"],
                u["obs"],
              ),
            );
            loading = false;
          });
          // print(u["descripcion"]);
        }
      } else {
        print(response.body);
      }
    } on TimeoutException catch (_) {
      print("Tiempo de espera agotado, revise su conexión a internet.");
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
