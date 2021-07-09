import 'package:audio_service/audio_service.dart';
import 'package:cool_audio_player/app/audio_player_service.dart';
import 'package:cool_audio_player/app/global_controller.dart';
import 'package:cool_audio_player/app/modules/home_module/home_bindings.dart';
import 'package:cool_audio_player/app/modules/home_module/home_page.dart';
import 'package:cool_audio_player/app/routes/app_pages.dart';
import 'package:cool_audio_player/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

void main() {
  Get.lazyPut(() => GlobalController(), fenix: true);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,       
    initialRoute: '/',       
    theme: appThemeData,
    defaultTransition: Transition.fade,       
    getPages: AppPages.pages,
    home: AudioServiceWidget(child: HomePage()),
    initialBinding: HomeBinding(),
  ));       
}
