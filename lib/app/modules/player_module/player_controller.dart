import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:cool_audio_player/app/data/provider/api_provider.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController{

  // RxList<String> soundsKey = RxList<String>();
  // List<String> soundsName = [];
  RxList<Question> questions = RxList<Question>();
  AudioCache audioCache = AudioCache(fixedPlayer: AudioPlayer(playerId: 'player'));


  @override
  void onInit() {
    super.onInit();
    getQuestions();
  }

  // getFiles() async {
  //   print('START READING');
  //   var assetsFile = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');
  //   final Map<String, dynamic> manifestMap = json.decode(assetsFile);
  //   soundsKey.addAll(manifestMap.keys.where((element) => element.contains('assets/sounds/')).toList());
  //   soundsKey.forEach((element) {
  //     print(element);
  //   });
  // }

  // getSounds() async {
  //   ApiProvider apiProvider = Get.find();
  //   soundsName = await apiProvider.getSounds('en_CA');
  // }

  getQuestions() async {
    ApiProvider apiProvider = Get.find();
    questions.addAll(await apiProvider.getQuestions());
  }

}
