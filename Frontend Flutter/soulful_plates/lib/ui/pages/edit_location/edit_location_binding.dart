
import 'package:get/get.dart';
import 'edit_location_controller.dart';

class EditLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditLocationController());
  }
}
