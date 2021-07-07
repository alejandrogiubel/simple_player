import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rx<Question> questionPlaying = Rx<Question>(Question());
}
