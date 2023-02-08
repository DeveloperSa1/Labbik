import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
class BlueBackground extends StatelessWidget {
  final Widget child;
  const BlueBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserRole? role;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top1.png", width: size.width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top2.png", width: size.width),
          ),
          Positioned(
              top: 50,
              right: 30,
              child: role == UserRole.admin
                  ? FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 500),
                      child: SvgPicture.asset(
                        "assets/svg/admin.svg",
                        width: size.width * 0.40,
                      ))
                  : role == UserRole.staff
                      ? FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 500),
                          child: SvgPicture.asset(
                            "assets/svg/staff.svg",
                            width: size.width * 0.40,
                          ))
                      : FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 500),
                          child: SvgPicture.asset(
                            "assets/svg/family.svg",
                            width: size.width * 0.40,
                          ))),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom1.png", width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom2.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
