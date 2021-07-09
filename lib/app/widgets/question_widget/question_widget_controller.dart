import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/audio_player_service.dart';
import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionWidgetController extends GetxController {
  AudioCache audioCache = AudioCache();
  Question question = Question();

  TextStyle onPauseTextStyle = TextStyle(
    color: Colors.black
  );

  TextStyle onPlayTextStyle = TextStyle(
    color: Colors.white
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // GlobalController globalController = Get.find();
    // if (globalController.questionPlaying.value.nro == question.nro) {
    //   if (audioCache.fixedPlayer!.state == PlayerState.PLAYING || audioCache.fixedPlayer!.state == PlayerState.PAUSED) {
    //     isPlaying.value = true;
    //   }
    // }
    //
    // audioCache.fixedPlayer!.onPlayerCompletion.listen((event) {
    //   isPlaying.value = false;
    // });
    //
    // audioCache.fixedPlayer!.onPlayerStateChanged.listen((event) {
    //   if (event == PlayerState.STOPPED && question.labels[0].fileName != globalController.questionPlaying.value.labels[0].fileName) {
    //     isPlaying.value = false;
    //   }
    //   if (event == PlayerState.PLAYING && question.labels[0].fileName == globalController.questionPlaying.value.labels[0].fileName) {
    //     isPlaying.value = true;
    //   }
    // });
  }

  playLocal(Question question, AudioCache audioCache) async {
    GlobalController globalController = Get.find();
    globalController.questionPlaying.value = question;

    if (audioCache.fixedPlayer!.state == PlayerState.PLAYING) {
      audioCache.fixedPlayer!.stop();
    }

    // isPlaying.value = true;
    await audioCache.play('sounds/'+question.labels[0].fileName);
  }

  playWithService(Question question) async {
    GlobalController globalController = Get.find();
    globalController.questionPlaying.value = question;

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
    }
    AudioService.playMediaItem(
      MediaItem(
        id: question.labels[0].fileName,
        album: 'English questions',
        title: question.labels[0].text
      )
    );
  }
}