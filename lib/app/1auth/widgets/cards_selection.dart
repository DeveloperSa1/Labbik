// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/1auth/ui/login_admin.dart';
import 'package:labbaik/app/1auth/ui/login_guardian.dart';

import 'package:labbaik/imports.dart';

import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/texts.dart';
import 'package:sizer/sizer.dart';

class IconMenu {
  IconMenu(
      {required this.iconName,
      required this.titleIcon,
      required this.color,
      this.selected});

  final Color color;
  final IconData iconName;
  final String titleIcon;
  final bool? selected;
}

class SelectCard extends StatefulWidget {
  const SelectCard({Key? key, required this.listContent}) : super(key: key);
  final List<IconMenu> listContent;

  @override
  // ignore: library_private_types_in_public_api
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.listContent.length,
            itemBuilder: (BuildContext context, int position) {
              var listItem;

              widget.listContent.map(
                (e) => {e = listItem},
              );
              return InkWell(
                onTap: () async{
                  setState(() {
                    selectedIndex = position;
                  });

                  if (selectedIndex == 0) {
                    // Guardian
                    Get.to(LoginGuardian(
                        title: 'حساب ولي امر', role: UserRole.guardian));
                    ;
                  }
                   else if (selectedIndex == 1) {
                    // Get.to(LoginWithPhone(title: 'حساب الموظفات', role: UserRole.staff));
                    await Provider.of<AuthServices>(context,listen: false).logout();
                  }
                   else if (selectedIndex == 2) {
                  Get.to(LoginWithEmail(title: 'الإدارة', role: UserRole.admin)
                  );

                    // Admin
                  }

                  // Navigator.pushNamed(context, listItem.goTo);
                  print(selectedIndex.toString());
                },
                // onTap: listItem?.onSelect,
                child: Container(
                  width: 15.h,
                  child: Card(
                    color: (selectedIndex == position) ? color1 : Colors.white,
                    shape: (selectedIndex == position)
                        ? RoundedRectangleBorder(
                            side: BorderSide(color: color1))
                        : null,
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(widget.listContent[position].iconName,
                            color: (selectedIndex == position)
                                ? Colors.white
                                : widget.listContent[position].color),
                        Text(
                          widget.listContent[position].titleIcon,
                          style: (selectedIndex == position)
                              ? whiteText
                              : blueText,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        // FadeInUp(
        //   duration: Duration(milliseconds: 800),
        //   delay: const Duration(milliseconds: 200),
        //   child: SButton(
        //     onTap: () {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //           builder: ((context) => FadeOutRightBig(
        //               duration: const Duration(milliseconds: 2000),
        //               delay: const Duration(milliseconds: 6000),
        //               child: const SignUpAdmin())),
        //         ),
        //       );
        //     },
        //     size: MediaQuery.of(context).size,
        //     borderColor: Colors.white,
        //     color: color1,
        //     text: "سجل كـ ادمن",
        //     textStyle: whiteText,
        //   ),
        // ),
      ],
    );
  }
}


// selectedIndex == -1
//                 ? null
//                 : () {
//                     switch (selectedIndex) {
//                       case 0:
//                         role = UserRole.admin;
//                         break;
//                       case 1:
//                         role = UserRole.staff;
//                         break;
//                       case 2:
//                         role = UserRole.guardian;
//                         break;
//                       default:
//                     }
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: ((context) => FadeOutRightBig(
//                             duration: const Duration(milliseconds: 2000),
//                             delay: const Duration(milliseconds: 6000),
//                             child: Login(role: role))),
//                       ),
//                     );
//                   },
