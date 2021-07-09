import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:cool_audio_player/app/widgets/simple_player/simple_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class SimplePlayer extends GetView<SimplePlayerController> {
  final AudioCache audioCache;

  SimplePlayer({required this.audioCache});

  @override
  Widget build(BuildContext context) {
    controller.audioCache = audioCache;
    return SolidBottomSheet(
      headerBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Colors.blueGrey
        ),
        child: Center(
          child: Text("En reproducción",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
        ),
        height: 50,
      ),
      toggleVisibilityOnTap: true,
      maxHeight: Get.height * 0.3,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: StreamBuilder<PlaybackState>(
            stream: AudioService.playbackStateStream,
            builder: (context, AsyncSnapshot<PlaybackState> snapshot) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.music_note_outlined, size: 50,),
                      ),
                      SizedBox(width: 20,),
                      Get.find<GlobalController>().questionPlaying.value.labels.isNotEmpty ?
                      Flexible(
                        child: Obx(() {
                          return Text(Get.find<GlobalController>().questionPlaying.value.labels[0].text);
                        })
                      ) :
                      Flexible(
                        child: Text('No se está reproduciendo nada')
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Obx(() {
                    return Text(Get.find<GlobalController>().soundPosition.value.toString());
                  }),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.previous();
                        },
                        icon: Icon(Icons.fast_rewind_outlined)
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.play();
                        },
                        icon: Icon(Icons.play_arrow_outlined)
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.pause();
                        },
                        icon: Icon(Icons.pause_outlined)
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.stop();
                        },
                        icon: Icon(Icons.stop_outlined)
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.next();
                        },
                        icon: Icon(Icons.fast_forward_outlined)
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
