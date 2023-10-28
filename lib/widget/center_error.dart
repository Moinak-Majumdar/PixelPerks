import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CenterError extends StatelessWidget {
  const CenterError(
      {super.key, this.error = 'Oops! Failed to connect server.'});
  const CenterError.custom({super.key, required this.error});

  final String error;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            EvaIcons.alertTriangleOutline,
            color: Colors.red,
            size: 50,
          ),
          const SizedBox(height: 32),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
