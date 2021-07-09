import 'package:cool_audio_player/app/data/provider/api_provider.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:cool_audio_player/app/modules/home_module/home_controller.dart';
import 'package:cool_audio_player/app/widgets/question_widget/question_widget_controller.dart';
import 'package:cool_audio_player/app/widgets/simple_player/simple_player_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ApiProvider(), fenix: true);
  }
}