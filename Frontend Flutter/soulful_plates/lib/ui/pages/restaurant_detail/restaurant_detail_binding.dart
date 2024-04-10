import 'package:get/get.dart';

import 'restaurant_detail_controller.dart';

class RestaurantDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantDetailController());
  }
}
