import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:imedy_patient/main/factory/usecases/save_device_info/local_save_device_info_factory.dart';
import 'package:imedy_patient/main/firebase/push_notification_service.dart';
import 'package:imedy_patient/main/routes/app_pages.dart';

import '../ui/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp();
  PushNotificationService(saveDeviceInfo: makeLocalSaveDeviceInfo());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
    );
  }
}
