import 'dart:async';
import 'dart:io';
import 'package:circular_menu/circular_menu.dart';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixelperks/controller/detailed_controller.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/model/full.dart';
import 'package:pixelperks/utils/get_smack.dart';
import 'package:pixelperks/widget/center_error.dart';
import 'package:pixelperks/widget/center_loader.dart';
import 'package:pixelperks/widget/detailed_view.dart';

final dio = Dio();

Future<FullImageServer> getDetailed(int id) async {
  try {
    final res = await dio.get(dotenv.env['SERVER_DETAILED']!, queryParameters: {
      "secret": dotenv.env['SECRET'],
      "imageId": id,
    });

    return FullImageServer.fromJson(res.data);
  } catch (e) {
    throw Exception('exception');
  }
}

class Detailed extends StatelessWidget {
  const Detailed({super.key, required this.imageId, required this.isSafe});

  final int imageId;
  final bool isSafe;

  @override
  Widget build(context) {
    DarkModeController modeController = Get.put(DarkModeController());
    DetailedController dc = Get.put(DetailedController());

    return Scaffold(
      body: CircularMenu(
        backgroundWidget: Obx(
          () {
            if (dc.items.containsKey('$imageId')) {
              final details = dc.items['$imageId'];
              if (details != null) {
                return DetailedView(
                  details: details,
                  isDarkMode: modeController.darkMode.value,
                  isSafe: isSafe,
                );
              }
            }

            return FutureBuilder(
              future: getDetailed(imageId),
              builder: (ctx, snap) {
                if (snap.hasData) {
                  Timer(const Duration(milliseconds: 100), () {
                    dc.addFullStateCache(snap.data!.detailed);
                  });
                }

                if (snap.hasError) {
                  return const CenterError();
                }

                return const CenterLoader(msg: 'Waiting...');
              },
            );
          },
        ),
        alignment: Alignment.bottomCenter,
        curve: Curves.easeInOutCirc,
        toggleButtonBoxShadow: const [],
        toggleButtonColor: Colors.black54,
        items: [
          CircularMenuItem(
            onTap: () async {
              await homeScreen(dc.items['$imageId']!.image);
            },
            icon: Icons.home,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
          CircularMenuItem(
            onTap: () async {
              await lockScreen(dc.items['$imageId']!.image);
            },
            icon: Icons.screen_lock_portrait,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
          CircularMenuItem(
            onTap: () async {
              await homeAndLockScreen(dc.items['$imageId']!.image);
            },
            icon: Icons.phone_android,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
          CircularMenuItem(
            onTap: () {
              if (dc.items['$imageId'] != null) {
                showDetails(context, dc.items['$imageId']!);
              }
            },
            icon: EvaIcons.infoOutline,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
          CircularMenuItem(
            onTap: () async {
              final permission = await handlePermission();

              if (permission) {
                handelDownload(
                  imgName: dc.items[imageId.toString()]!.imgName,
                  url: dc.items[imageId.toString()]!.image,
                );
              }
            },
            icon: EvaIcons.downloadOutline,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void showDetails(context, FullImage data) {
    final textTheme = Theme.of(context).textTheme;

    final stats = [
      {
        "count": data.likes.toString(),
        "icon": Icons.thumb_up,
      },
      {
        "count": data.downloads.toString(),
        "icon": EvaIcons.download,
      },
      {
        "count": data.views.toString(),
        "icon": EvaIcons.eyeOutline,
      },
      {
        "count": "${(data.imageSize / 1000000).toStringAsFixed(2)} mb",
        "icon": EvaIcons.fileOutline,
      }
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: RichText(
          text: const TextSpan(
            text: 'Powered by ',
            style: TextStyle(
              fontFamily: 'PixelifySans',
              fontSize: 25,
              color: Colors.blue,
            ),
            children: [
              TextSpan(
                text: ' Pixabay',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 15, 15),
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Every photographer/image owner deserve credit. Say thanks to Pixabay and the owner. ❤️',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(data.ownerDp),
                  radius: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  data.owner,
                  style: textTheme.titleLarge,
                )
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Stats : ',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final elm in stats)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        elm['icon'] as IconData,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        elm['count'] as String,
                        style: textTheme.labelLarge,
                      ),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> handlePermission() async {
    const permission = Permission.storage;

    if (await permission.isGranted) {
      return true;
    }

    if (await permission.isDenied) {
      final request = await permission.request();

      if (request.isGranted) {
        return true;
      } else {
        GetSmack(
          title: 'Permission required.',
          body: 'Storage permission is needed to download images.',
          icon: Icons.error,
        );
      }
    }

    if (await permission.isPermanentlyDenied) {
      GetSmack(
        title: 'Permission denied',
        body:
            'Sorry, storage permission is denied permanently, without permission you can not download images.',
        icon: Icons.error,
      );
    }
    return false;
  }

  Future<void> handelDownload(
      {required String imgName, required String url}) async {
    final response = await dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );

    try {
      final subDir = Directory(
        '/storage/emulated/0/Pictures/PixelPerks',
      ).existsSync()
          ? Directory(
              '/storage/emulated/0/Pictures/PixelPerks',
            )
          : await Directory(
              '/storage/emulated/0/Pictures/PixelPerks',
            ).create(recursive: true);

      final File newFile =
          await File("${subDir.path}/$imgName").create(recursive: true);
      await newFile.writeAsBytes(response.data);
      GetSmack(
        title: 'Yeah!',
        body:
            'A new perks is downloaded. Location: Internal storage/Pictures/PixelPerks/$imgName',
        icon: EvaIcons.download,
      );
    } catch (e) {
      GetSmack(
        title: 'Oops!',
        body: 'Failed to download this perks.',
        icon: Icons.error,
      );
      throw Exception(e);
    }
  }

  Future<void> homeAndLockScreen(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);
    final res = await WallpaperManager.setWallpaperFromFile(file.path, 3);

    if (res) {
      GetSmack(
        title: 'Awesome!',
        body: 'A new Perks applied at your both home and lock screen.',
        icon: Icons.phone_android,
      );
    }
  }

  Future<void> homeScreen(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);

    final res = await WallpaperManager.setWallpaperFromFile(file.path, 1);
    if (res) {
      GetSmack(
        title: "Awesome!",
        body: 'A new Perks is applied at your home screen.',
        icon: Icons.home,
      );
    }
  }

  Future<void> lockScreen(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);
    final res = await WallpaperManager.setWallpaperFromFile(file.path, 2);
    if (res) {
      GetSmack(
        title: "Awesome!",
        body: 'A new Perks is applied at your lock screen.',
        icon: Icons.screen_lock_portrait,
      );
    }
  }
}
