
import 'package:get/get.dart';
import 'transaction_seller_controller.dart';

class TransactionSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionSellerController());
  }
}
