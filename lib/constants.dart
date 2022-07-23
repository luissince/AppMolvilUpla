import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(0, 125, 188, 1);
const kPrimaryLightColor = Color.fromARGB(255, 232, 248, 255);
const listMonth = [
  "ENE",
  "FEB",
  "MAR",
  "ABR",
  "MAY",
  "JUN",
  "JUL",
  "AGO",
  "SET",
  "OCT",
  "NOV",
  "DIC"
];

const listWeekdays = [
  "lunes",
  "martes",
  "miercoles",
  "jueves",
  "viernes",
  "sabado",
  "domingo"
];

String nullToString(var value) {
  return value ?? "";
}

int nullToInt(var value) {
  return value ?? 0;
}

double nullToDouble(var value) {
  return value ?? 0;
}

bool nullToBoolean(var value) {
  return value ?? false;
}
