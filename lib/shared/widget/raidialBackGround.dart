import 'package:flutter/material.dart';
import 'package:labbaik/shared/constant/colors.dart';


// ignore: must_be_immutable
class RadialBackground extends StatelessWidget {
  final String position;
  final Color color;
  var list = List.generate(
    3,
    (index) => kBlueLight.withOpacity(0.5)
  );
  RadialBackground({required this.color, required this.position});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [...list, this.color],
        center: (position == "bottomRight")
            ? Alignment(1.0, 1.0)
            : Alignment(-1.0, -1.0),
      ),
    )));
  }
}
