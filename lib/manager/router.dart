import 'package:flutter/material.dart';
import 'package:flutter_tab_button/home/home_activity.dart';
import 'package:flutter_tab_button/home/home_warning_message_activity.dart';
import 'package:flutter_tab_button/login/login_activity.dart';
import 'package:flutter_tab_button/main_tab_activity.dart';
import 'package:flutter_tab_button/mine/mine_activity.dart';
import 'package:flutter_tab_button/patient/patient_activity.dart';
//路由管理类
class RouterManager{
  static final main = '/main';//主页
  //首页
  static final home = '/home';
  //预警
  static final homeWarning = '/warning';
  //----------------------------------------
  //患者
  static final patient = '/paiient';
  //我的
  static final mine = '/mine';
  //登陆
  static final login = '/login';

  static final routers = <String,WidgetBuilder>{
    RouterManager.main:(_) =>MainActivity(),
    RouterManager.home:(_) =>HomeActivity(),
    RouterManager.patient:(_) =>PatientActivity(),
    RouterManager.mine:(_) =>MineActivity(),
    RouterManager.login:(_) =>LoginActivity(),
    RouterManager.homeWarning:(_) =>TheWarningMessageActivity(),
  };


}