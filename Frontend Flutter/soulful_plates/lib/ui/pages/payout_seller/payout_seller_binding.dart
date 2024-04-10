
import 'package:get/get.dart';
import 'payout_seller_controller.dart';

class PayoutSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PayoutSellerController());
  }
}
