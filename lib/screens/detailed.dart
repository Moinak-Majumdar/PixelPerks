import 'dart:async';
import 'package:circular_menu/circular_menu.dart';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/detailed_controller.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/model/full.dart';
import 'package:pixelperks/utils/screen_operation.dart';
import 'package:pixelperks/widget/center_error.dart';
import 'package:pixelperks/widget/center_loader.dart';
import 'package:pixelperks/widget/detailed_view.dart';
// import 'package:pixelperks/utils/message.dart';

final dio = Dio();
final screenOperation = ScreenOperation();

Future<FullImageServer> getDetailed(int id) async {
  try {
    final res = await dio.get(
      "https://pixel-perks.vercel.app/fullImage",
      queryParameters: {
        "secret": dotenv.env['SECRET'],
        "imageId": id,
      },
    );

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
              await screenOperation.setAtHomeScreen(
                url: dc.items['$imageId']!.image,
              );
            },
            icon: Icons.home,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
          CircularMenuItem(
            onTap: () async {
              await screenOperation.setAtLockScreen(
                url: dc.items['$imageId']!.image,
              );
            },
            icon: Icons.screen_lock_portrait,
            boxShadow: const [],
            color: Colors.black54,
            iconColor: Colors.white,
          ),
          CircularMenuItem(
            onTap: () async {
              await screenOperation.setAtHomeAndLockScreen(
                url: dc.items['$imageId']!.image,
              );
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
              final permission =
                  await screenOperation.handleStoragePermission();

              if (permission) {
                await screenOperation.handelDownload(
                  imgId: imageId.toString(),
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
}
