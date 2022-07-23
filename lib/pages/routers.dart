import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/pages/page_four.dart';
import 'package:flutter_demo/pages/page_one.dart';
import 'package:flutter_demo/pages/page_two.dart';
import 'package:flutter_demo/pages/page_tree.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:redux/redux.dart';

class Routers extends StatelessWidget {
  final int index;
  final Store<AppState> store;
  const Routers({Key? key, required this.index, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      PageOne(store: store),
      PageTwo(store: store),
      PageTree(store: store),
      PageFour(store: store)
    ];

    return myList[index];
  }
}
