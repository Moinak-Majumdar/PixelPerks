import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/theme_controller.dart';
import 'package:pixelperks/model/preview.dart';
import 'package:pixelperks/screens/detailed.dart';

class PreviewGrid extends StatelessWidget {
  const PreviewGrid({
    super.key,
    required this.server,
    this.isSafe = true,
  });
  final List<PreviewImage> server;
  final bool isSafe;

  @override
  Widget build(context) {
    DarkModeController modeController = Get.put(DarkModeController());

    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        pattern: const [
          QuiltedGridTile(4, 2),
          QuiltedGridTile(3, 2),
          QuiltedGridTile(4, 2),
          QuiltedGridTile(4, 2),
        ],
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Detailed(
                    imageId: server[index].id,
                    isSafe: isSafe,
                  ),
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: server[index].web340,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  EvaIcons.alertCircleOutline,
                  size: 32,
                  color: Colors.red,
                ),
              ),
              placeholder: (context, url) => Obx(
                () => Center(
                  child: Icon(
                    EvaIcons.bulbOutline,
                    size: 32,
                    color: modeController.darkMode.value
                        ? Colors.amber
                        : Colors.teal,
                  ),
                ),
              ),
            ),
          ),
        ),
        childCount: server.length,
      ),
    );
  }
}
