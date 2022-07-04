import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoActivityIndicator(
        radius: 15,
        color: kPrimaryColor,
      );
    } else {
      return const CircularProgressIndicator(
        color: kPrimaryColor,
      );
    }
  }
}
