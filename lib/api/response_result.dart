import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';

enum HttpStatus {
  ok,
  faile,
  outTime
}

/// 网络返回结果类
class ResponseResult {

  ResponseResult({this.response});

  HttpStatus get status {
    if(null!=response){
      switch(response.statusCode){
        case 200:
          print('网络数据:'+response.body);
          return HttpStatus.ok;
        default:
          return HttpStatus.faile;
      }
    }else{
      return HttpStatus.outTime;
    }
  }

  Response response;
  // json
  Map get jsonResult {
    return json.decode(response.body);
  }
  String get body => response.body; // 这个可以用来做缓存
}