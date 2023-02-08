
import 'package:flutter/material.dart';

class PasswordFieldContainer extends StatelessWidget {
  final Widget child;
  const PasswordFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}