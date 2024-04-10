
import 'package:get/get.dart';
import 'saved_location_controller.dart';

class SavedLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedLocationController());
  }
}
