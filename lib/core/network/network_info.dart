import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  // Check if the user can reach a specific host
  Future<AddressCheckResult> canReachHost(String host) async {
    return await connectionChecker.isHostReachable(
      AddressCheckOption(

        timeout: const Duration(seconds: 5), uri: Uri.parse(host),
      ),
    );
  }

  // Listen to connection changes
  Stream<InternetConnectionStatus> get onStatusChange =>
      connectionChecker.onStatusChange;

  // Get current connection status
  Future<InternetConnectionStatus> get connectionStatus async {
    return await connectionChecker.connectionStatus;
  }
}