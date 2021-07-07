import 'package:cool_audio_player/app/modules/player_module/player_controller.dart';
import 'package:cool_audio_player/app/widgets/question_widget/question_widget_controller.dart';
import 'package:cool_audio_player/app/widgets/simple_player/simple_player_controller.dart';
import 'package:get/get.dart';

class PlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayerController());
    Get.lazyPut(() => SimplePlayerController());
    Get.create(() => QuestionWidgetController());
  }
}