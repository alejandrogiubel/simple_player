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
      bottomSheet:SimplePlayer(
        audioCache: controller.audioCache,
      )
    );
  }

  getBody() {
    return Obx(() {
      return Visibility(
        visible: Get.find<GlobalController>().questions.isNotEmpty,
        child: ListView.builder(
          itemCount: Get.find<GlobalController>().questions.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: QuestionWidget(
                question: Get.find<GlobalController>().questions[index],
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
