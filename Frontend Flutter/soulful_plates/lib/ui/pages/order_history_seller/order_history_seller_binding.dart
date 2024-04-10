
import 'package:get/get.dart';
import 'order_history_seller_controller.dart';

class OrderHistorySellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderHistorySellerController());
  }
}
