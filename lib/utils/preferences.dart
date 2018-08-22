import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  //保存数据
  static savaData(String type, String data) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(type, data);
  }

  //读取数据
  static Future<String> readData(String type) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(type);
  }

  //json转map
  static Map getMap(String jsonString)  {
    Map map = null;
    if (!jsonString.isEmpty) {
      map = json.decode(jsonString);
      return map;
    } else {
      return null;
    }
  }

  //删除数据
  static deleteData(String type) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(type);
  }

}