import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class ExerciseTile extends StatelessWidget {
  final int index;
  final IconData icon;
  final String exerciseName;
  final String fechaVencimiento;
  final String simbolo;
  final double importe;
  final double mora;
  final double subtotal;
  final Color color;

  const ExerciseTile(
      {Key? key,
      required this.index,
      required this.icon,
      required this.exerciseName,
      required this.fechaVencimiento,
      required this.simbolo,
      required this.importe,
      required this.mora,
      required this.subtotal,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(key);
    return Container(
      margin: EdgeInsets.only(bottom: index.toDouble()),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(
            Icons.attach_money,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseName,
                  style: const TextStyle(color: kPrimaryColor, fontSize: 13),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  fechaVencimiento,
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$simbolo $importe",
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "$simbolo $mora",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "$simbolo $subtotal",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w900),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
