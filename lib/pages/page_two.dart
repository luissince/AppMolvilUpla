import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/activity_indicator.dart';
import 'package:flutter_demo/model/Pagos.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/exercise_tile.dart';

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
    return RefreshIndicator(
      onRefresh: () async {
        loadCuotasPensiones();
      },
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(0, 125, 188, 1)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text widget
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StoreConnector<AppState, Student>(
                                  builder: (context, studen) {
                                    return Text(
                                      "Hi, ${studen.persNombre}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                  converter: (store) => store.state.student),
                              const SizedBox(
                                height: 8,
                              ),
                              StoreConnector<AppState, Student>(
                                converter: (store) => store.state.student,
                                builder: (context, student) {
                                  return Text(
                                    student.docNumId,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          //Icon widget
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              // borderRadius: BorderRadius.circular(12),
                            ),
                            // padding: const EdgeInsets.all(12),
                            child: ElevatedButton(
                              onPressed: () {
                                closeSession();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 0, 109, 163),
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //Search widget

                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 109, 163),
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (text) {
                            // print("text: $text");
                          },
                          decoration: const InputDecoration(
                              // labelStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              semanticCounterText: "12323",
                              hintText: 'Enter a search term',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, .5))),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(0, 125, 188, 1)),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 25),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            //Consultant
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    "CUOTAS DE PENSIÓN ACADÉMICA",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Icon(Icons.more_horiz),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            loading
                                ? const ActivityIndicator()
                                : Column(
                                    children: listPagos
                                        .map(
                                          (pago) => ExerciseTile(
                                            icon: Icons.info,
                                            exerciseName: pago.descripcion,
                                            fechaVencimiento: pago.fecVenc,
                                            simbolo: pago.tm,
                                            importe: pago.importe,
                                            mora: pago.mora,
                                            subtotal: pago.subtotal,
                                            color: Colors.orange,
                                          ),
                                        )
                                        .toList(),
                                  ),

                            //lista de consultas

                            // listPagos.map((e) => Text("data")).toList(),
                            // const ExerciseTile(
                            //   icon: Icons.info,
                            //   exerciseName: 'CUOTA 01 Periodo 2022-1',
                            //   fechaVencimiento: "qweqwe",
                            //   simbolo: 'S/',
                            //   importe: 0,
                            //   mora: 0,
                            //   total: 0,
                            //   color: Colors.orange,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
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
