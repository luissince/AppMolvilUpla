import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoActivityIndicator(
        radius: 15,
        color: Color.fromRGBO(0, 125, 188, 1),
      );
    } else {
      return const CircularProgressIndicator(
        color: Color.fromRGBO(0, 125, 188, 1),
      );
    }
  }
}
