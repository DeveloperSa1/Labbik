import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labbaik/app/2chat/ui/list_users.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/admin/ui/1dashboard/components/allStaff.dart';
import 'package:labbaik/app/admin/ui/1dashboard/components/allStudent.dart';
import 'package:labbaik/app/admin/ui/1dashboard/components/overview.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/sized.dart';
import 'package:labbaik/shared/widget/buttons/tabBUTTON.dart';
import 'package:labbaik/shared/widget/headers/dashboardNAV.dart';
import 'package:sizer/sizer.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({Key? key}) : super(key: key);
  ValueNotifier<bool> _totalTaskTrigger = ValueNotifier(true);
  ValueNotifier<bool> _totalDueTrigger = ValueNotifier(false);
  ValueNotifier<bool> _totalCompletedTrigger = ValueNotifier(true);
  ValueNotifier<bool> _workingOnTrigger = ValueNotifier(false);
  ValueNotifier<int> _buttonTrigger = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
            final admin = Provider.of<AuthServices>(context, listen: false).admin;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DashboardNav(
                  icon: FontAwesomeIcons.comment,
                  image: admin!.image!,
                  notificationCount: "2", // Chat Provider 
    
                  page: AllChatUsers(),
                  title: "لوحه التحكم",
                  onImageTapped: () {
                    // Get.to(() => EditProfileScreen(admin:admin));
                  },
                ),
              sizedH20,
                Text("مرحباَ ${admin.name!} 👋",
                    style: GoogleFonts.lato(color: color1, fontSize: 30, fontWeight: FontWeight.bold)),
                sizedH20,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //tab indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    
                      PrimaryTabButton(buttonText: "الطلاب", itemIndex: 0, notifier: _buttonTrigger),
                      PrimaryTabButton(buttonText: "الموظفات", itemIndex: 1, notifier: _buttonTrigger)
                    ],
                  ),
                  // #TODO FOR ADMIN TO SEARCH BETWEEN USERS
                  // Container(
                  //     alignment: Alignment.centerRight,
                  //     child: AppSettingsIcon(
                  //       callback: () {
                  //         showAppBottomSheet(
                  //         DashboardSettingsBottomSheet(
                  //             totalTaskNotifier: _totalTaskTrigger,
                  //             totalDueNotifier: _totalDueTrigger,
                  //             workingOnNotifier: _workingOnTrigger,
                  //             totalCompletedNotifier: _totalCompletedTrigger,
                  //           ),
                  //         );
                  //       },
                  //     ))
                ]),
                sizedH20,
                ValueListenableBuilder(
                    valueListenable: _buttonTrigger,
                    builder: (BuildContext context, _, __) {
                      return _buttonTrigger.value == 0 ? AllStudents() 
                      : AllStaffs();
                      //  _buttonTrigger.value == 2 ?  :
                    })
              ]),
            ),
          )),
    );
  }
}
