import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/ui/pages/cart_order_success/cart_order_success_binding.dart';
import 'package:soulful_plates/ui/pages/cart_order_success/cart_order_success_screen.dart';
import 'package:soulful_plates/ui/pages/cart_payment/cart_payment_binding.dart';
import 'package:soulful_plates/ui/pages/cart_payment/cart_payment_screen.dart';
import 'package:soulful_plates/ui/pages/dashboard/dashboard_binding.dart';
import 'package:soulful_plates/ui/pages/dashboard/dashboard_screen.dart';
import 'package:soulful_plates/ui/pages/edit_location/edit_location_binding.dart';
import 'package:soulful_plates/ui/pages/edit_location/edit_location_screen.dart';
import 'package:soulful_plates/ui/pages/forgot_password/forgot_password_binding.dart';
import 'package:soulful_plates/ui/pages/forgot_password/forgot_password_screen.dart';
import 'package:soulful_plates/ui/pages/introduction_screen.dart';
import 'package:soulful_plates/ui/pages/login/login_binding.dart';
import 'package:soulful_plates/ui/pages/login/login_screen.dart';
import 'package:soulful_plates/ui/pages/menu_category/menu_category_binding.dart';
import 'package:soulful_plates/ui/pages/menu_category/menu_category_screen.dart';
import 'package:soulful_plates/ui/pages/order_detail/order_detail_binding.dart';
import 'package:soulful_plates/ui/pages/order_detail/order_detail_screen.dart';
import 'package:soulful_plates/ui/pages/order_history_buyer/order_history_buyer_binding.dart';
import 'package:soulful_plates/ui/pages/order_history_buyer/order_history_buyer_screen.dart';
import 'package:soulful_plates/ui/pages/profile/profile_binding.dart';
import 'package:soulful_plates/ui/pages/profile/profile_screen.dart';
import 'package:soulful_plates/ui/pages/rating_review/rating_review_binding.dart';
import 'package:soulful_plates/ui/pages/rating_review/rating_review_screen.dart';
import 'package:soulful_plates/ui/pages/restaurant_detail/restaurant_detail_binding.dart';
import 'package:soulful_plates/ui/pages/restaurant_detail/restaurant_detail_screen.dart';
import 'package:soulful_plates/ui/pages/saved_location/saved_location_binding.dart';
import 'package:soulful_plates/ui/pages/saved_location/saved_location_screen.dart';
import 'package:soulful_plates/ui/pages/sign_up/sign_up_binding.dart';
import 'package:soulful_plates/ui/pages/sign_up/sign_up_screen.dart';
import 'package:soulful_plates/ui/pages/splash_screen.dart';
import 'package:soulful_plates/ui/pages/transactions/transactions_binding.dart';
import 'package:soulful_plates/ui/pages/transactions/transactions_screen.dart';
import 'package:soulful_plates/ui/pages/view_cart/view_cart_binding.dart';
import 'package:soulful_plates/ui/pages/view_cart/view_cart_screen.dart';
import 'package:soulful_plates/ui/pages/wishlist/wishlist_binding.dart';
import 'package:soulful_plates/ui/pages/wishlist/wishlist_screen.dart';

