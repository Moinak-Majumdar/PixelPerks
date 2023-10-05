import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixelperks/screens/choice.dart';
import 'package:pixelperks/screens/favorites.dart';
import 'package:pixelperks/screens/settings.dart';
import 'package:url_launcher/url_launcher.dart';

const List<Map<String, dynamic>> navigationList = [
  {
    "title": "Review",
    "icon": Icon(EvaIcons.edit2Outline),
    "route": null,
  },
  {
    "title": "Share",
    "icon": Icon(EvaIcons.shareOutline),
    "route": null,
  },
  {
    "title": "Settings",
    "icon": Icon(EvaIcons.settingsOutline),
    "route": Settings(),
  },
];

class LandingDrawer extends StatelessWidget {
  const LandingDrawer({super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: Text(
              "FeedBack",
              style: textTheme.headlineSmall,
            ),
            onTap: () async {
              final email = Uri.encodeComponent(dotenv.env['EMAIL']!);
              final subject =
                  Uri.encodeComponent('Flutter PixelPerks Feedback.');
              await launchUrl(Uri.parse("mailto:$email?subject=$subject"));
            },
          ),
          for (final elm in navigationList)
            ListTile(
              leading: elm['icon'],
              title: Text(
                elm['title'],
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                if (elm['route'] != null) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => elm['route'],
                    ),
                  );
                }
              },
            )
        ],
      ),
    );
  }
}
