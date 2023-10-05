import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final appFont = GoogleFonts.itimTextTheme();

  static final ThemeData lightTheme = ThemeData().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 233, 213, 255),
      brightness: Brightness.light,
    ),
    textTheme: appFont.apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme().copyWith(
      elevation: 0,
      scrolledUnderElevation: 0,
      color: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      elevation: 0,
      selectedItemColor: Colors.teal,
    ),
    iconTheme: const IconThemeData(
      color: Colors.teal,
    ),
    snackBarTheme: const SnackBarThemeData().copyWith(
      backgroundColor: Colors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(
      color: Colors.teal,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 91, 33, 182),
      brightness: Brightness.dark,
    ),
    textTheme: appFont.apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme().copyWith(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.black,
    drawerTheme: const DrawerThemeData().copyWith(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      elevation: 0,
      selectedItemColor: Colors.cyan,
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 34, 211, 238),
    ),
    dialogTheme: const DialogTheme().copyWith(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
    ),
    snackBarTheme: const SnackBarThemeData().copyWith(
      backgroundColor: Colors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(
      color: const Color.fromARGB(255, 34, 211, 238),
    ),
  );
}

class DarkModeController extends GetxController {
  RxBool darkMode = true.obs;

  @override
  void onInit() {
    darkMode.value =
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? true
            : false;
    super.onInit();
  }

  void toggleDarkMode() {
    darkMode.value = !darkMode.value;
  }
}
