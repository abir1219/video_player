import 'package:get/get.dart';
import 'package:video_reels_player/reels_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReelsController>(() => ReelsController());
  }

}