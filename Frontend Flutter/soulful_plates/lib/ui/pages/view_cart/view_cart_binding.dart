
import 'package:get/get.dart';
import 'view_cart_controller.dart';

class ViewCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewCartController());
  }
}
