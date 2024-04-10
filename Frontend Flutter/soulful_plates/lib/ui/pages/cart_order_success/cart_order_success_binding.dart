
import 'package:get/get.dart';
import 'cart_order_success_controller.dart';

class CartOrderSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartOrderSuccessController());
  }
}
