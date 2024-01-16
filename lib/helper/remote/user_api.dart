import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:store_app/app/constants/constants.dart';

class UserApi {
  const UserApi();

  static Future<dynamic> get({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    log('url = $url\ntoken = $token');
    final Map<String, String> headers = {'lang': lang};
    if (token != null) headers.addAll({'Authorization': token});

    final http.Response response = await http.get(
      Uri.parse("$baseUrlUsers/$url"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      log(response.body, name: "Response GET data");
      return jsonDecode(response.body);
    } else {
      log("status code ${response.statusCode}", name: "Error");
      throw Exception(
        "There is problem in status code ${response.statusCode}",
      );
    }
  }

  static Future<dynamic> post({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    String lang = 'en',
    String? token,
  }) async {
    log('url = $url\nbody = $body\ntoken = $token');
    final Map<String, String> headers = {'lang': lang};
    if (token != null) headers.addAll({'Authorization': token});

    final http.Response response = await http.post(
      Uri.parse("$baseUrlUsers/$url"),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      log(response.body, name: "Response POST data");
      return jsonDecode(response.body);
    } else {
      log("status code ${response.statusCode}", name: "Error");
      throw Exception(
        "There is problem in status code ${response.statusCode} with body ${jsonDecode(response.body)}",
      );
    }
  }

  static Future<dynamic> put({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    String lang = 'en',
    String? token,
  }) async {
    log('url = $url\n body = $body\n token = $token');
    final Map<String, String> headers = {'lang': lang};
    if (token != null) headers.addAll({'Authorization': token});

    final http.Response response = await http.put(
      Uri.parse("$baseUrlUsers/$url"),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      log(response.body, name: "Response PUT data");
      return jsonDecode(response.body);
    } else {
      log("status code ${response.statusCode}", name: "Error");
      throw Exception(
        "There is problem in status code ${response.statusCode} with body ${jsonDecode(response.body)}",
      );
    }
  }
}
