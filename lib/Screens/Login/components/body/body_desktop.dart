import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_demo/Screens/Login/components/background.dart';
import 'package:flutter_demo/Screens/Signup/signup_screen.dart';
import 'package:flutter_demo/components/alert.dart';
import 'package:flutter_demo/components/already_have_an_account_acheck.dart';
import 'package:flutter_demo/components/rounded_button.dart';
import 'package:flutter_demo/components/rounded_input_field.dart';
import 'package:flutter_demo/components/rounded_password_field.dart';
import 'package:flutter_demo/responsive/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyDesktop extends StatefulWidget {
  final Store<AppState> store;
  const BodyDesktop({Key? key, required this.store}) : super(key: key);

  @override
  State<BodyDesktop> createState() => _BodyDesktopState();
}

class _BodyDesktopState extends State<BodyDesktop> {
  var codigo = TextEditingController();
  var clave = TextEditingController();
  bool loading = false;
  bool viewPassword = true;

  late FocusNode codigoFocus;
  late FocusNode claveFocus;

  @override
  void initState() {
    super.initState();
    codigoFocus = FocusNode();
    claveFocus = FocusNode();

    codigoFocus.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    codigoFocus.dispose();
    claveFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: Responsive.isDesktop(context) ? 2 : 1,
                  child: SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.45,
                  ),
                ),
                SizedBox(
                  width: size.height * 0.1,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "INICIAR SESIÓN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      loading
                          ? const CircularProgressIndicator()
                          : const SizedBox(height: 0),
                      SizedBox(height: size.height * 0.03),
                      RoundedInputField(
                          text: codigo,
                          hintText: "Tú código",
                          onSubmitted: (value) async {
                            if (value != "" && clave.text == "") {
                              claveFocus.requestFocus();
                              return;
                            }

                            if (codigo.text != "" && clave.text != "") {
                              await login();
                            }
                          },
                          myFocusNode: codigoFocus),
                      RoundedPasswordField(
                        text: clave,
                        obscureText: viewPassword,
                        onSubmitted: (value) async {
                          if (codigo.text == "") {
                            codigoFocus.requestFocus();
                            return;
                          }

                          if (codigo.text != "" && clave.text != "") {
                            await login();
                          }
                        },
                        myFocusNode: claveFocus,
                        press: () {
                          setState(() {
                            viewPassword = !viewPassword;
                          });
                        },
                      ),
                      RoundedButton(
                        text: "INICIAR SESIÓN",
                        press: () async {
                          await login();
                        },
                        height: size.height * 0.15,
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpScreen();
                              },
                            ),
                          );
                        },
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

  Future<void> login() async {
    if (loading) {
      return;
    }

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (codigo.text == "") {
      var alert = Alert(context: context);
      alert.showAlert("Ingrese su código.");
      codigoFocus.requestFocus();
      return;
    }

    if (clave.text == "") {
      var alert = Alert(context: context);
      alert.showAlert("Ingrese su contraseña.");
      claveFocus.requestFocus();
      return;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          loading = true;
        });
        try {
          var url = Uri.parse('https://cualquiera.upla.edu.pe/Login');
          var response = await http
              .post(url,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: convert.jsonEncode(<String, String>{
                    "codigo": codigo.text,
                    "contraseña": clave.text
                  }))
              .timeout(const Duration(seconds: 10));

          if (response.statusCode == 200) {
            var jsonResponse = convert.jsonDecode(response.body);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("token", jsonResponse["token"]);
            prefs.setString("docNumId", jsonResponse["datos"]["docNumId"]);
            prefs.setString(
                "persPaterno", jsonResponse["datos"]["persPaterno"]);
            prefs.setString(
                "persMaterno", jsonResponse["datos"]["persMaterno"]);
            prefs.setString("persNombre", jsonResponse["datos"]["persNombre"]);

            widget.store.dispatch(
              SignIn(
                true,
                false,
                Student(
                    jsonResponse["token"],
                    jsonResponse["datos"]["docNumId"],
                    jsonResponse["datos"]["persPaterno"],
                    jsonResponse["datos"]["persMaterno"],
                    jsonResponse["datos"]["persNombre"]),
              ),
            );

            navigationHome();
          } else {
            var alert = Alert(context: context);
            alert.showAlert(response.body);

            setState(() {
              loading = false;
            });
          }
        } on TimeoutException catch (_) {
          var alert = Alert(context: context);
          alert.showAlert(
              "Tiempo de espera agotado, revise su conexión a internet.");

          setState(() {
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
        var alert = Alert(context: context);
        alert.showAlert("Revise su conexión a internet.");
      }
    } on SocketException catch (_) {
      setState(() {
        loading = false;
      });
      var alert = Alert(context: context);
      alert.showAlert("Revise su conexión a internet.");
    }
  }

  void navigationHome() {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
