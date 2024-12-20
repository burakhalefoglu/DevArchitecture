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

    try {
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

      String reply = await response.transform(utf8.decoder).join();

      await _handleError(response.statusCode, reply);

      var decodedJson = jsonDecode(reply);

      if (decodedJson is String) {
        return {"message": decodedJson};
      }
      if (decodedJson is Map<String, dynamic>) {
        return decodedJson;
      } else if (decodedJson is List) {
        List<Map<String, dynamic>> list =
            decodedJson.map((e) => e as Map<String, dynamic>).toList();
        return {"data": list};
      }
      return decodedJson;
    } finally {
      httpClient.close();
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    try {
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

      String reply = await response.transform(utf8.decoder).join();

      await _handleError(response.statusCode, reply);

      var decodedJson = jsonDecode(reply);
      if (decodedJson is String) {
        return {"message": decodedJson};
      }
      if (decodedJson is Map<String, dynamic>) {
        return decodedJson;
      } else if (decodedJson is List) {
        List<Map<String, dynamic>> list =
            decodedJson.map((e) => e as Map<String, dynamic>).toList();
        return {"data": list};
      }
      return {"response": decodedJson};
    } finally {
      httpClient.close();
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    try {
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

      String reply = await response.transform(utf8.decoder).join();

      await _handleError(response.statusCode, reply);

      var decodedJson = jsonDecode(reply);
      if (decodedJson is String) {
        return {"message": decodedJson};
      }
      if (decodedJson is Map<String, dynamic>) {
        return decodedJson;
      } else if (decodedJson is List) {
        List<Map<String, dynamic>> list =
            decodedJson.map((e) => e as Map<String, dynamic>).toList();
        return {"data": list};
      }
      return decodedJson;
    } finally {
      httpClient.close();
    }
  }

  @override
  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> body) async {
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    try {
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

      String reply = await response.transform(utf8.decoder).join();

      await _handleError(response.statusCode, reply);

      var decodedJson = jsonDecode(reply);
      if (decodedJson is String) {
        return {"message": decodedJson};
      }
      if (decodedJson is Map<String, dynamic>) {
        return decodedJson;
      } else if (decodedJson is List) {
        List<Map<String, dynamic>> list =
            decodedJson.map((e) => e as Map<String, dynamic>).toList();
        return {"data": list};
      }
      return decodedJson;
    } finally {
      httpClient.close();
    }
  }

  Future<Map<String, dynamic>?> _handleError(
      int statusCode, String reply) async {
    if (statusCode == 400) {
      throw BadRequestException(reply);
    }
    if (statusCode == 401) {
      throw UnauthorizedException(reply);
    }
    if (statusCode == 403) {
      throw ForbiddenException(reply);
    }
    if (statusCode == 500) {
      throw InternalServerErrorException(reply);
    }
    return null;
  }
}
