import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixelperks/screens/choice.dart';
import 'package:pixelperks/screens/downloaded.dart';
import 'package:pixelperks/screens/favorites.dart';
import 'package:pixelperks/screens/settings.dart';
import 'package:pixelperks/utils/get_smack.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingDrawer extends StatelessWidget {
  const LandingDrawer({super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    final List<Map<String, dynamic>> navigationList = [
      {
        "title": "Feedback",
        "icon": const Icon(Icons.feedback_outlined),
        "onTap": () async {
          final email = Uri.encodeComponent(dotenv.env['EMAIL']!);
          final subject = Uri.encodeComponent('Flutter PixelPerks Feedback.');
          await launchUrl(Uri.parse("mailto:$email?subject=$subject"));
        }
      },
      {
        "title": "Review",
        "icon": const Icon(EvaIcons.edit2Outline),
        "onTap": () {
          GetSmack(
            title: 'Missing feature !',
            icon: EvaIcons.edit2Outline,
            position: SnackPosition.BOTTOM,
            body:
                'This feature is missing currently. Will be added as soon as the app get deployed at play store.',
          );
        },
      },
      {
        "title": "Share",
        "icon": const Icon(EvaIcons.shareOutline),
        "onTap": () async {
          final tempDir = await getTemporaryDirectory();
          File file;

          if (File('${tempDir.path}/icon.png').existsSync()) {
            file = File('${tempDir.path}/icon.png');
          } else {
            final bytes = await rootBundle.load('assets/icon/icon.png');
            final list = bytes.buffer.asUint8List();
            file =
                await File('${tempDir.path}/icon.png').create(recursive: true);
            file.writeAsBytesSync(list);
          }

          Share.shareXFiles(
            [XFile(file.path)],
            subject: "Download this wallpaper from github release.",
            text:
                "Hey, just look at this!! ⭐⭐⭐\n\n A delightful simplest and minimalistic wallpaper app for your android device. \n\n Download this: https://github.com/Moinak-Majumdar/PixelPerks/releases \n\n ❤️❤️",
          );
        },
      },
      {
        "title": "Settings",
        "icon": const Icon(EvaIcons.settingsOutline),
        "onTap": () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const Settings(),
            ),
          );
        },
      },
    ];

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.amber,
                  Colors.orange,
                  Colors.red,
                ],
              ),
            ),
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontFamily: 'PixelifySans',
                  color: Colors.black,
                  fontSize: 42,
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText('Pixel Perks'),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              EvaIcons.grid,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Category',
              style: textTheme.headlineSmall,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Choice(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.heart,
              color: Color.fromARGB(255, 236, 21, 17),
            ),
            title: Text(
              'Favorites',
              style: textTheme.headlineSmall,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Favorites(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.download_done_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Downloaded',
              style: textTheme.headlineSmall,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Downloaded(),
                ),
              );
            },
          ),
          const Divider(),
          for (final elm in navigationList)
            ListTile(
              leading: elm['icon'],
              title: Text(
                elm['title'],
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                if (elm['onTap'] != null) {
                  elm['onTap']();
                }
              },
            )
        ],
      ),
    );
  }
}
