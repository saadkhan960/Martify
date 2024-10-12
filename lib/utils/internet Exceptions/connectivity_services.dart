// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:martify/utils/popups/snackbar_popups.dart';

// class ConnectivityService {
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
//   final StreamController<ConnectivityResult> _connectivityStreamController =
//       StreamController<ConnectivityResult>.broadcast();

//   final BuildContext context;

// ConnectivityService(this.context) {
//   _connectivitySubscription = _connectivity.onConnectivityChanged
//       .listen((List<ConnectivityResult> results) {
//     // Handle multiple results if needed
//     for (ConnectivityResult result in results) {
//       _connectivityStreamController.add(result);
//       if (result == ConnectivityResult.none) {
//         SnackbarService.showError(
//             context: context, message: "No Internet Connect");
//       }
//       // if (result == ConnectivityResult.wifi) {
//       //   SnackbarService.showSucccess(
//       //       context: context, message: "Internet Connected");
//       // }
//       // if (result == ConnectivityResult.mobile) {
//       //   SnackbarService.showSucccess(
//       //       context: context, message: "Internet Connected");
//       // }
//       // if (result == ConnectivityResult.vpn) {
//       //   SnackbarService.showSucccess(
//       //       context: context, message: "Internet Connected");
//       // }
//     }
//   });
// }

//   /// Stream for live connectivity updates
//   Stream<ConnectivityResult> get connectivityStream =>
//       _connectivityStreamController.stream;

//   /// Manual check for the current connectivity status
//   Future<bool> checkConnectivity() async {
//     List<ConnectivityResult> results = await _connectivity.checkConnectivity();
//     if (results.isEmpty) {
//       // Handle case where connectivity check fails
//       return false; // Or throw an exception depending on your needs
//     } else {
//       ConnectivityResult result = results.first;
//       return result == ConnectivityResult.mobile ||
//           result == ConnectivityResult.wifi;
//     }
//   }

//   /// Close the connectivity stream to avoid memory leaks
//   void dispose() {
//     _connectivitySubscription?.cancel();
//     _connectivityStreamController.close();
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final StreamController<ConnectivityResult> _connectivityStreamController =
      StreamController<ConnectivityResult>.broadcast();

  final BuildContext context;
  bool _initialCheckDone = false; // Flag to track the initial connection check

  ConnectivityService(this.context) {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      for (ConnectivityResult result in results) {
        _connectivityStreamController.add(result);
        if (!_initialCheckDone) {
          _initialCheckDone = true;
          if (result == ConnectivityResult.none) {
            SnackbarService.showError(
                context: context, message: "No Internet Connection");
          }
        } else {
          if (result == ConnectivityResult.none) {
            SnackbarService.showError(
                context: context, message: "No Internet Connection");
          } else {
            final bool hasInternet = await _hasInternetConnection();
            if (!hasInternet) {
              SnackbarService.showError(
                  context: context, message: "No Internet Access");
            } else {
              SnackbarService.showSucccess(
                  context: context, message: "Internet Restored");
            }
          }
        }
      }
    });
  }

  /// Stream for live connectivity updates
  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityStreamController.stream;

  /// Manual check for the current connectivity status
  Future<bool> checkConnectivity() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return await _hasInternetConnection();
    }
  }

  /// Check if the internet is actually accessible by pinging a reliable server
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  /// Close the connectivity stream to avoid memory leaks
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivityStreamController.close();
  }
}
