// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:labbaik/app/1auth/widgets/background.dart';
import 'package:labbaik/app/1auth/widgets/cards_selection.dart';
import 'package:labbaik/main.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/sized.dart';
import 'package:labbaik/shared/constant/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String routeName = "/welcome";
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
        mq = MediaQuery.of(context).size;

    List<IconMenu> iconList = [
      IconMenu(
        iconName: Icons.person,
        titleIcon: "ولي امر",
        color: color1,
      ),
      IconMenu(
        iconName: Icons.people,
        titleIcon: "موظفه",
        color: Colors.amber,
      ),
      IconMenu(
        iconName: Icons.admin_panel_settings,
        titleIcon: "إداريه",
        color: Colors.purple,
      )
    ];
    
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const LogoImage(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sizedH10,
                      Text('اختر نوع الحساب لتسجيل الدخول',
                          style: smallBlueText),
                      sizedH10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectCard(
                          listContent: iconList,
                        ),
                      ),
                      SocialIcons(),
                    ]),
              ),
              sizedH20,
              // ### Social Icons
              // ### About_us Page..
            ])),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 2000),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/Labbaik.png",
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class LogoImage2 extends StatelessWidget {
  const LogoImage2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 2000),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/Labbaik.png",
            ),
          ),
          Text('Made with love in Jeddah '),
        ],
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // children: [
      //   Text('تواصلو معنا'),
      //   Icon(
      //     Icons.whatsapp,
      //     color: green,
      //   )
      // ],
    );
  }
}
