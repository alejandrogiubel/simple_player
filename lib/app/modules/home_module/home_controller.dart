import 'package:cool_audio_player/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  toPlayer() {
    Get.toNamed(Routes.PLAYER);
  }
}
