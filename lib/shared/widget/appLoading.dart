import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:labbaik/shared/constant/colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
  color: color1,
  size: 50.0,
);
  }
}