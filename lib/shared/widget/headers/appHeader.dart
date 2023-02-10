import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labbaik/shared/constant/colors.dart';

import 'package:sizer/sizer.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final bool? messagingPage;
  final bool? primary;
  final Widget? widget;
  const AppHeader(
      {Key? key,
      this.primary,
      this.widget,
      required this.title,
      this.messagingPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        widget!,
        (messagingPage != null)
            ? Row(children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: green)),
                SizedBox(width: 50),
                Text(
                  this.title,
                  style: TextStyle(color: color1),
                )
              ])
            // ? Container()
            // :Container()
            : Text(this.title,
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                )),
      ]),
    );
  }
}