import '../ui/pages/create_menu/create_menu_binding.dart';
import '../ui/pages/create_menu/create_menu_screen.dart';
import '../ui/pages/home_seller/home_seller_binding.dart';
import '../ui/pages/home_seller/home_seller_screen.dart';
import '../ui/pages/internet_page/internet_page_view.dart';
import '../ui/pages/live_orders/live_orders_binding.dart';
import '../ui/pages/live_orders/live_orders_screen.dart';
import '../ui/pages/menu_list/menu_list_binding.dart';
import '../ui/pages/menu_list/menu_list_screen.dart';
import '../ui/pages/order_history_seller/order_history_seller_binding.dart';
import '../ui/pages/order_history_seller/order_history_seller_screen.dart';
import '../ui/pages/payout_seller/payout_seller_binding.dart';
import '../ui/pages/payout_seller/payout_seller_screen.dart';
import '../ui/pages/store_details/store_details_binding.dart';
import '../ui/pages/store_details/store_details_screen.dart';
import '../ui/pages/transaction_seller/transaction_seller_binding.dart';
import '../ui/pages/transaction_seller/transaction_seller_screen.dart';
import '../ui/pages/web_view/web_view_screen.dart';
import 'route_names.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case internetPageViewRoute:
      return getPageRoutes(
        routeName: internetPageViewRoute,
        settings: settings,
        page: () => const InternetPageView(),
      );

    case splashViewRoute:
      return getPageRoutes(
        routeName: splashViewRoute,
        settings: settings,
        page: () => const SplashScreen(),
      );

    case introductionViewRoute:
      return getPageRoutes(
        routeName: introductionViewRoute,
        settings: settings,
        page: () => const IntroductionViewPage(),
      );

    case loginViewRoute:
      return getPageRoutes(
        routeName: loginViewRoute,
        settings: settings,
        bindings: [LoginBinding()],
        page: () => LoginScreen(),
      );
    case signUpViewRoute:
      return getPageRoutes(
        routeName: signUpViewRoute,
        settings: settings,
        bindings: [SignUpBinding()],
        page: () => SignUpScreen(),
      );
    case forgotPasswordPageViewRoute:
      return getPageRoutes(
        routeName: forgotPasswordPageViewRoute,
        settings: settings,
        bindings: [ForgotPasswordBinding()],
        page: () => ForgotPasswordScreen(),
      );

    case dashboardViewRoute:
      return getPageRoutes(
        routeName: dashboardViewRoute,
        settings: settings,
        bindings: [DashboardBinding()],
        page: () => DashboardScreen(),
      );

    case restaurantDetailViewRoute:
      return getPageRoutes(
        routeName: restaurantDetailViewRoute,
        settings: settings,
        bindings: [RestaurantDetailBinding()],
        page: () => RestaurantDetailScreen(),
      );

    case viewCartViewRoute:
      return getPageRoutes(
        routeName: viewCartViewRoute,
        settings: settings,
        bindings: [ViewCartBinding()],
        page: () => ViewCartScreen(),
      );

    //buyer - to do
    case cartPaymentViewRoute:
      return getPageRoutes(
        routeName: cartPaymentViewRoute,
        settings: settings,
        bindings: [CartPaymentBinding()],
        page: () => CartPaymentScreen(),
      );

    case profileViewRoute:
      return getPageRoutes(
        routeName: profileViewRoute,
        settings: settings,
        bindings: [ProfileBinding()],
        page: () => const ProfileScreen(),
      );

    case orderSuccessViewRoute:
      return getPageRoutes(
        routeName: orderSuccessViewRoute,
        settings: settings,
        bindings: [CartOrderSuccessBinding()],
        page: () => CartOrderSuccessScreen(),
      );

    case wishListViewRoute:
      return getPageRoutes(
        routeName: wishListViewRoute,
        settings: settings,
        bindings: [WishlistBinding()],
        page: () => WishlistScreen(),
      );
    case orderHistoryViewRoute:
      return getPageRoutes(
        routeName: orderHistoryViewRoute,
        settings: settings,
        bindings: [OrderHistoryBuyerBinding()],
        page: () => OrderHistoryBuyerScreen(),
      );

    case orderDetailViewRoute:
      return getPageRoutes(
        routeName: orderDetailViewRoute,
        settings: settings,
        bindings: [OrderDetailBinding()],
        page: () => OrderDetailScreen(),
      );

    case ratingReviewViewRoute:
      return getPageRoutes(
        routeName: ratingReviewViewRoute,
        settings: settings,
        bindings: [RatingReviewBinding()],
        page: () => RatingReviewScreen(),
      );

    case locationListViewRoute:
      return getPageRoutes(
        routeName: locationListViewRoute,
        settings: settings,
        bindings: [SavedLocationBinding()],
        page: () => SavedLocationScreen(),
      );

    case editLocationViewRoute:
      return getPageRoutes(
        routeName: editLocationViewRoute,
        settings: settings,
        bindings: [EditLocationBinding()],
        page: () => EditLocationScreen(),
      );

    case webViewRoute:
      return getPageRoutes(
        routeName: webViewRoute,
        settings: settings,
        page: () => const WebViewScreen(),
      );

    case storeDetailsViewRoute:
      return getPageRoutes(
        routeName: storeDetailsViewRoute,
        settings: settings,
        bindings: [StoreDetailsBinding()],
        page: () => StoreDetailsScreen(),
      );

    case homeSellerViewRoute:
      return getPageRoutes(
        routeName: homeSellerViewRoute,
        settings: settings,
        bindings: [HomeSellerBinding()],
        page: () => HomeSellerScreen(),
      );

    case liveOrdersViewRoute:
      return getPageRoutes(
        routeName: liveOrdersViewRoute,
        settings: settings,
        bindings: [LiveOrdersBinding()],
        page: () => const LiveOrdersScreen(),
      );

    case menuViewRoute:
      return getPageRoutes(
        routeName: menuViewRoute,
        settings: settings,
        bindings: [MenuListBinding()],
        page: () => MenuListScreen(),
      );

    case menuCategoryViewRoute:
      return getPageRoutes(
        routeName: menuCategoryViewRoute,
        settings: settings,
        bindings: [MenuCategoryBinding()],
        page: () => MenuCategoryScreen(),
      );

    case createMenuViewRoute:
      return getPageRoutes(
        routeName: createMenuViewRoute,
        settings: settings,
        bindings: [CreateMenuBinding()],
        page: () => CreateMenuScreen(),
      );

    case orderHistorySellerViewRoute:
      return getPageRoutes(
        routeName: orderHistorySellerViewRoute,
        settings: settings,
        bindings: [OrderHistorySellerBinding()],
        page: () => OrderHistorySellerScreen(),
      );

    case transactionHistorySellerViewRoute:
      return getPageRoutes(
        routeName: transactionHistorySellerViewRoute,
        settings: settings,
        bindings: [TransactionSellerBinding()],
        page: () => TransactionSellerScreen(),
      );

    case transactionHistoryViewRoute:
      return getPageRoutes(
        routeName: transactionHistoryViewRoute,
        settings: settings,
        bindings: [TransactionsBinding()],
        page: () => TransactionsScreen(),
      );

    case payoutHistoryViewRoute:
      return getPageRoutes(
        routeName: payoutHistoryViewRoute,
        settings: settings,
        bindings: [PayoutSellerBinding()],
        page: () => PayoutSellerScreen(),
      );
  }
  return null;
}

/// Use This Method To Call Pages
PageRoute getPageRoutes(
    {required String routeName,
    required Function page,
    required RouteSettings settings,
    List<Bindings>? bindings,
    Transition? transition,
    Duration? transitionDuration}) {
  return GetPageRoute(
    transition: transition,
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    page: () => SafeArea(
      child: page(),
      bottom: false,
      top: false,
    ),
    // transition: Transition.rightToLeft,
    routeName: routeName,
    settings: settings,
    bindings: bindings,
  );
}
