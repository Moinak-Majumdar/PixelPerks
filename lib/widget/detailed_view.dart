import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/favorite_controller.dart';
import 'package:pixelperks/model/full.dart';
import 'package:pixelperks/widget/bouncable.dart';

class DetailedView extends StatelessWidget {
  const DetailedView({
    super.key,
    required this.details,
    required this.isDarkMode,
    required this.isSafe,
  });
  final FullImage details;
  final bool isDarkMode, isSafe;

  @override
  Widget build(context) {
    FavoriteController fc = Get.put(FavoriteController());

    return Obx(
      () {
        final alreadyFavorite = fc.alreadyFavorite(details.id);
        final isAnimated = fc.isAnimate.value;

        return GestureDetector(
          onDoubleTap: () {
            if (!alreadyFavorite) {
              fc.addImageToFav(
                id: details.id,
                web340: details.web340,
                isSafe: isSafe,
              );
            }
            fc.isAnimate.value = true;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: details.image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                errorWidget: (context, url, error) => const Icon(
                  EvaIcons.alertCircleOutline,
                  size: 32,
                  color: Colors.red,
                ),
                placeholder: (context, url) => Icon(
                  EvaIcons.bulbOutline,
                  size: 32,
                  color: isDarkMode ? Colors.amber : Colors.teal,
                ),
              ),
              Opacity(
                opacity: isAnimated ? 1 : 0,
                child: WidgetBounce(
                  isAnimating: isAnimated,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    fc.isAnimate.value = false;
                  },
                  child: const Icon(
                    EvaIcons.heart,
                    color: Color.fromARGB(255, 255, 10, 10),
                    size: 110,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 12,
                child: WidgetBounce(
                  isAnimating: alreadyFavorite,
                  alwaysAnimated: true,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () async {
                      if (alreadyFavorite) {
                        fc.removeImageFromFav(details.id);
                      } else {
                        fc.addImageToFav(
                          id: details.id,
                          web340: details.web340,
                          isSafe: isSafe,
                        );
                        fc.isAnimate.value = true;
                      }
                    },
                    icon: Icon(
                      alreadyFavorite ? EvaIcons.heart : EvaIcons.heartOutline,
                      color: const Color.fromARGB(255, 255, 10, 10),
                      size: 32,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
