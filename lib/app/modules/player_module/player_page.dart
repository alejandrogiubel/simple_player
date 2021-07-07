import 'package:cool_audio_player/app/global_controller.dart';
import 'package:cool_audio_player/app/widgets/question_widget/question_widget.dart';
import 'package:cool_audio_player/app/widgets/simple_player/simple_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cool_audio_player/app/modules/player_module/player_controller.dart';

class PlayerPage extends GetView<PlayerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Player')),
        body: getBody(),
        bottomSheet: Obx(() {
          return SimplePlayer(
            question: Get.find<GlobalController>().questionPlaying.value,
            audioCache: controller.audioCache,
          );
        })
    );
  }

  getBody() {
    return Obx(() {
      return Visibility(
        visible: controller.questions.isNotEmpty,
        child: ListView.builder(
            itemCount: controller.questions.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                child: QuestionWidget(
                  question: controller.questions[index],
                  audioCache: controller.audioCache,
                ),
              );
            }
        ),
        replacement: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    });
  }


}
