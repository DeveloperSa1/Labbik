import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:labbaik/app/2chat/api/apis.dart';
import 'package:labbaik/app/1auth/model/guardian.dart';
import 'package:labbaik/app/1auth/model/student.dart';

import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/1auth/widgets/background2.dart';
import 'package:labbaik/app/1auth/widgets/custom_field.dart';
import 'package:labbaik/app/guardian/ui/timeline.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/texts.dart';
import 'package:labbaik/shared/widget/headers/loaders/appLoading.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sizer/sizer.dart';

// لتغيرر الواجه من رقم جوال الى تحقق
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginGuardian extends StatefulWidget {
  final String title;
  final UserRole role;
  const LoginGuardian({super.key, required this.title, required this.role});

  @override
  _LoginGuardianState createState() => _LoginGuardianState();
}

class _LoginGuardianState extends State<LoginGuardian> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? phone;
  String? otp;
  String? verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  // هتا التحقق اذا كان اليوزر موجود رقمه بالداتا بيس

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
                          height: 40.h, //الارتفاع
                          width: 40.h, // العرض
                          blur: 24,
                          child: currentState ==
                                  MobileVerificationState.SHOW_MOBILE_FORM_STATE
                              ? signIn(context)
                              : otpNum(context),
                        )))));
  }

  // Sign in User
  bool loading = false;
  signIn(BuildContext context) {
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
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    size: 24,
                    Icons.admin_panel_settings,
                    color: Colors.indigo.withOpacity(0.8),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                  child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'رقم الجوال ',
                  hintStyle: blueText,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  print(phone);
                  setState(() {
                    phone = value;
                  });
                },
              )),
              const SizedBox(
                height: 20,
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

                  bool checkUser =
                      await Provider.of<AuthServices>(context, listen: false)
                          .checkUser(UserRole.guardian, phone!);

                  if (checkUser) {
                    print('user Exist');

                    await auth.verifyPhoneNumber(
                      phoneNumber: '$phone',
                      verificationCompleted: (phoneAuthCredential) async {
                        QuickAlert.show(
                          context: context,
                          // onConfirmBtnTap: () {
                          //   // Get.offAll(NavigatorApp());
                          // },
                          type: QuickAlertType.success,
                          text: 'تم إرسال الرمز',
                        );
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (verificationFailed) async {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: ' عذرا غير مسجل',
                        );
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(verificationFailed.message!)));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          loading = false;
                          currentState =
                              MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                    // Ends Sigin in
                    // Get.to(GuardianTimeline(
                    //   student: studentForApp,
                    //   monthly: monthly,
                    //   guardian: guardianForApp,
                    // ));
                  } else {
                    QuickAlert.show(
                      context: context,
                      // onConfirmBtnTap: () {
                      //   // Get.offAll(NavigatorApp());
                      // },
                      type: QuickAlertType.success,
                      text: 'رقم خاطئ لا يوجد حساب',
                    );
                  }
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
                  style: smallhiteText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  otpNum(BuildContext context) {
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
                    'تم ارسال رمز الى الرقم $phone',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    size: 20,
                    Icons.sms,
                    color: Colors.indigo.withOpacity(0.8),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                  child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'رمز التحقق',
                  hintStyle: blueText,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  print(otp);
                  setState(() {
                    otp = value;
                  });
                },
              )),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                constraints: BoxConstraints(
                    minHeight: 50,
                    minWidth: MediaQuery.of(context).size.width * 0.8),
                onPressed: () async {
                  phone = phone!.trim();
                  // FIREBASE AUTH TO GET UID
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId!, smsCode: otp!);
                  await auth.signInWithCredential(phoneAuthCredential);
                  String userUID = auth.currentUser!.uid;

                  // 1- Guardian
                  QuerySnapshot user = await FirebaseFirestore.instance
                      .collection('guardian')
                      .where("phone", isEqualTo: phone)
                      .get();
                  String userID = user.docs.first.id;
                  // DOCUMNT OF GUARDIAN
                  DocumentSnapshot guardianData = await FirebaseFirestore
                      .instance
                      .collection('guardian')
                      .doc(userID)
                      .get();

                  String uIDFromFirebase = guardianData.get('uid');

                  if (uIDFromFirebase != userUID) {
                    await auth.currentUser!.updatePhotoURL(
                        'https://i.ibb.co/zrh90Gm/children.png');
                    await FirebaseFirestore.instance
                        .collection('guardian')
                        .doc(userID)
                        .update({
                      'uid': userUID,
                    });
                    String name = await guardianData.get('name');

                    await APIs.createUser('guardian', phone: phone, name: name);
                    await Provider.of<AuthServices>(context, listen: false)
                        .getCurrentUser(UserRole.guardian);
                  } else {
                    await Provider.of<AuthServices>(context, listen: false)
                        .getCurrentUser(UserRole.guardian);
                  }
                  //

                  // Get Data From FireBase & ConvertToModel

                  // Convert To Guardian Model
                  GuardianModel guardian = GuardianModel.fromJson(guardianData);

                  var idTest = guardian.myChildren!.first;
                  print(idTest);

                  var idTest2 = guardian.id;
                  print('$idTest2 guardianID');
                  // 2 - Student
                  DocumentSnapshot fetchStudent = await FirebaseFirestore
                      .instance
                      .collection('children')
                      .doc(guardian.myChildren!.first)
                      .get();
                  String name = fetchStudent.get('name');
                  await auth.currentUser!.updateDisplayName(name);
                  var t = await FirebaseFirestore.instance
                      .collection('users')
                      .where('phone', isEqualTo: guardian.phone)
                      .get();
                  String chatUserId = t.docs.first.id;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(chatUserId)
                      .update({name: guardianData.get('name')});

                  // Student ConvertToModel
                  StudentModel studentData =
                      StudentModel.fromJson(fetchStudent);

                  Get.offAll(GuardianTimeline());
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await APIs.getSelfInfo();

                  prefs.setString('user_type', 'guardian');
                  prefs.setString('id', guardian.id!);
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
                  'إرسال',
                  style: smallWhiteText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
