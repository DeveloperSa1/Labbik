import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/1auth/widgets/background2.dart';
import 'package:labbaik/app/1auth/widgets/custom_field.dart';
import 'package:labbaik/app/1auth/widgets/password_field.dart';
import 'package:labbaik/app/admin/ui/timeline.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/texts.dart';
import 'package:labbaik/shared/widget/appLoading.dart';
// FlutterJNI.loadLibrary called more than once
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sizer/sizer.dart';

class LoginWithEmail extends StatefulWidget {
  static String routeName = "/email_login";
  const LoginWithEmail({super.key, required this.title, required this.role});
  final String title;
  final UserRole role;
  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: BlueBackground(
                child: loading
                    ? AppLoading()
                    : FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(milliseconds: 500),
                        child: GlassContainer(
                            gradient: gradient1,
                            borderGradient: gradient1,
                            isFrostedGlass: true,
                            height: 50.h, //الارتفاع
                            width: 40.h, // العرض
                            blur: 24,
                            child: signIn(context))))));
  }

  // Sign in User
  bool loading = false;
  signIn(BuildContext context) {
    String? email, password;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ' تسجيل دخول ${widget.title}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Icon(
                  //   size: 24,
                  //   Icons.admin_panel_settings,
                  //   color: Colors.indigo.withOpacity(0.8),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      email = '';
                    });
                  },
                  initialValue: 'admin@admin.com',
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: 'الإيميل',
                    hintStyle: blueText,
                    border: InputBorder.none,
                  ),

                  // OnPressed For Email Need Clean
                ),
              ),
              //SizedBox(height: 5,),

              PasswordFieldContainer(
                child: TextFormField(
                  obscureText: _isHidden,
                  onChanged: (value) {
                    setState(() {
                      password = '123456';
                    });
                  },
                  initialValue: '123456',
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "كلمه المرور",
                    hintStyle: blueText,
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              RawMaterialButton(
                constraints: BoxConstraints(
                    minHeight: 50,
                    minWidth: MediaQuery.of(context).size.width * 0.8),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    await Provider.of<AuthServices>(context, listen: false)
                        .login('admin@admin.com', '123456', widget.role);
                    if (widget.role == UserRole.admin) {
                      print('success');
                      Get.to(Dashboard());
                      // Admin Nav

                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  }
                  setState(() {
                    loading = false;
                  });
                },
                elevation: 2.0,
                fillColor: Colors.indigo.withOpacity(0.5),
                padding: const EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(
                      color: Colors.indigo.withOpacity(0.2), width: 2),
                ),
                child: Text(
                  'تسجيل الدخول',
                  style: smallWhiteText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
