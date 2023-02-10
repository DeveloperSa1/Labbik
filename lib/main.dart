import 'package:common/cache/preference.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:labbaik/app/1auth/provider/auth.dart';
import 'package:labbaik/app/1auth/ui/welcome.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/store/CustomChart/resources/themes/theme_view_model.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

//global object for accessing device screen size
late Size mq;

_initializeFirebase() async {
  await Firebase.initializeApp();

  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  print('\nNotification Channel Result: $result');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
  });
  final Preference _preference = Preference();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(providers: [

        // ChangeNotifierProvider(create: (_) => AdminGuardianServicess()),
        // ChangeNotifierProvider(create: (_) => AdminStaffServices()),
        // ChangeNotifierProvider(create: (_) => CreateMonthPlan()),
        ChangeNotifierProvider(create: (_) => AuthServices()),

        // ChangeNotifierProvider(create: (_) => StaffServices()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel(_preference)),
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
