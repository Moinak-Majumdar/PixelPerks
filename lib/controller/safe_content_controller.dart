import 'package:get/get.dart';

class SafeContentController extends GetxController {
  RxBool safeContent = true.obs;

  void toggleSafeContent(bool val) {
    safeContent.value = val;
  }
}
