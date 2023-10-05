import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CenterError extends StatelessWidget {
  const CenterError({super.key});

  @override
  Widget build(context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            EvaIcons.alertTriangleOutline,
            color: Colors.red,
            size: 50,
          ),
          SizedBox(height: 32),
          Text(
            'Oops! Failed to connect server.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PixelifySans',
              color: Colors.blueGrey,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
