import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:martify/utils/http/exceptions/app_exceptions.dart';
import 'package:martify/utils/http/network/base_api_services.dart';

class NetworkApiSevices extends BaseApiServices {
  // GET API
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponce;
    try {
      final responce =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      jsonResponce = returnResponse(responce);
    } on SocketException {
      throw NoInternetException("");
    } on TimeoutException {
      throw RequestTimeOutException("");
    }
    return jsonResponce;
  }

// POST API
  @override
  Future<dynamic> postApi(String url, var data) async {
    dynamic jsonResponce;
    try {
      final responce = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 15));
      jsonResponce = returnResponse(responce);
    } on SocketException {
      throw NoInternetException("");
    } on TimeoutException {
      throw RequestTimeOutException("");
    }
    return jsonResponce;
  }

  @override
  // DELETE API
  Future<dynamic> deleteApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 15));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException("No Internet Connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request Timed Out");
    }
    return jsonResponse;
  }

  // PUT API
  @override
  Future<dynamic> putApi(String url, var data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .put(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 15));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException("No Internet Connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request Timed Out");
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
      case 403:
        throw UnauthorisedException();
      case 404:
        throw FetchDataException(
            'Not found: ${response.statusCode.toString()}');
      case 500:
      case 502:
      case 503:
      case 504:
        throw FetchDataException(
            'Error communicating with server! ${response.statusCode.toString()}');
      default:
        throw FetchDataException(
            'Unexpected error: ${response.statusCode.toString()}');
    }
  }
}
