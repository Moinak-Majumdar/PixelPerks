import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/theme_controller.dart';

class CenterLoader extends StatelessWidget {
  const CenterLoader({super.key, required this.msg});
  final String msg;

  @override
  Widget build(context) {
    DarkModeController modeController = Get.put(DarkModeController());

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 36),
          Obx(
            () => DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'PixelifySans',
                color:
                    modeController.darkMode.value ? Colors.white : Colors.black,
                fontSize: 24,
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(msg),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
