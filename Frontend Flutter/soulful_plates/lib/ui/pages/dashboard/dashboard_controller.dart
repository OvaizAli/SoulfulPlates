import 'package:flutter/material.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/ui/pages/home/home_screen.dart';
import 'package:soulful_plates/ui/pages/home_seller/home_seller_screen.dart';
import 'package:soulful_plates/ui/pages/live_orders/live_orders_screen.dart';
import 'package:soulful_plates/ui/pages/menu_list/menu_list_screen.dart';
import 'package:soulful_plates/ui/pages/order_history_buyer/order_history_buyer_screen.dart';
import 'package:soulful_plates/ui/pages/profile/profile_screen.dart';
import 'package:soulful_plates/ui/pages/settings/settings_screen.dart';
import 'package:soulful_plates/ui/pages/wishlist/wishlist_screen.dart';

import '../../../constants/app_colors.dart';
import '../../../controller/base_controller.dart';

class DashboardController extends BaseController {
  int currentIndex = 0;

  List pages = AppSingleton.isBuyer()
      ? [
          const HomeScreen(),
          const WishlistScreen(),
          const OrderHistoryBuyerScreen(),
          const SettingsScreen()
        ]
      : [
          const HomeSellerScreen(),
          const LiveOrdersScreen(),
          const MenuListScreen(),
          const ProfileScreen(),
          const SettingsScreen(),
        ];

  List<BottomNavigationBarItem> buyersItem = const [
    BottomNavigationBarItem(
        label: "Home",
        activeIcon: Icon(Icons.home_outlined, color: AppColor.primaryColor),
        icon: Icon(Icons.home_outlined, color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "Wish List",
        activeIcon:
            Icon(Icons.favorite_outline_rounded, color: AppColor.primaryColor),
        icon: Icon(Icons.favorite_outline_rounded,
            color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "Orders",
        activeIcon: Icon(Icons.history_outlined, color: AppColor.primaryColor),
        icon: Icon(Icons.history_outlined, color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "Profile",
        activeIcon: Icon(Icons.person, color: AppColor.primaryColor),
        icon: Icon(Icons.person, color: AppColor.blackTextColor)),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        label: "Home",
        activeIcon: Icon(Icons.home_outlined, color: AppColor.primaryColor),
        icon: Icon(Icons.home_outlined, color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "Orders",
        activeIcon: Icon(Icons.print_outlined, color: AppColor.primaryColor),
        icon: Icon(Icons.print_outlined, color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "Menu",
        activeIcon:
            Icon(Icons.menu_book_outlined, color: AppColor.primaryColor),
        icon: Icon(Icons.menu_book_outlined, color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "Profile",
        activeIcon: Icon(Icons.person, color: AppColor.primaryColor),
        icon: Icon(Icons.person, color: AppColor.blackTextColor)),
    BottomNavigationBarItem(
        label: "More",
        activeIcon:
            Icon(Icons.more_horiz_outlined, color: AppColor.primaryColor),
        icon: Icon(
          Icons.more_horiz_outlined,
          color: AppColor.blackTextColor,
        )),
  ];

  void changeTab(int index) {
    currentIndex = index;
    update();
  }
}
