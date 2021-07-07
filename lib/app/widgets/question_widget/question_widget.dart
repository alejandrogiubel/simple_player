import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:cool_audio_player/app/widgets/question_widget/question_widget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionWidget extends GetWidget<QuestionWidgetController> {
  final Question question;
  final AudioCache audioCache;

  QuestionWidget({
    required this.question,
    required this.audioCache,
  });

  @override
  Widget build(BuildContext context) {
    controller.audioCache = audioCache;
    controller.question = question;
    return Obx(() {
      return AnimatedContainer(
        decoration: BoxDecoration(
          color: controller.isPlaying.value ? Colors.pinkAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.all(10),
        duration: Duration(milliseconds: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question number: ' + question.nro.toString(),
              style: controller.isPlaying.value ? controller.onPlayTextStyle : controller.onPauseTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(question.labels[0].text,
                  style: controller.isPlaying.value ? controller.onPlayTextStyle : controller.onPauseTextStyle,
                ),),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashRadius: 15,
                    icon: Icon(Icons.play_circle_fill),
                    onPressed: () {
                      if (question.labels[0].hasAudio) {
                        controller.playLocal(question, audioCache);
                      } else {
                        Get.snackbar('Error', 'No se encontró el recurso');
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
