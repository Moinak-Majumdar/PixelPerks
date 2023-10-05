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
  int _pageIndex = 0;
  Widget _body = const Latest();

  void _changeScreen(int index) {
    switch (index) {
      case 0:
        setState(() {
          _pageIndex = 0;
          _pageTitle = 'Latest';
          _body = const Latest();
        });
        break;
      case 1:
        setState(() {
          _pageIndex = 1;
          _pageTitle = 'Editors Choice';
          _body = const EditorsChoice();
        });
        break;
      case 2:
        setState(() {
          _pageIndex = 2;
          _pageTitle = 'Trending';
          _body = const Trending();
        });
        break;
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: _body,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _changeScreen,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.optionsOutline,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.award,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.trendingUp,
            ),
            label: '',
          )
        ],
      ),
    );
  }
}
