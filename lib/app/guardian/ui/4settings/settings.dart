import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';

import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/sized.dart';
import 'package:labbaik/shared/store/values/appColors.dart';
import 'package:labbaik/shared/widget/Forms/labelForm.dart';
import 'package:labbaik/shared/widget/headers/appHeader.dart';
import 'package:labbaik/shared/widget/headers/profileWidget.dart';
import 'package:labbaik/shared/widget/raidialBackGround.dart';

import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;

class GuardianSettings extends StatelessWidget {
  GuardianSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final guardian = Provider.of<AuthServices>(context, listen: false).guardian;
    final student = Provider.of<AuthServices>(context, listen: false).student;

    final String tabSpace = "\t\t\t";
    final _nameController = new TextEditingController();
    final _passController = new TextEditingController();
    final _emailController = new TextEditingController();
    final _roleController = new TextEditingController();
    final _aboutController = new TextEditingController();
    return Scaffold(
        body: Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(children: [
        RadialBackground(
          color: white,
          position: "topLeft",
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
              AppHeader(
                title: "$tabSpace إعدادات",
                widget: Container(),
                // PrimaryProgressButton(
                //   width: 80,
                //   height: 40,
                //   label: "حفظ",
                //   textStyle: GoogleFonts.lato(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // ),
              ),
              SizedBox(height: 50),
              Stack(
                children: [
                  ProfileUI(
                      isNetwork: true,
                      color: HexColor.fromHex("94F0F1"),
                      dummyType: ProfileType.Image,
                      scale: 3.0,
                      image: student!.profileImg),
                  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: AppColors.primaryAccentColor.withOpacity(0.75),
                          shape: BoxShape.circle),
                      child: InkWell(
                        onTap: () async {
                          //   var _picker = ImagePicker();

                          //   XFile? image = await _picker.pickImage(
                          //       source: ImageSource.gallery);

                          //   var imageFile = File(image!.path);
                          //   String fileName = path.dirname(imageFile.path);
                          //   FirebaseStorage storage = FirebaseStorage.instance;
                          //   Reference ref =
                          //       storage.ref().child("Image-" + staff.id!);

                          //   UploadTask uploadTask = ref.putFile(imageFile);
                          //   await uploadTask.whenComplete(() async {
                          //     var url = await ref.getDownloadURL();
                          //     var image_url = url.toString();
                          //   }).catchError((onError) {
                          //     print(onError);
                          //   });

                          //   await FirebaseFirestore.instance
                          //       .collection('staff')
                          //       .doc(staff.id)
                          //       .update({

                          //       });
                        },
                        child: Icon(FeatherIcons.camera,
                            color: Colors.white, size: 20),
                      ))
                ],
              ),
              sizedH20,
              sizedH20,
              LabelledFormInput(
                  placeholder: student.name!,
                  keyboardType: "text",
                  controller: _nameController,
                  obscureText: false,
                  label: "اسم الطالب"),
              LabelledFormInput(
                  placeholder: guardian!.name!,
                  keyboardType: "text",
                  controller: _nameController,
                  obscureText: false,
                  label: "اسم ولي امر"),
              sizedH20,
              LabelledFormInput(
                  placeholder: guardian.phone!,
                  keyboardType: "phone",
                  controller: _emailController,
                  obscureText: true,
                  label: "رقم الجوال"),
              sizedH20,
              LabelledFormInput(
                  placeholder: student.diagnose!,
                  keyboardType: "text",
                  controller: _passController,
                  obscureText: true,
                  label: "تشخيص الطالب"),
              sizedH20,
              InkWell(
                onTap: () async {
                  await Provider.of<AuthServices>(context, listen: false)
                      .logout();
                },
                child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex("FF968E"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("تسجيل خروج",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                    )),
              )
            ]))))
      ]),
    ));
  }
}
