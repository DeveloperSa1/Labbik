import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:labbaik/app/guardian/ui/1home/home.dart';
import 'package:labbaik/app/guardian/ui/2monthPlan/month_plan.dart';
import 'package:labbaik/app/guardian/ui/3notification/notification.dart';
import 'package:labbaik/app/guardian/ui/4settings/settings.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/store/bottom_sheet.dart';
import 'package:labbaik/shared/widget/bottomNAVigation.dart';
import 'package:labbaik/shared/widget/buttons/dashboardADDBUTTON.dart';
import 'package:labbaik/shared/widget/raidialBackGround.dart';
import 'package:sizer/sizer.dart';

class GuardianTimeline extends StatefulWidget {
  GuardianTimeline({Key? key}) : super(key: key);

  @override
  _GuardianTimelineState createState() => _GuardianTimelineState();
}

class _GuardianTimelineState extends State<GuardianTimeline> {
  ValueNotifier<int> bottomNavigatorTrigger = ValueNotifier(0);

  StatelessWidget currentScreen = GuardianHome();

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
// Screens
    final List<Widget> AdminDashboardScreens = [
      GuardianHome(),
      StudentPlan(),
      GuardianNotification(),
      GuardianSettings(),
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
                      icon: Icons.home_filled),
                  Spacer(),
                  BottomNavigationItem(
                      itemIndex: 1,
                      notifier: bottomNavigatorTrigger,
                      icon: FontAwesomeIcons.chartSimple),
                  Spacer(),
                  TimelineAddButton(
                    iconTapped: (() {
                      showAppBottomSheet(Container(
                        height: 12.h,
                        // child: DashboardAddBottomSheet()
                        // CHAT MESSAGE OR REQUEST LEAVE
                      ));
                    }),
                  ),
                  Spacer(),
                  BottomNavigationItem(
                      itemIndex: 2,
                      notifier: bottomNavigatorTrigger,
                      icon: FeatherIcons.bell),
                  Spacer(),
                  BottomNavigationItem(
                      itemIndex: 3,
                      notifier: bottomNavigatorTrigger,
                      icon: FeatherIcons.settings)
                ])));
  }

// ignore: must_be_immutable

// Home = Components => Reports + Videos + images +

// MonthPlan = Compontents => OverView + TimeTable .

// + For Chat

// Notifi | AnnounceMent - leatest Attendance

// SETTING = COMPONENTS => MyPROFILE - MychildProfile

}
// WHEN STUDENT HAS BEEN ADDED HIS ACCOUNT WILL BE CONTAINING

// ####################################################### 

// INSIDE PAGE VIEW

// REPORTDETAIL REPETED ..

// WIDGETS?
// REPORTS CARD
// VIDEOS VIEW
// IMAGE CARD
// OPTIONAL - TIMETABLE & GOALS
// INHEANCE MONTHPLAN OVERVIEW
// NOTI CARD REPETED


// FORM
// SEND A REQUEST!
// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ // ###########################
// REPORTS WILL NOT BE EXITS ONLY VIDEOS - IMAGES } UNTIL ONE ADDED

// MONTH PLAN WILL HAVE TIMETABLE AND SKILLS .

// NOTI THERE WILL BE INITAIL MESSAGES 

// PROFILE WILL BE READY ..

// CHAT WILL BE ADDED .