/// Here we define a [NetworkService] contract using abstraction
/// for the sake of [simplicity] we are adding get and post behavior.

abstract class NetworkService {
  const NetworkService();

  Future<dynamic> get(String url, {Map<String, String> headers, String token});

  Future<dynamic> post(String url, dynamic body, {String token});

  Future<dynamic> put(
    String url,
    dynamic quary,
    dynamic body, {
    String token,
  });
}
