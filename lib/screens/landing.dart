import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/screens/ec.dart';
import 'package:pixelperks/screens/latest.dart';
import 'package:pixelperks/screens/trending.dart';
import 'package:pixelperks/widget/landing_drawer.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _pageTitle = 'Latest';
  Widget _body = const Latest();

  @override
  Widget build(context) {
    DarkModeController modeController = Get.put(DarkModeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        leading: Builder(
          builder: (ctx) => IconButton(
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
            icon: Obx(
              () => Icon(
                EvaIcons.menuArrowOutline,
                size: 24,
                color:
                    modeController.darkMode.value ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
      drawer: const LandingDrawer(),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _body,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          backgroundColor:
              modeController.darkMode.value ? Colors.black : Colors.grey[200]!,
          color: modeController.darkMode.value ? Colors.white12 : Colors.white,
          onTap: _changeScreen,
          height: 50,
          items: const [
            Icon(EvaIcons.optionsOutline),
            Icon(EvaIcons.award),
            Icon(EvaIcons.trendingUp),
          ],
        ),
      ),
    );
  }

  void _changeScreen(int index) {
    switch (index) {
      case 0:
        setState(() {
          _pageTitle = 'Latest';
          _body = const Latest();
        });
        break;
      case 1:
        setState(() {
          _pageTitle = 'Editors Choice';
          _body = const EditorsChoice();
        });
        break;
      case 2:
        setState(() {
          _pageTitle = 'Trending';
          _body = const Trending();
        });
        break;
    }
  }
}
