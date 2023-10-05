import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetSmack {
  GetSmack({
    required this.body,
    required this.icon,
    required this.title,
    this.position = SnackPosition.TOP,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          style: const TextStyle(
            fontFamily: 'PixelifySans',
            color: Colors.amber,
            fontSize: 24,
          ),
        ),
        message: body,
        duration: const Duration(seconds: 5),
        isDismissible: true,
        backgroundColor: const Color.fromARGB(255, 11, 11, 11),
        borderRadius: 18,
        snackPosition: position,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        icon: Icon(
          icon,
          size: 36,
          color: Colors.amber,
        ),
      ),
    );
  }
  final String title, body;
  final IconData icon;
  final SnackPosition position;
}
