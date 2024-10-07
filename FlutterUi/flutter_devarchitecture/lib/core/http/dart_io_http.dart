import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_devarchitecture/core/helpers/exceptions.dart';

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
    await _handleError(response, httpClient);

    String reply = await response.transform(utf8.decoder).join();
    var decodedJson = jsonDecode(reply);
    httpClient.close();
    if (decodedJson is String) {
      return {"message": decodedJson};
    }
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
    await _handleError(response, httpClient);
    String reply = await response.transform(utf8.decoder).join();
    var decodedJson = jsonDecode(reply);
    httpClient.close();
    if (decodedJson is String) {
      return {"message": decodedJson};
    }
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
  Future<Map<String, dynamic>> delete(String url) async {
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
    await _handleError(response, httpClient);
    httpClient.close();
    String reply = await response.transform(utf8.decoder).join();
    var decodedJson = jsonDecode(reply);
    if (decodedJson is String) {
      return {"message": decodedJson};
    }
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
  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> body) async {
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
    await _handleError(response, httpClient);
    httpClient.close();
    String reply = await response.transform(utf8.decoder).join();
    var decodedJson = jsonDecode(reply);
    if (decodedJson is String) {
      return {"message": decodedJson};
    }
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

  Future<Map<String, dynamic>?> _handleError(
      HttpClientResponse response, HttpClient httpClient) async {
    String reply = await response.transform(utf8.decoder).join();
    if (response.statusCode == 400) {
      httpClient.close();
      throw BadRequestException(reply);
    }
    if (response.statusCode == 401) {
      httpClient.close();
      throw UnauthorizedException(reply);
    }
    if (response.statusCode == 403) {
      httpClient.close();

      throw ForbiddenException(reply);
    }
    if (response.statusCode == 500) {
      httpClient.close();
      throw InternalServerErrorException(reply);
    }
    return null;
  }
}
