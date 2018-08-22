import 'dart:async';
import 'package:flutter_tab_button/api/response_result.dart';
import 'package:http/http.dart' as http;

abstract class BaseApi {
  distanceTo(String other) => throw new UnimplementedError();

  static Future<ResponseResult> post(String uri, dynamic params) async {
    try {
      final response = await http.post(uri, headers: headers, body: params);
      ResponseResult result = ResponseResult(response: response);
      return result;
    } on Exception catch (e) {
      print('超时异常 details:\n $e');
      return new ResponseResult(response: null);
    }
  }

  static Map<String, String> headers = {
    "user-agent": "Android",
    "Content-Type": "application/json",
  };
}
