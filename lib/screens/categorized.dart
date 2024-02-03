import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/preview_controller.dart';
import 'package:pixelperks/widget/center_error.dart';
import 'package:pixelperks/widget/center_loader.dart';
import 'package:pixelperks/widget/preview_grid.dart';
import 'package:pixelperks/model/category_item.dart';

class Categorized extends StatelessWidget {
  const Categorized({super.key, required this.item});
  final CategoryItem item;

  @override
  Widget build(context) {
    final PreviewController pc = Get.put(PreviewController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () {
              // state cached :')
              if (pc.server[item.endpoint]!.isNotEmpty) {
                return PreviewGrid(
                  server: pc.server[item.endpoint]!,
                  isSafe: item.isSafe,
                );
              }

              return FutureBuilder(
                future: fetchCategorized(
                  category: item.category,
                  isSafe: item.isSafe,
                ),
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    Timer(const Duration(microseconds: 100), () {
                      pc.addSateCache(snap.data!.images, item.endpoint);
                    });

                    // return PreviewGrid(server: snap.data!.images);
                  }

                  if (snap.hasError) {
                    return const CenterError();
                  }

                  return const CenterLoader(
                      msg: 'Each pixel with unique perks..');
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
