
import 'package:get/get.dart';
import 'order_history_buyer_controller.dart';

class OrderHistoryBuyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderHistoryBuyerController());
  }
}
