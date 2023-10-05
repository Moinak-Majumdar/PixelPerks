import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pixelperks/hive_fav.dart';
import 'package:pixelperks/model/preview.dart';

const _boxName = 'HiveFavBox';

class FavoriteController extends GetxController {
  RxSet<PreviewImage> favList = <PreviewImage>{}.obs;
  RxBool isAnimate = false.obs;

  @override
  void onInit() async {
    final box = await Hive.openBox<HiveFav>(_boxName);
    final data = box.values.toList();

    if (data.isNotEmpty) {
      for (final elm in data) {
        favList.add(PreviewImage(
            id: elm.id, web340: elm.web340, fromSafeSource: elm.isSafe));
      }
    }

    await box.close();
    super.onInit();
  }

  Future<void> addImageToFav({
    required int id,
    required String web340,
    required bool isSafe,
  }) async {
    final ack = favList.add(PreviewImage(
      id: id,
      web340: web340,
      fromSafeSource: isSafe,
    ));

    if (ack) {
      final box = await Hive.openBox<HiveFav>(_boxName);
      await box.put(
        '$id',
        HiveFav(
          id: id,
          web340: web340,
          isSafe: isSafe,
        ),
      );
      await box.close();
    }
  }

  Future<void> removeImageFromFav(int id) async {
    final elm = favList.where((element) => element.id == id).toList();
    final ack = favList.remove(elm[0]);

    if (ack) {
      final box = await Hive.openBox<HiveFav>(_boxName);
      await box.delete('$id');
      await box.close();
    }
  }

  bool alreadyFavorite(int id) {
    final fav = favList.where((elm) => elm.id == id).toList();

    return fav.isNotEmpty;
  }
}
