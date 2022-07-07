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
                    "Total de Deuda",
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
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /**
                             * 
                             */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "S/",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 29,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    sumaTotal.toStringAsFixed(2),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 29,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const Text(
                                "MONTO TOTAL",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ],
                      ),

                      /**
                             * 
                             */
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          "CONSULTA DE ESTADO DE DEUDA",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
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
                    "CUOTAS DE PENSIÓN ACADÉMICA",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                loading
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: ActivityIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Column(
                        children: listPagos.map(
                          (pago) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: pago.key != listPagos.length ? 10 : 0,
                              ),
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.info,
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
                                        Text(
                                          pago.descripcion,
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(42, 49, 73, 1),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          pago.fecVenc,
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(42, 49, 73, 0.5),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "S/ ${pago.importe}",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "S/ ${pago.mora}",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(253, 3, 6, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "S/ ${pago.subtotal}",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(42, 49, 73, 1),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ).toList(),
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
