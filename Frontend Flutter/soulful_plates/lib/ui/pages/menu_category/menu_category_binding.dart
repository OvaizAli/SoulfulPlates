
import 'package:get/get.dart';
import 'menu_category_controller.dart';

class MenuCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuCategoryController());
  }
}
