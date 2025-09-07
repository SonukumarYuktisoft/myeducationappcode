import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionValidator {
  Future<bool> check() async {
    // Check connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }

  Stream<bool> internetConnectionStream() async* {
    await for (final result in Connectivity().onConnectivityChanged) {
      if (result.contains(ConnectivityResult.none)) {
        yield false;
      } else {
        // Check actual internet
        try {
          final lookup = await InternetAddress.lookup('example.com');
          yield lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
        } catch (_) {
          yield false;
        }
      }
    }
  }
}