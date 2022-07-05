import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_demo/components/activity_indicator.dart';
import 'package:flutter_demo/model/Record.dart';
import 'package:flutter_demo/pages/background.dart';
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
  List<Record> listRecord = [];

  @override
  void initState() {
    super.initState();
    loadInformation();

    listRecord.add(Record("Ene", 100));
    listRecord.add(Record("Feb", 100));
    listRecord.add(Record("Maz", 100));
    listRecord.add(Record("Abr", 100));
    listRecord.add(Record("May", 100));
    listRecord.add(Record("Jun", 100));
    listRecord.add(Record("Jul", 100));
    listRecord.add(Record("Ago", 100));
    listRecord.add(Record("Set", 100));
    listRecord.add(Record("Oct", 100));
    listRecord.add(Record("Nov", 100));
    listRecord.add(Record("Dic", 100));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://academico.upla.edu.pe/FotosAlum/037000r01655a.jpg'),
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
                    "Dashboard",
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
                                children: const [
                                  Text(
                                    "Rp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 7,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "29.890.781",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 29,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const Text(
                                "CURRENT BALANCE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.dark_mode,
                                color: Colors.white,
                              ),
                              Text(
                                "BCA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          )
                        ],
                      ),

                      /**
                             * 
                             */
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          "ACTIVE CARD",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
                      ),

                      /**
                             * 
                             */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "CARD NAME",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Dara Adhelia",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "TYPE CARD",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Gold",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Rp",
                                      style: TextStyle(
                                        color: Color.fromRGBO(43, 96, 201, 1),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "7.752.890",
                                      style: TextStyle(
                                        color: Color.fromRGBO(43, 96, 201, 1),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "EXPENSES",
                                  style: TextStyle(
                                    color: Color.fromRGBO(196, 206, 226, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "month",
                                      style: TextStyle(
                                        color: Color.fromRGBO(196, 206, 226, 1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "year",
                                      style: TextStyle(
                                        color: Color.fromRGBO(43, 96, 201, 1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      /**
                             * 
                             */

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: listRecord
                                .map(
                                  (record) => Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            width: 10,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromRGBO(
                                                255,
                                                255,
                                                255,
                                                1,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            width: 10,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromRGBO(
                                                255,
                                                163,
                                                103,
                                                1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /**
                                         * 
                                         */
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          record.mes,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                              43,
                                              96,
                                              201,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                /**
                     * 
                     */
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Currency Exchanges",
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.percent,
                              color: Color.fromRGBO(73, 203, 227, 1),
                            ),
                            Text(
                              "%0.00",
                              style: TextStyle(
                                  color: Color.fromRGBO(43, 96, 201, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                /**
               * 
               */
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Account Mutation",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
