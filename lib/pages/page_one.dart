import 'dart:async';
import 'dart:convert';

import 'package:flutter_demo/model/Curso.dart';
import 'package:flutter_demo/model/Horario.dart';
import 'package:flutter_demo/components/activity_indicator.dart';
import 'package:flutter_demo/model/Record.dart';
import 'package:flutter_demo/pages/background.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
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
  bool loadingInfo = false;
  bool responseInfoOk = true;
  String plan = "";
  String facultad = "";
  String carrera = "";
  List<Record> listRecord = [];

  bool loadingHorario = false;
  bool responseHorarioOk = true;
  List<Horario> listHorarios = [];

  bool loadingCursos = false;
  bool responseCursosOk = true;
  List<Curso> listCurso = [];

  int year = 0;
  int month = 0;
  int day = 0;

  int weekday = 0;

  @override
  void initState() {
    super.initState();
    loadInformation();
    loadCursos();
    loadHorario();

    listRecord.add(Record("PP", 100));
    listRecord.add(Record("SP", 100));
    listRecord.add(Record("PF", 100));
    final DateTime now = DateTime.now();
    print(now);
    year = now.year;
    month = now.month;
    day = now.day;
    weekday = now.weekday;
  }

  @override
  Widget build(BuildContext context) {
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
                    "Dashboard",
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
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: loadingInfo
                      ? Column(
                          children: const [
                            ActivityIndicator(color: Colors.white),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Cargando Información...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                      * 
                      */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.store.state.student
                                                  .persNombre,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${widget.store.state.student.persPaterno} ${widget.store.state.student.persMaterno}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Código ${widget.store.state.student.docNumId}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            /**
                      * 
                      */
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Text(
                                "PLAN DE ESTUDIOS $plan",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "FACULTAD",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        facultad,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "CARR./ ESP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        carrera,
                                        style: const TextStyle(
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
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Fecha Actual",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  day.toString(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  listMonth[month - 1],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  year.toString(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
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
                    "Horario y Turnos",
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
                  child: loadingHorario
                      ? Column(
                          children: const [
                            ActivityIndicator(color: kPrimaryColor),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Cargando Información...",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      : listHorarios.isEmpty
                          ? Row(
                              children: const [
                                Icon(Icons.info),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "No tiene horarios para hoy.",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: listHorarios
                                  .map(
                                    (item) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.punch_clock,
                                          size: 32,
                                          color:
                                              Color.fromRGBO(252, 127, 167, 1),
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
                                                item.curso,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      42, 49, 73, 1),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                item.observacion,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      43, 96, 201, 1),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.hrInicio,
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          42, 49, 73, 0.5),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const Icon(
                                                      Icons.arrow_forward),
                                                  Text(
                                                    item.hrTermino,
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          42, 49, 73, 0.5),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                ),

                /**
                 * 
                 */
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Metodología del Estudio Universitario",
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
                  child: loadingCursos
                      ? Column(
                          children: const [
                            ActivityIndicator(color: kPrimaryColor),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Cargando Información...",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /**
                       * 
                       */
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Text(
                                            "Resultado Gráficos",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  43, 96, 201, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            /**
                       * 
                       */

                            // const SizedBox(
                            //   width: double.infinity,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(top: 10, bottom: 10),
                            //     child: Text(
                            //       "Procentaje %",
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            /**
                       * 
                       */
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: listRecord
                            //         .map(
                            //           (record) => Column(
                            //             children: [
                            //               Container(
                            //                 margin: const EdgeInsets.only(
                            //                     left: 10, right: 10),
                            //                 child: Stack(
                            //                   alignment:
                            //                       AlignmentDirectional.bottomCenter,
                            //                   children: [
                            //                     Container(
                            //                       margin: const EdgeInsets.only(
                            //                           bottom: 10),
                            //                       width: 20,
                            //                       height: 100,
                            //                       decoration: BoxDecoration(
                            //                         borderRadius:
                            //                             BorderRadius.circular(10),
                            //                         color: const Color.fromRGBO(
                            //                           255,
                            //                           255,
                            //                           255,
                            //                           1,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Container(
                            //                       margin: const EdgeInsets.only(
                            //                           bottom: 10),
                            //                       width: 20,
                            //                       height: 100,
                            //                       decoration: BoxDecoration(
                            //                         borderRadius:
                            //                             BorderRadius.circular(10),
                            //                         color: const Color.fromRGBO(
                            //                           255,
                            //                           163,
                            //                           103,
                            //                           1,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Container(
                            //                       margin: const EdgeInsets.only(
                            //                           bottom: 10),
                            //                       child: const Text(
                            //                         "16",
                            //                         style: TextStyle(
                            //                           fontSize: 15,
                            //                           fontWeight: FontWeight.w700,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //               /**
                            //                  *
                            //                  */
                            //               Padding(
                            //                 padding: const EdgeInsets.only(
                            //                     left: 10, right: 10),
                            //                 child: Text(
                            //                   record.mes,
                            //                   style: const TextStyle(
                            //                     fontSize: 13,
                            //                     fontWeight: FontWeight.w600,
                            //                     color: Color.fromRGBO(
                            //                       43,
                            //                       96,
                            //                       201,
                            //                       1,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         )
                            //         .toList(),
                            //   ),
                            // ),
                            /**
                       * 
                       */
                            // const SizedBox(
                            //   width: double.infinity,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(top: 10),
                            //     child: Text(
                            //       "Notas",
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            /**
                       * 
                       */
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.lens,
                                      color: Color.fromRGBO(255, 203, 203, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Muy Alto",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /**
                       * 
                       */
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.lens,
                                      color: Color.fromRGBO(255, 229, 203, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Alto",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /**
                       * 
                       */
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.lens,
                                      color: Color.fromRGBO(255, 251, 203, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Medio",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /**
                       * 
                       */
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.lens,
                                      color: Color.fromRGBO(222, 249, 220, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Bajo",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            /**
                       * 
                       */
                            /**
                           * 
                           */
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: const [
                                      Text(
                                        "Item",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(43, 96, 201, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: const [
                                      Text(
                                        "Asignatura",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(43, 96, 201, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: const [
                                      Text(
                                        "P1",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(43, 96, 201, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: const [
                                      Text(
                                        "PF",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(43, 96, 201, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: const [
                                      Text(
                                        "A/S",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(43, 96, 201, 1),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            listCurso.isEmpty
                                ? Row(
                                    children: const [
                                      Icon(Icons.info),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "No tiene cursos disponibles.",
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: listCurso
                                        .map(
                                          (item) => Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          item.codigo,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          item.asignatura,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          item.pF1,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          item.pf,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${item.asistencia}%",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              /**
                           * 
                           */
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
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

  Future<void> loadInformation() async {
    if (loadingInfo) {
      return;
    }

    try {
      setState(() {
        loadingInfo = true;
        responseInfoOk = false;
      });

      var url = Uri.parse('https://cualquiera.upla.edu.pe/estudiante/consNota');
      var response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${widget.store.state.student.token}'
            },
            body: jsonEncode(<String, String>{
              "codigo": widget.store.state.student.docNumId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> list = List.from(jsonData);
        if (list.isNotEmpty) {
          setState(() {
            plan = list[0]["mtr_Anio"] + "-" + list[0]["mtr_Periodo"];
            facultad = list[0]["nombreFacultad"];
            carrera = list[0]["nombreCarrera"];
            loadingInfo = false;
            responseInfoOk = true;
          });
        } else {
          setState(() {
            loadingInfo = false;
            responseInfoOk = true;
          });
        }
      } else {
        setState(() {
          responseInfoOk = false;
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        responseInfoOk = false;
      });
    }
  }

  Future<void> loadCursos() async {
    if (loadingCursos) {
      return;
    }

    try {
      setState(() {
        loadingCursos = true;
        responseCursosOk = true;
      });

      var url = Uri.parse('https://cualquiera.upla.edu.pe/estudiante/consNota');
      var response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${widget.store.state.student.token}'
            },
            body: jsonEncode(<String, String>{
              "codigo": widget.store.state.student.docNumId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> list = List.from(jsonData);

        if (list.isNotEmpty) {
          // print(list);
          for (var item in list) {
            listCurso.add(Curso(
              nullToString(item["nombreFacultad"]),
              nullToString(item["nombreCarrera"]),
              nullToString(item["planEstudios"]),
              nullToString(item["codigo"]),
              nullToString(item["asignatura"]),
              nullToString(item["plan"]),
              nullToString(item["ciclo"]),
              nullToString(item["seccion"]),
              nullToDouble(item["credito"]),
              nullToString(item["asistencia"]),
              nullToString(item["pF1"]),
              nullToString(item["pF2"]),
              nullToString(item["pf"]),
              nullToString(item["complementario"]),
              nullToString(item["pfp"]),
              nullToBoolean(item["cc"]),
              nullToString(item["cicloTotal"]),
              nullToString(item["seccionTotal"]),
              nullToInt(item["creditosTotal"]),
              nullToString(item["mtr_Anio"]),
              nullToString(item["mtr_Periodo"]),
              nullToString(item["tipoAsignatura"]),
              nullToString(item["tar_id"]),
              nullToString(item["puesto"]),
            ));
          }

          setState(() {
            loadingCursos = false;
            responseCursosOk = true;
          });
        } else {
          setState(() {
            loadingCursos = false;
            responseCursosOk = true;
          });
        }
      } else {
        setState(() {
          responseCursosOk = false;
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        responseCursosOk = false;
      });
    }
  }

  Future<void> loadHorario() async {
    if (loadingHorario) {
      return;
    }

    try {
      setState(() {
        loadingHorario = true;
        responseHorarioOk = true;
      });

      var url = Uri.parse('https://cualquiera.upla.edu.pe/estudiante/Horario');
      var response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${widget.store.state.student.token}'
            },
            body: jsonEncode(<String, String>{
              "codigo": widget.store.state.student.docNumId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> list = List.from(jsonData);
        if (list.isNotEmpty) {
          for (var item in list) {
            Map<String, dynamic> addjson = item;
            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(3)) {
              if (addjson["lunes"] != null) {
                var arr = addjson["lunes"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }

            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(4)) {
              if (addjson["martes"] != null) {
                var arr = addjson["martes"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }

            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(5)) {
              if (addjson["miercoles"] != null) {
                var arr = addjson["miercoles"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }

            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(6)) {
              if (addjson["jueves"] != null) {
                var arr = addjson["jueves"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }

            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(7)) {
              if (addjson["viernes"] != null) {
                var arr = addjson["viernes"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }

            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(8)) {
              if (addjson["sabado"] != null) {
                var arr = addjson["sabado"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }

            if (listWeekdays[weekday - 1] == addjson.keys.elementAt(9)) {
              if (addjson["domingo"] != null) {
                var arr = addjson["domingo"].split("_");
                listHorarios.add(
                    Horario(arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
              }
            }
          }

          setState(() {
            loadingHorario = false;
            responseHorarioOk = true;
          });
        } else {
          setState(() {
            loadingHorario = false;
            responseHorarioOk = true;
          });
        }
      } else {
        setState(() {
          responseHorarioOk = false;
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        responseHorarioOk = false;
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
