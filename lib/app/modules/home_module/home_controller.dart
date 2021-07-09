import 'package:cool_audio_player/app/audio_player_service.dart';
import 'package:cool_audio_player/app/routes/app_pages.dart';
import 'package:get/get.dart';


class HomeController extends GetxController{

  toPlayer() async {
    await startAudioService();
    Get.toNamed(Routes.PLAYER);
  }
}
