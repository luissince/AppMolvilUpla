import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/routers.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  final Store<AppState> store;
  const HomePage({Key? key, required this.store}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(0, 125, 188, 1),
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 240, 240, 1),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(0, 125, 188, 1),
        unselectedItemColor: const Color.fromARGB(255, 166, 169, 173),
        iconSize: 25.0,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: 'Financiero'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      body: SafeArea(
        child: Routers(index: index, store: widget.store),
      ),
    );
  }
}
