import 'package:common/cache/preference.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:labbaik/app/1auth/model/admin.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/1auth/ui/welcome.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/store/CustomChart/resources/themes/theme_view_model.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Preference _preference = Preference();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(providers: [
        // ChangeNotifierProvider(create: (_) => AdminGuardianServicess()),
        // ChangeNotifierProvider(create: (_) => AdminStaffServices()),
        // ChangeNotifierProvider(create: (_) => CreateMonthPlan()),
        // ChangeNotifierProvider(create: (_) => StaffServices()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel(_preference)),
        ChangeNotifierProvider(create: (_) => AuthServices()),
        // ChangeNotifierProvider(create: (_) => ChildServices()),
      ], child: MyApp()), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Labbaik',
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      );
    });
  }
}
