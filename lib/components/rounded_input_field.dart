import 'package:flutter/material.dart';
import 'package:flutter_demo/components/text_field_container.dart';
import 'package:flutter_demo/constants.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController text;
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode myFocusNode;
  const RoundedInputField(
      {Key? key,
      required this.text,
      required this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      required this.myFocusNode,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        focusNode: myFocusNode,
        controller: text,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
