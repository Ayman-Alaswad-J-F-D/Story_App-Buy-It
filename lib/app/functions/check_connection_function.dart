import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> hasConnection() async {
  return !await _checkConnection()
      ? await Future<bool>.delayed(
          const Duration(seconds: 2),
          () => false,
        )
      : true;
}

Future<bool> _checkConnection() async =>
    await InternetConnectionChecker().hasConnection;
