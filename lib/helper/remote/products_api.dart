import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../network/network_service.dart';

class ProductsApi implements NetworkService {
  const ProductsApi();

  @override
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    String? token,
  }) async {
    if (token != null) headers?.addAll({"Authorization": "Bearer $token"});
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("There is problem in status code ${response.statusCode}");
    }
  }

  @override
  Future<dynamic> post(String url, dynamic body, {String? token}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    if (token != null) headers.addAll({"Authorization": "Bearer $token"});
    debugPrint("url = $url\n body = $body\n token = $token");
    final http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "There is problem in status code ${response.statusCode} with body ${jsonDecode(response.body)}",
      );
    }
  }

  @override
  Future<Map<String, dynamic>?> put(
    String url,
    dynamic data,
    dynamic body, {
    String? token,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    if (token != null) headers.addAll({"Authorization": "Bearer $token"});
    debugPrint("url = $url\n body = $body\n token = $token");
    final http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "There is problem in status code ${response.statusCode} with body ${jsonDecode(response.body)}",
      );
    }
  }
}
