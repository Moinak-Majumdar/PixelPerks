// hl5 design splash screen and take screenshot.

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 233, 252, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 236, 248),
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset('assets/icon/foreground-black.png'),
          ),
          const SizedBox(height: 60),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Power by',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                  Image.asset('assets/images/pixabay-black.png'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
