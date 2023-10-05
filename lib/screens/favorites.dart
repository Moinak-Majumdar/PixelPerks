import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/favorite_controller.dart';
import 'package:pixelperks/controller/safe_content_controller.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/model/preview.dart';
import 'package:pixelperks/widget/preview_grid.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(context) {
    FavoriteController fc = Get.put(FavoriteController());
    DarkModeController modeController = Get.put(DarkModeController());
    SafeContentController scc = Get.put(SafeContentController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites ❤️',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            final isDark = modeController.darkMode.value;
            late List<PreviewImage> server;

            if (scc.safeContent.value) {
              final list = fc.favList
                  .where((element) => element.fromSafeSource == true)
                  .toList();
              server = list;
            } else {
              server = fc.favList.toList();
            }

            if (server.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      EvaIcons.searchOutline,
                      size: 40,
                      color: isDark ? Colors.amber : Colors.teal,
                    ),
                    const SizedBox(height: 20),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: 'PixelifySans',
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 24,
                      ),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'No images are added to favorite yet.',
                            textAlign: TextAlign.center,
                          ),
                          TypewriterAnimatedText(
                            'Double tap on any image to add as favorite.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return PreviewGrid(server: server);
          },
        ),
      ),
    );
  }
}
