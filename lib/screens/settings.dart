import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/favorite_controller.dart';
import 'package:pixelperks/controller/safe_content_controller.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/utils/get_smack.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    final DarkModeController modeController = Get.put(DarkModeController());
    final SafeContentController scc = Get.put(SafeContentController());
    final FavoriteController fc = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => SwitchListTile(
                value: modeController.darkMode.value,
                onChanged: (val) async {
                  await modeController.toggleDarkMode();
                },
                title: Text(
                  'Dark Mode',
                  style: textTheme.titleLarge,
                ),
              ),
            ),
            Obx(
              () => SwitchListTile(
                value: scc.safeContent.value,
                onChanged: (value) => scc.toggleSafeContent(value),
                title: Text(
                  'Safe Content',
                  style: textTheme.titleLarge,
                ),
                subtitle: Text(
                  scc.safeContent.value
                      ? 'Block all age restricted categories and unsafe contents from favorites list'
                      : 'Allow mature contents',
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.storage,
                size: 26,
              ),
              title: Text(
                'Storage Location',
                style: textTheme.titleLarge,
              ),
              onTap: () {
                GetSmack(
                  body:
                      'Downloaded images are saved to /storage/emulated/0/Pictures/PixelPerks',
                  icon: Icons.storage,
                  title: 'Storage Location',
                  position: SnackPosition.BOTTOM,
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.refresh,
                size: 26,
              ),
              title: Text(
                'Clear Cache',
                style: textTheme.titleLarge,
              ),
              onTap: () async {
                await fc.clearFavList();
                DefaultCacheManager().emptyCache().then(
                      (value) => GetSmack(
                        body: 'PixelPerks cache is cleared.',
                        icon: Icons.done,
                        title: 'Cache Cleared',
                        position: SnackPosition.BOTTOM,
                      ),
                    );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.android,
                size: 26,
              ),
              title: Text(
                'Version',
                style: textTheme.titleLarge,
              ),
              subtitle: Text(
                '1.3.1',
                style: textTheme.bodyMedium,
              ),
            ),
            const Spacer(),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Power by',
                    style: textTheme.titleMedium,
                  ),
                  Image.asset(
                    modeController.darkMode.value
                        ? 'assets/images/pixabay-white.png'
                        : 'assets/images/pixabay-black.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
