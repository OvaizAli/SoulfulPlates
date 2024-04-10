import 'dart:async'; //For StreamController/Stream
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../routing/route_names.dart';

class ConnectionStatus {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatus _singleton = ConnectionStatus._internal();

  ConnectionStatus._internal() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  factory ConnectionStatus() {
    return _singleton;
  }

  //This tracks the current connection status
  bool hasConnection = true;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate

  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  static isInternetAvailable() async {
    return await InternetConnectionChecker().hasConnection;
  }

  static bool isInternetPageVisible = false;

  //The test to actually see if there is a connection
  Future<bool> checkConnection({bool fromInternetScreen = false}) async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // if (await InternetConnectionChecker().hasConnection) {
        hasConnection = true;
        if (isInternetPageVisible) {
          Get.back();
        }
      } else {
        hasConnection = false;
        if (!fromInternetScreen) {
          Get.toNamed(internetPageViewRoute);
        }
      }
    } on SocketException catch (_) {
      hasConnection = false;
      if (!fromInternetScreen) {
        Get.toNamed(internetPageViewRoute);
      }
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
