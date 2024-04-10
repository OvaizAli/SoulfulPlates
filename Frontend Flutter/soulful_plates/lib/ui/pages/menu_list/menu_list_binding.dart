
import 'package:get/get.dart';
import 'menu_list_controller.dart';

class MenuListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuListController());
  }
}
