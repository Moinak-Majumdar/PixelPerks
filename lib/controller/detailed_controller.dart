import 'package:get/get.dart';
import 'package:pixelperks/model/full.dart';

class DetailedController extends GetxController {
  RxMap<String, FullImage> items = <String, FullImage>{}.obs;

  void addFullStateCache(FullImage item) {
    items.value = {...items, '${item.id}': item};
  }
}
