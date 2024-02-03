import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pixelperks/Hive/hive_dark_mode.dart';
import 'package:pixelperks/Hive/hive_fav.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/screens/landing.dart';
// import 'package:pixelperks/utils/splash_screen.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(HiveFavAdapter());
  Hive.registerAdapter(HiveDarkModeAdapter());
  await dotenv.load(fileName: '.env');

  runApp(
    // const GetMaterialApp(
    const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    FlutterNativeSplash.remove();
    final DarkModeController modeController = Get.put(DarkModeController());

    return Obx(
      () => GetMaterialApp(
        title: 'Pixel Perks',
        debugShowCheckedModeBanner: false,
        theme: modeController.darkMode.value
            ? AppTheme.darkTheme
            : AppTheme.lightTheme,
        home: const Landing(),
      ),
    );
  }
}
