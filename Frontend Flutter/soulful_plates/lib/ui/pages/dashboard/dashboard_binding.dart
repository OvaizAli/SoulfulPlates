import 'package:get/get.dart';
import 'package:soulful_plates/ui/pages/home/home_controller.dart';
import 'package:soulful_plates/ui/pages/home_seller/home_seller_controller.dart';
import 'package:soulful_plates/ui/pages/live_orders/live_orders_controller.dart';
import 'package:soulful_plates/ui/pages/menu_list/menu_list_controller.dart';
import 'package:soulful_plates/ui/pages/transactions/transactions_controller.dart';
import 'package:soulful_plates/ui/pages/wishlist/wishlist_controller.dart';

import '../order_history_buyer/order_history_buyer_controller.dart';
import '../profile/profile_controller.dart';
import '../settings/settings_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => WishlistController());
    Get.lazyPut(() => OrderHistoryBuyerController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => HomeSellerController());
    Get.lazyPut(() => MenuListController());
    Get.lazyPut(() => LiveOrdersController());
    Get.lazyPut(() => TransactionsController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => SettingsController());
  }
}
