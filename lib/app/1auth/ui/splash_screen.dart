import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/1auth/ui/welcome.dart';
import 'package:labbaik/app/admin/ui/timeline.dart';
import 'package:labbaik/app/guardian/ui/timeline.dart';
import 'package:labbaik/app/staff/ui/timeline.dart';

import '../../../imports.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

UserRole? role1;

class _SplashScreenState extends State<SplashScreen> {
  Future<UserRole> getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('user_type');
    userType == null
        ? Get.to(WelcomeScreen())
        : print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
    print(userType);
    print('HERE');
    UserRole? role;
    switch (userType) {
      case 'admin':
        return role = UserRole.admin;
      case 'staff':
        return role = UserRole.staff;
      case 'guardian':
        return role = UserRole.guardian;

      default:
        '';
    }
    print(role.toString());

    return role!;
  }

  Future<UserRole> getUserTypeFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserRole? role = await getLocalData();
    setState(() {
      role1 = role;
    });
    getCurrentUser();

    return role;
  }

  Future getCurrentUser({UserRole? role}) async {
    if (role == null) {
      Get.offAll(WelcomeScreen());
    }

    if (role == UserRole.admin) {
      // Provider.of<AuthServices>(context, listen: false)
      //     .getCurrentUser(UserRole.admin);
      // Get.offAll(AdminTimeline());
    }
    if (role == UserRole.staff) {
      Provider.of<AuthServices>(context, listen: false)
          .getCurrentUser(UserRole.staff);
      Get.offAll(StaffTimeline());
    }
    if (role == UserRole.guardian) {
      await Provider.of<AuthServices>(context, listen: false)
          .getCurrentUser(UserRole.guardian);
      Get.offAll(GuardianTimeline());
    }

    // if (role != UserRole.admin &&
    //     role != UserRole.guardian &&
    //     role != UserRole.staff) {
    //   Get.offAll(WelcomeScreen());
    // }
  }

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));
    });
    getUserTypeFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/images/Labbaik.png')),
        Center(
          child: CircularProgressIndicator(),
        )
      ]),
    );
  }
}
