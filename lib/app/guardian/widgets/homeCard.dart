import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/sized.dart';
import 'package:labbaik/shared/constant/texts.dart';
import 'package:sizer/sizer.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: EdgeInsets.only(bottom: 24),
      height: 30.h,
      width: 90.h,
      gradient: gradient1,
      borderGradient: gradient3,
      borderRadius: BorderRadius.circular(10),
      isFrostedGlass: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 8, color: LightColors.kRed),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Icon Sequare
                CircleAvatar(
                  radius: 15,
                  child: Icon(
                    FontAwesomeIcons.handPaper,
                    size: 20,
                  ),
                  backgroundColor: LightColors.kRed,
                ),
                // Title
                sizedW10,
                Text('تقرير',
                    style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        color: LightColors.kRed,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          // AnotherTitle
          sizedH10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'تقرير  يومي',
              style: GoogleFonts.cairo(
                  fontSize: 14.sp, color: black, fontWeight: FontWeight.w600),
            ),
          ),
          // Sized
          // CheckIN - CheckOUT
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    sizedW10,
                    CircleAvatar(
                      radius: 9,
                      child: Icon(
                        FontAwesomeIcons.doorOpen,
                        size: 14,
                      ),
                      backgroundColor: LightColors.kRed,
                    ),
                    // Title
                    sizedW5,
                    Text('الحضور في الساعه 4:20',
                        style: GoogleFonts.cairo(
                          fontSize: 10.sp,
                          color: black,
                        )),
                    sizedW5,
                    CircleAvatar(
                      radius: 9,
                      child: Icon(
                        FontAwesomeIcons.signOut,
                        size: 14,
                      ),
                      backgroundColor: LightColors.kRed,
                    ),
                    // Title
                    sizedW5,
                    Text(' الخروج في الساعه 8:32',
                        style: GoogleFonts.cairo(
                          fontSize: 10.sp,
                          color: black,
                        )),
                  ],
                ),
              ),
            ],
          ),
          // Sized
          // ViewDetails
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'عرض التفاصيل',
                  style: smallBlueText,
                )),
          ),
          // Sized
          // Date
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sizedW10,
              sizedW10,
              Icon(FontAwesomeIcons.calendar),
              sizedW10,
              Text(
                  '${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}'),
            ],
          ),
          // END
        ],
      ),
    );
  }
}
