import 'dart:async';

import 'package:config/config.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'model/profile/user_profile.dart';
import 'utils/connection_status.dart';
import 'utils/shared_prefs.dart';

class AppSingleton {
  static final AppSingleton _singleton = AppSingleton._internal();

  static int storeId = 1;

  PackageInfo? packageInfo;

  factory AppSingleton() {
    return _singleton;
  }

  AppSingleton._internal() {
    ConnectionStatus connectionStatusSingleton = ConnectionStatus();
    connectionStatus = connectionStatusSingleton;
    initThings();
  }

  static isBuyer() {
    return role == 'buyer';
  }

  initThings() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  late ConnectionStatus connectionStatus;

  static UserProfile? loggedInUserProfile = UserProfile.fromRawJson(
    UserPreference.getValue(key: SharedPrefKey.userProfileData.name) ?? "",
  );

  static Future<String> getUserId() async {
    return loggedInUserProfile?.id ?? '';
  }
}
