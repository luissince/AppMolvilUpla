import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class CardPerfil extends StatelessWidget {
  final String title;
  final String description;
  const CardPerfil({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: kPrimaryColor, fontSize: 13),
              ),
              Text(
                description,
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 13),
              )
            ],
          ),
        ],
      ),
    );
  }
}
