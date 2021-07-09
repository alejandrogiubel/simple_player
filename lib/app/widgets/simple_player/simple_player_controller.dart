import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/audio_player_service.dart';
import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:get/get.dart';

class SimplePlayerController extends GetxController {
  AudioCache audioCache = AudioCache();
  Question question = Question();
  bool stopped = true;

  @override
  void onInit() {
    super.onInit();
  }

  play() async {
    GlobalController globalController = Get.find();

    if (!AudioService.running) {
      await startAudioService();
      List<MediaItem> mediaItems = [];
      Get.find<GlobalController>().questions.forEach((element) {
        MediaItem mediaItem = MediaItem(
          id: element.labels[0].fileName,
          album: 'English questions',
          title: element.labels[0].text
        );
        mediaItems.add(mediaItem);
      });
      await AudioService.updateQueue(mediaItems);
      // AudioService.setRepeatMode(AudioServiceRepeatMode.all);
    }
    if (stopped) {
      AudioService.playMediaItem(
        MediaItem(
          id: globalController.questionPlaying.value.labels[0].fileName,
          album: 'English questions',
          title: globalController.questionPlaying.value.labels[0].text
        )
      );
    } else {
      AudioService.play();
    }
  }

  pause() {
    stopped = false;
    AudioService.pause();
  }

  stop() {
    stopped = true;
    AudioService.stop();
  }

  next() async {
    AudioService.skipToNext();
    GlobalController globalController = Get.find<GlobalController>();
    int index = globalController.questions.indexOf(globalController.questionPlaying.value);
    if (index != -1) {
      if (index == globalController.questions.length) {
        globalController.questionPlaying.value = globalController.questions[index];
      } else {
        globalController.questionPlaying.value = globalController.questions[index + 1];
      }
    }
    // Get.find<GlobalController>().questionPlaying.value = Get.find<PlayerController>().questions[question.nro];
    // if (audioCache.fixedPlayer!.state == PlayerState.PLAYING) {
    //   audioCache.fixedPlayer!.stop();
    // }
    // audioCache.play('sounds/'+Get.find<GlobalController>().questionPlaying.value.labels[0].fileName);
  }

  previous() {
    AudioService.skipToPrevious();
    GlobalController globalController = Get.find<GlobalController>();
    int index = globalController.questions.indexOf(globalController.questionPlaying.value);
    if (index != -1) {
      if (index == 0) {
        globalController.questionPlaying.value = globalController.questions[index];
      } else {
        globalController.questionPlaying.value = globalController.questions[index - 1];
      }
    }
    // Get.find<GlobalController>().questionPlaying.value = Get.find<PlayerController>().questions[question.nro - 2];
    // if (audioCache.fixedPlayer!.state == PlayerState.PLAYING) {
    //   audioCache.fixedPlayer!.stop();
    // }
    // audioCache.play('sounds/'+Get.find<GlobalController>().questionPlaying.value.labels[0].fileName);
  }
}