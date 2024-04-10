
import 'package:get/get.dart';
import 'cart_payment_controller.dart';

class CartPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartPaymentController());
  }
}
