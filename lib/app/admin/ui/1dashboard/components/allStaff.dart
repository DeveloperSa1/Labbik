import 'dart:math';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labbaik/app/1auth/model/staff.dart';

import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/widget/appLoading.dart';
import 'package:labbaik/shared/widget/shimmerLoader.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AllStaffs extends StatefulWidget {
  AllStaffs({super.key});

  @override
  State<AllStaffs> createState() => _AllStaffsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Animation<double>? _animation;
AnimationController? _animationController;

class _AllStaffsState extends State<AllStaffs>
    with SingleTickerProviderStateMixin {
  var _isLoading = false;

  @override
  void initState() {
    _simulateLoad();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  Future _simulateLoad() async {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  //     });
  @override
  Widget build(BuildContext context) {
    bool activeButton = false;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('staff').snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            AppLoading();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoader();
          }

          return Column(
            // padding: EdgeInsets.symmetric(vertical: 10),
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              // sizedH40,
              ...List.generate(
                  snapshot.data!.docs.length,
                  (index) => _userTile(
                      StaffsModel.fromJson(snapshot.data!.docs[index])))
            ],
          );
        }));
  }
}

Widget _userTile(StaffsModel model) {
  return InkWell(
    onTap: () {
      // Get.to(StaffDataView(
      //   staffData: model,
      // ));
    },
    child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 10,
                color: LightColors.kLightGreen),
            BoxShadow(
                offset: Offset(-3, 0),
                blurRadius: 15,
                color: LightColors.kLightGreen)
          ],
        ),
        child: Container(
          //  borderRadius: BorderRadius.all(Radius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: randomColor(),
                ),
                child: Image.network(
                  'https://img.icons8.com/color/512/user-group-woman-woman.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(model.name!,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12.sp,
                )),
            subtitle: Text(model.jobTitle!,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 10.sp,
                )),
            trailing: Icon(Icons.keyboard_arrow_left, size: 30, color: color1),
          ),
        )),
  );
}

Color randomColor() {
  var random = Random();
  final colorList = [
    color1,
    LightColors.kBlue,
    LightColors.kDarkBlue,
    LightColors.kDarkYellow,
    LightColors.kGreen,
    LightColors.kLavender,
    LightColors.kLightYellow,
    Colors.red,
    Colors.brown,
    LightColors.kPalePink,
    LightColors.kLightYellow2
  ];
  var color = colorList[random.nextInt(colorList.length)];
  return color;
}
