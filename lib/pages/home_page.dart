import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/pages/page_one.dart';
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
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Color.fromRGBO(0, 125, 188, 1),
    //     statusBarIconBrightness: Brightness.light));

    // return Scaffold(body: PageOne(store: widget.store));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 240, 240, 1),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        iconSize: 21.0,
        selectedFontSize: 11.0,
        unselectedFontSize: 11.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: 'FINANCIERO'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL'),
        ],
      ),
      // body: SafeArea(
      //   child: Routers(index: index, store: widget.store),
      // ),
      body: Routers(index: index, store: widget.store),
    );
  }
}
