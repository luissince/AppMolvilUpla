import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {
  final Color color;
  const ActivityIndicator({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(radius: 15, color: color);
    } else {
      return CircularProgressIndicator(color: color);
    }
  }
}
