import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:cool_audio_player/app/data/provider/api_provider.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController{

  // RxList<String> soundsKey = RxList<String>();
  // List<String> soundsName = [];
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
    Get.find<GlobalController>().questions.addAll(await apiProvider.getQuestions());
    List<MediaItem> mediaItems = [];
    Get.find<GlobalController>().questions.forEach((element) {
      MediaItem mediaItem = MediaItem(
        id: element.labels[0].fileName,
        album: 'English questions',
        title: element.labels[0].text,
      );
      mediaItems.add(mediaItem);
    });
    await AudioService.updateQueue(mediaItems);
    // AudioService.setRepeatMode(AudioServiceRepeatMode.all);

    AudioService.playbackStateStream.listen((PlaybackState event) {
      print('PLAY BACK STATE STREAM');
      if(event.playing) {
        print('PLAYING   ' + AudioService.currentMediaItem!.id.toString());
        Question question = Get.find<GlobalController>().questions.firstWhere((element) => element.labels[0].fileName == AudioService.currentMediaItem!.id);
        Get.find<GlobalController>().questionPlaying.value = question;
      } else {
        Get.find<GlobalController>().soundPosition.value = 0;
      }
    });

    AudioService.currentMediaItemStream.listen((event) {
      if (event != null) {
        if (Get.find<GlobalController>().questionPlaying.value.labels[0].fileName != event.id) {
          Get.find<GlobalController>().soundPosition.value = 0;
        }
      }
    });

    // AudioService.customEventStream.listen((event) async {
    //   int duration = await event;
    //   print('EL CUSTOM EVENT *******************************' + duration.toString());
    //   // Get.find<GlobalController>().soundPosition.value = event;
    // });

    AudioService.positionStream.listen((Duration event) {
      Get.find<GlobalController>().soundPosition.value = event.inSeconds;
    });
  }

}
