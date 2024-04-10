
import 'package:get/get.dart';
import 'home_seller_controller.dart';

class HomeSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeSellerController());
  }
}
