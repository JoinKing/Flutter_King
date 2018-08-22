import 'package:flutter/material.dart';
import 'package:flutter_tab_button/home/home_activity.dart';
import 'package:flutter_tab_button/login/login_activity.dart';
import 'package:flutter_tab_button/main_tab_activity.dart';
import 'package:flutter_tab_button/manager/router.dart';
import 'package:flutter_tab_button/theme/app_theme.dart';
import 'package:flutter_tab_button/widget/BoxDecoration.dart';
import 'package:flutter_tab_button/widget/edittext.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      title: '健康',
      theme:AppTheme.themeData,
//      home: new MainActivity(),
//      home: new EditText(),
      home: new LoginActivity(),
//      home: new HomeActivity(),
//      home: new BoxDemo(),//盒子案例
      routes: RouterManager.routers,
    );
  }
}
