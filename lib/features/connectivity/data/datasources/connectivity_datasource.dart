import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class ConnectivityDataSource {
  Stream<bool> getConnectionStatus();
}

@LazySingleton(as: ConnectivityDataSource)
class ConnectivityDataSourceImpl implements ConnectivityDataSource {
  const ConnectivityDataSourceImpl(this._connectivity);
  final Connectivity _connectivity;

  @override
  Stream<bool> getConnectionStatus() async* {
    yield* _connectivity.onConnectivityChanged.map<bool>((event) {
      return event == ConnectivityResult.wifi ||
              event == ConnectivityResult.mobile ||
              event == ConnectivityResult.ethernet
          ? true
          : false;
    }).handleError((Object error) {
        log(error.toString());
      return false;
    });
  }
}
