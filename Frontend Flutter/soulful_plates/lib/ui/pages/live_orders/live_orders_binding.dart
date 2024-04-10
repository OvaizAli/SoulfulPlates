
import 'package:get/get.dart';
import 'live_orders_controller.dart';

class LiveOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveOrdersController());
  }
}
