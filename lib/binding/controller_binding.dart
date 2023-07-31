import 'package:get/get.dart';
import 'package:video_reels_player/controller/reels_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReelsController>(() => ReelsController());
  }

}