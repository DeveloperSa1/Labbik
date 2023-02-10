import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/store/values/appColors.dart';
import 'package:labbaik/shared/widget/headers/profileWidget.dart';

import 'package:sizer/sizer.dart';

class DashboardNav extends StatelessWidget {
  final String title;
  final String image;
  final IconData icon;
  final Widget? page;
  final VoidCallback? onImageTapped;
  final String notificationCount;

  DashboardNav(
      {Key? key,
      required this.title,
      required this.icon,
      required this.image,
      required this.notificationCount,
      this.page,
      this.onImageTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
         InkWell(
          onTap: onImageTapped,
          //
          child: ProfileUI(
              isNetwork: true,
              color:  color1,
              dummyType: ProfileType.Image,
              image: this.image,
              scale: 1.4),
        ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
     
        InkWell(
          onTap: () {
            if (page != null) Get.to(() => page!);
          },
          child: Stack(children: <Widget>[
            Icon(icon, color: color1, size: 5.h),
            Positioned(
              // draw a red marble
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: HexColor.fromHex("FF9B76")),
                alignment: Alignment.center,
                child: Text(notificationCount,
                    style: GoogleFonts.cairo(fontSize: 11, color: color1)),
              ),
            )
          ]),
        ),
        SizedBox(width: 40)
      ])
    ]);
  }
}
