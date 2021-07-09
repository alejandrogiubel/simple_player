import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rx<Question> questionPlaying = Rx<Question>(Question());
  RxList<Question> questions = RxList<Question>();
  RxInt soundPosition = RxInt(0);
}
