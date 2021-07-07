import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:cool_audio_player/app/modules/player_module/player_controller.dart';
import 'package:get/get.dart';

class SimplePlayerController extends GetxController {
  AudioCache audioCache = AudioCache();
  Question question = Question();

  @override
  void onInit() {
    super.onInit();
  }

  play() {
    audioCache.fixedPlayer!.resume();
  }

  pause() {
    audioCache.fixedPlayer!.pause();
  }

  stop() {
    audioCache.fixedPlayer!.stop();
  }

  next() {
    Get.find<GlobalController>().questionPlaying.value = Get.find<PlayerController>().questions[question.nro];
    if (audioCache.fixedPlayer!.state == PlayerState.PLAYING) {
      audioCache.fixedPlayer!.stop();
    }
    audioCache.play('sounds/'+Get.find<GlobalController>().questionPlaying.value.labels[0].fileName);
  }

  previous() {
    Get.find<GlobalController>().questionPlaying.value = Get.find<PlayerController>().questions[question.nro - 2];
    if (audioCache.fixedPlayer!.state == PlayerState.PLAYING) {
      audioCache.fixedPlayer!.stop();
    }
    audioCache.play('sounds/'+Get.find<GlobalController>().questionPlaying.value.labels[0].fileName);
  }
}