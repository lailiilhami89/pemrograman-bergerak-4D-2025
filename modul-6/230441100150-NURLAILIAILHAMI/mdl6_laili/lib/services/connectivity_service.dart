import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Stream<bool> get connectionStream async* {
    await for (final result in Connectivity().onConnectivityChanged) {
      yield result != ConnectivityResult.none;
    }
  }
}
