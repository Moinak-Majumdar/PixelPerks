import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixelperks/utils/get_smack.dart';

class ScreenOperation {
  final _dio = Dio();

  Future<bool> handleStoragePermission() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final version = int.parse(androidInfo.version.release) >= 11;

    // managing the permission depends on android 11 or later.
    final permission =
        version ? Permission.manageExternalStorage : Permission.storage;

    if (await permission.isGranted) {
      return true;
    } else {
      GetSmack(
        title: 'Permission required.',
        body: 'Storage permission is needed to download images.',
        icon: Icons.error,
      );

      if (await permission.isPermanentlyDenied) await openAppSettings();
      if (await permission.isDenied) await permission.request();

      return false;
    }
  }

  Future<void> handelDownload(
      {required String imgId, required String url}) async {
    final response = await _dio.get(
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
          await File("${subDir.path}/$imgId.jpg").create(recursive: true);
      await newFile.writeAsBytes(response.data);
      GetSmack(
        title: 'Yeah!',
        body:
            'A new perks is downloaded. Location: Internal storage/Pictures/PixelPerks/$imgId.jpg',
        icon: EvaIcons.download,
      );
    } catch (e) {
      GetSmack(
        title: 'Oops!',
        body: 'Failed to download this perks.',
        icon: Icons.error,
      );

      // debug only.
      // Get.to(() => MessageDebug(message: e.toString()));
      throw Exception(e);
    }
  }

  Future<void> setAtHomeAndLockScreen({required String url}) async {
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

  Future<void> setAtHomeScreen({required String url}) async {
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

  Future<void> setAtLockScreen({required String url}) async {
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
