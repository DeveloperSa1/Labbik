import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/2chat/ui/chat_screen.dart';
import 'package:labbaik/app/guardian/ui/1home/components/photos.dart';
import 'package:labbaik/app/guardian/ui/1home/components/reports.dart';
import 'package:labbaik/app/guardian/ui/1home/components/videos.dart';
import 'package:labbaik/app/guardian/ui/list_chat.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/sized.dart';
import 'package:labbaik/shared/widget/headers/dashboardNAV.dart';
import 'package:labbaik/shared/widget/headers/profileWidget.dart';
import 'package:labbaik/shared/widget/buttons/tabBUTTON.dart';

class GuardianHome extends StatelessWidget {
  GuardianHome({Key? key}) : super(key: key);
  ValueNotifier<bool> _totalTaskTrigger = ValueNotifier(true);
  ValueNotifier<bool> _totalDueTrigger = ValueNotifier(false);
  ValueNotifier<bool> _totalCompletedTrigger = ValueNotifier(true);
  ValueNotifier<bool> _workingOnTrigger = ValueNotifier(false);
  ValueNotifier<int> _buttonTrigger = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final guardian = Provider.of<AuthServices>(context, listen: false).guardian;
    final student = Provider.of<AuthServices>(context, listen: false).student;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashboardNav(
                      icon: FontAwesomeIcons.comment,
                      image: student!.profileImg!,
                      notificationCount: "0", // Chat Provider

                      page: MyListChat(
                       
                      ),
                      title: "لوحه التحكم",
                      onImageTapped: () {
                        // SIGN IN
                        // Get.to(() => EditProfileScreen(admin:admin));
                      },
                    ),
                    sizedH20,
                    Text(
                        "مرحباَ ${guardian?.name} 👋 \n ولي امر ${student.name} 💗",
                        style: GoogleFonts.lato(
                            color: color1,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    sizedH20,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //tab indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PrimaryTabButton(
                                  buttonText: "التقارير اليومية",
                                  itemIndex: 0,
                                  notifier: _buttonTrigger),
                              PrimaryTabButton(
                                  buttonText: "الفيديوات",
                                  itemIndex: 1,
                                  notifier: _buttonTrigger),
                              PrimaryTabButton(
                                  buttonText: "الصور",
                                  itemIndex: 2,
                                  notifier: _buttonTrigger)
                            ],
                          ),
                          // #TODO FOR Guardian TO  Choose Date
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
                          return _buttonTrigger.value == 0
                              ? StudentReports()
                              : _buttonTrigger.value == 1
                                  ? StudentVideos()
                                  : StudentPhotos();
                        })
                  ]),
            ),
          )),
    );
  }
}
