import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'http_interceptor.dart';
import 'i_http.dart';

class HttpDartIo implements IHttp {
  late IHttpInterceptor interceptor;
  static final HttpDartIo _singleton = HttpDartIo._internal();

  factory HttpDartIo(IHttpInterceptor interceptor) {
    _singleton.interceptor = interceptor;
    return _singleton;
  }
  HttpDartIo._internal();

  @override
  Future<Map<String, dynamic>> get(url) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));

    var intercepts = await interceptor.interceptJson();
    for (var key in intercepts.keys) {
      request.headers.set(key, intercepts[key]);
    }
    HttpClientResponse response = await request.close();
    if (kDebugMode) {
      print(url);
      print(response.statusCode);
    }
    if (response.statusCode == 400) {
      httpClient.close();
      throw Exception("400 Bad Request");
    }
    if (response.statusCode == 401) {
      httpClient.close();
      throw Exception("401 Unauthorized");
    }
    if (response.statusCode == 403) {
      httpClient.close();
      throw Exception("403 Forbidden");
    }
    if (response.statusCode == 500) {
      httpClient.close();
      throw Exception("500 Internal Server Error");
    }

    String reply = await response.transform(utf8.decoder).join();
    var decodedJson = jsonDecode(reply);
    httpClient.close();
    if (decodedJson is Map<String, dynamic>) {
      Map<String, dynamic> map = decodedJson;
      return map;
    } else if (decodedJson is List) {
      List<Map<String, dynamic>> list =
          decodedJson.map((e) => e as Map<String, dynamic>).toList();
      return {"data": list};
    }
    return decodedJson;
  }

  @override
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    var intercepts = await interceptor.interceptJson();
    for (var key in intercepts.keys) {
      request.headers.set(key, intercepts[key]);
    }

    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    if (kDebugMode) {
      print(url);
      print(response.statusCode);
    }
    if (response.statusCode == 400) {
      httpClient.close();
      throw Exception("400 Bad Request");
    }
    if (response.statusCode == 401) {
      httpClient.close();
      throw Exception("401 Unauthorized");
    }
    if (response.statusCode == 403) {
      httpClient.close();
      throw Exception("403 Forbidden");
    }
    if (response.statusCode == 500) {
      httpClient.close();
      throw Exception("500 Internal Server Error");
    }

    String reply = await response.transform(utf8.decoder).join();
    var decodedJson = jsonDecode(reply);
    httpClient.close();
    if (decodedJson is Map<String, dynamic>) {
      Map<String, dynamic> map = decodedJson;
      return map;
    } else if (decodedJson is List) {
      List<Map<String, dynamic>> list =
          decodedJson.map((e) => e as Map<String, dynamic>).toList();
      return {"data": list};
    } else {
      return {"response": decodedJson};
    }
  }

  @override
  Future<void> delete(String url) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(url));

    var intercepts = await interceptor.interceptJson();
    for (var key in intercepts.keys) {
      request.headers.set(key, intercepts[key]);
    }
    HttpClientResponse response = await request.close();
    if (kDebugMode) {
      print(url);
      print(response.statusCode);
    }
    if (response.statusCode == 400) {
      httpClient.close();
      throw Exception("400 Bad Request");
    }
    if (response.statusCode == 401) {
      httpClient.close();
      throw Exception("401 Unauthorized");
    }
    if (response.statusCode == 403) {
      httpClient.close();
      throw Exception("403 Forbidden");
    }
    if (response.statusCode == 500) {
      httpClient.close();
      throw Exception("500 Internal Server Error");
    }
  }

  @override
  Future<void> put(String url, Map<String, dynamic> body) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    HttpClientRequest request = await httpClient.putUrl(Uri.parse(url));
    var intercepts = await interceptor.interceptJson();
    for (var key in intercepts.keys) {
      request.headers.set(key, intercepts[key]);
    }

    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    if (kDebugMode) {
      print(url);
      print(response.statusCode);
    }
    if (response.statusCode == 400) {
      httpClient.close();
      throw Exception("400 Bad Request");
    }
    if (response.statusCode == 401) {
      httpClient.close();
      throw Exception("401 Unauthorized");
    }
    if (response.statusCode == 403) {
      httpClient.close();
      throw Exception("403 Forbidden");
    }
    if (response.statusCode == 500) {
      httpClient.close();
      throw Exception("500 Internal Server Error");
    }
    httpClient.close();
  }
}