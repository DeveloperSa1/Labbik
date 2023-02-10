import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:labbaik/app/admin/ui/1dashboard/dashboard.dart';
import 'package:labbaik/app/admin/ui/3conversions/conversions.dart';
import 'package:labbaik/app/admin/ui/4settings/settings.dart';
import 'package:labbaik/app/staff/ui/2manageTasks/tasks.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/store/bottom_sheet.dart';
import 'package:labbaik/shared/widget/bottomNAVigation.dart';
import 'package:labbaik/shared/widget/buttons/dashboardADDBUTTON.dart';
import 'package:labbaik/shared/widget/raidialBackGround.dart';
import 'package:sizer/sizer.dart';

class AdminTimeline extends StatefulWidget {
  AdminTimeline({Key? key}) : super(key: key);

  @override
  _AdminTimelineState createState() => _AdminTimelineState();
}

class _AdminTimelineState extends State<AdminTimeline> {
  ValueNotifier<int> bottomNavigatorTrigger = ValueNotifier(0);

  StatelessWidget currentScreen = AdminDashboard();

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
// Screens
    final List<Widget> AdminDashboardScreens = [
      AdminDashboard(),
      Requests(),
      Conversions(),
      Settings(),
    ];
    return Scaffold(
        backgroundColor: white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(children: [
          RadialBackground(
            color: white,
            position: "topLeft",
          ),
          ValueListenableBuilder(
              valueListenable: bottomNavigatorTrigger,
              builder: (BuildContext context, _, __) {
                return PageStorage(
                    child: AdminDashboardScreens[bottomNavigatorTrigger.value],
                    bucket: bucket);
              })
        ]),
        bottomNavigationBar: Container(
            width: double.infinity,
            height: 90,
            padding: EdgeInsets.only(top: 10, right: 30, left: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: color1.withOpacity(0.8)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavigationItem(
                      itemIndex: 0,
                      notifier: bottomNavigatorTrigger,
                      icon: Icons.dashboard_customize
                      ),
                  Spacer(),
                  BottomNavigationItem(
                      itemIndex: 1,
                      notifier: bottomNavigatorTrigger,
                      icon: FontAwesomeIcons.tasks),
                  Spacer(),
                  TimelineAddButton(
                    iconTapped: (() {
                      showAppBottomSheet(Container(
                        height: 12.h,
                        // child: DashboardAddBottomSheet()
                      ));
                    }),
                  ),
                  Spacer(),
                  BottomNavigationItem(
                      itemIndex: 2,
                      notifier: bottomNavigatorTrigger,
                      icon: FontAwesomeIcons.comment),
                  Spacer(),
                  BottomNavigationItem(
                      itemIndex: 3,
                      notifier: bottomNavigatorTrigger,
                      icon: FeatherIcons.settings)
                ])));
  }
}

                            // #LAST
// ADMIN HOME = COMPONENTS => OVERVIEW - ALL STUDENT - ALL STAFF .
// ADMIN REQUESTS = COMPONENTS => REPORTS  - STAFF |REQUEST == TASKS - GUARDIAN-REQUEST |. BY MONTH AND STATUS
// ADMIN Notifications = COMPONENTS => ANY THINK HAPPEN IN THE APP .
// ADMIN SETTINGS .
// ADMIN CHAT LIST .

// ATTENDANCE = حاضر - لم يحضر - غائب - إجازة

// 

// FORMS
// ADD STUDENT
// ADD STAFF
// ADD TASK ..

// TASK IT COULD BY CHILD OR GENRAL TASK .




// INSIDE VIEW PAGES .
// ## THESE SHOULD LAST LAST THING EXCEPT CHAT >>

// REPORT DETAIL 
// USER INFO 
// CHAT SCREEN

// WIDGETS ?
// STATIC WITH CARD NUMPER LAST UPDATE 
// OPTIONAL STUDENT & STAFF CARD 
// REQUEST CARD  
// NOTIFICATION CARD


                           


