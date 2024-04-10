import 'package:get/get.dart';
import 'package:soulful_plates/ui/pages/store_details/store_details_controller.dart';

class StoreDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreDetailsController());
  }
}
