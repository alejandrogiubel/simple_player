import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cool_audio_player/app/modules/home_module/home_controller.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple audio player')),
      body: Center(
        child: ElevatedButton(
          child: Text('Player'),
          onPressed: () {
            controller.toPlayer();
          },
        ),
      ),
    );
  }
}
