import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_demo/components/activity_indicator.dart';
import 'package:flutter_demo/pages/background.dart';
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
import '../util/exercise_tile.dart';

class PageTwo extends StatefulWidget {
  final Store<AppState> store;
  const PageTwo({Key? key, required this.store}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool loading = false;
  double sumaTotal = 0;
  List<Pagos> listPagos = [];

  @override
  void initState() {
    super.initState();
    loadCuotasPensiones();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.store.state.student.token);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
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
                      ],
                    ),
                  ),

                  //SUMA TOTAL
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
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
                            "TOTAL DE DEUDA",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Expanded(
                              child: Text(
                                "Suma Total:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "S/ ${sumaTotal.toStringAsFixed(2)}",
                                // "S/ ${sumaTotal}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //LISTA DE CUOTAS
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
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
                            "CUOTAS DE PENSIÓN ACADÉMICA",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ),
                        loading
                            ? const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(child: ActivityIndicator()),
                              )
                            : Column(
                                children: listPagos.map(
                                  (pago) {
                                    return ExerciseTile(
                                      index:
                                          pago.key != listPagos.length ? 10 : 0,
                                      icon: Icons.info,
                                      exerciseName: pago.descripcion,
                                      fechaVencimiento: pago.fecVenc,
                                      simbolo: pago.tm,
                                      importe: pago.importe,
                                      mora: pago.mora,
                                      subtotal: pago.subtotal,
                                      color: Colors.orange,
                                    );
                                  },
                                ).toList(),
                              ),
                      ],
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
        int count = 0;
        sumaTotal = 0;
        for (var u in jsonData) {
          count++;
          sumaTotal += u["subtotal"];
          setState(() {
            listPagos.add(
              Pagos(
                count,
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
