import '../../app/modules/player_module/player_page.dart';
import '../../app/modules/player_module/player_bindings.dart';
import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PLAYER,
      page: () => PlayerPage(),
      binding: PlayerBinding(),
    ),
  ];
}
