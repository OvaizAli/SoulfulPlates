
import 'package:get/get.dart';
import 'create_menu_controller.dart';

class CreateMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateMenuController());
  }
}
