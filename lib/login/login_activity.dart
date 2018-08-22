import 'package:flutter/material.dart';
import 'package:flutter_tab_button/api/base_api.dart';
import 'package:flutter_tab_button/api/response_result.dart';
import 'package:flutter_tab_button/bean/login_model.dart';
import 'package:flutter_tab_button/manager/router.dart';
import 'package:flutter_tab_button/response/login_model.dart';
import 'package:flutter_tab_button/utils/preferences.dart';
import 'package:flutter_tab_button/utils/toast.dart';
import 'package:flutter_tab_button/utils/url.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';
import 'package:flutter_tab_button/values/strings.dart';
import 'package:flutter_tab_button/view/line.dart';
import 'package:flutter/cupertino.dart';

class LoginActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginUi();
  }
}

class LoginUi extends State<LoginActivity> {
  LoginModle loginModle = new LoginModle();

  //   phone 18230018402
  //   psd 123456
  TextEditingController _controllerPhone =
      TextEditingController(text: '18230018402'); //获取输入文本
  TextEditingController _controllerPassWord =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    TextStyle inputText = TextStyle(
//      letterSpacing: 10.0,//文字间距
      fontSize: Dimens.d16,
      color: MyColors.inputColor,
    );
    InputDecoration inputPhone = InputDecoration(
      counterStyle: TextStyle(
        fontSize: Dimens.d16,
        color: MyColors.inputColor,
      ),
      fillColor: Colors.white,
      border: InputBorder.none,
      filled: false,
      prefixIcon: new Image //prefixIcon在输入框左边设置本地资源图标
          .asset(
        //在输入框使用asset本地文件decoration属性使用new InputDecoration，不要使用最终变量
        MyIcon.inputPhone,
        width: Dimens.d25,
        height: Dimens.d18,
      ),
      hintText: Strings.inputPhpneNumber,
    );

    return Scaffold(
      body: new Builder(builder: (BuildContext context) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: Dimens.d80,
              left: Dimens.d50,
              right: Dimens.d50,
            ),
            child: new ListView(
              controller:
                  ScrollController(keepScrollOffset: false), //关闭Scroll滑动效果
              children: <Widget>[
                //第一个图标
                new Container(
                  child: Image.asset(
                    MyIcon.loge,
                    width: Dimens.d80,
                    height: Dimens.d70,
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(top: Dimens.d130),
                  child: new TextFormField(
                    //文本表单（常用的）
                    style: inputText,
                    controller: _controllerPhone,
                    keyboardType: TextInputType.phone,
                    decoration: inputPhone,
                  ),
                ),
                Lines(
                  color: Colors.grey[500],
                  height: 0.5,
                ),
                new Container(
                  padding: EdgeInsets.only(top: Dimens.d15),
                  child: new TextFormField(
                    //文本表单（常用的）
                    style: inputText,
                    obscureText: true,
                    controller: _controllerPassWord,
                    decoration: new InputDecoration(
                      counterStyle: TextStyle(
                          color: MyColors.inputColor, fontSize: Dimens.d16),
                      prefixIcon: new Image.asset(
                        //在输入框使用asset本地文件decoration属性使用new InputDecoration，不要使用最终变量
                        MyIcon.inputPsd,
                        width: Dimens.d25,
                        height: Dimens.d18,
                      ),
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      filled: false,
                      hintText: Strings.inputPhpnePassWord,
                    ),
                  ),
                ),
                Lines(
                  color: Colors.grey[500],
                  height: 0.5,
                ),
                new Container(
                  width: 200.0,
                  height: 95.0,
                  constraints:
                      new BoxConstraints.expand(width: 300.0, height: 98.0),
                  //设置按钮的大小
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      //让矩形四个角都变成圆角
                      const Radius.circular(80.0),
                    ),
                  ),
                  padding: EdgeInsets.only(top: Dimens.d45),
                  child: new GestureDetector(
                    child: new Material(
                      elevation: 3.0,
                      color: MyColors.btnLogin,
                      textStyle: TextStyle(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      child: new Container(
                        alignment: Alignment.center,
                        child: Text(
                          Strings.btnLogin,
                        ),
                      ),
                    ),
                    onTap: () {
                      loginModle.phoneNumber = _controllerPhone.text;
                      loginModle.phonePassWord = _controllerPassWord.text;
                      _login(loginModle, context);
                    },
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(top: Dimens.d123),
                  child: new Center(
                    child: new Text(
                      Strings.textForGetPsd,
                      style: TextStyle(
                          color: MyColors.tvBlur, fontSize: Dimens.d14),
                    ),
                  ),
                ),
              ],
            ));
      }),
    );
  }

  //登陆接口
  void _login(LoginModle loginModle, BuildContext context) async {
    Map<String, String> parameters = {
      "userName": loginModle.phoneNumber,
      "passWord": loginModle.phonePassWord,
      "userType": "1",
    };

    BaseApi.post(UrlUtils.LOGIN, parameters.toString()).then((response) async {
      if (response.status == HttpStatus.ok) {
        var user = LoginModel.fromJson(PreferencesUtils.getMap(response.body));
        if (user.code == Strings.state_success) {
          print(user.data);
          await PreferencesUtils.savaData(
              Strings.cache_login, response.body); //保存登陆数据
          await PreferencesUtils.savaData(
              Strings.cache_token, user.data.token); //token
          await PreferencesUtils.savaData(
              Strings.cache_phone, loginModle.phoneNumber); //手机号
          await PreferencesUtils.savaData(
              Strings.cache_psd, loginModle.phonePassWord); //密码
          await PreferencesUtils.savaData(
              Strings.CACHE_CYSBM, user.data.CYSBM); //密码
//            Navigator.of(context).pushNamed(
//                RouterManager.main); //跳转界面可以返回到上一个界面（不能传参）
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouterManager.main, (Route route) => route == null); //跳转界面销毁当前界面
        } else {
          print(user.msg + ',' + '错误码:' + user.code);
        }
      } else {
        Toast.toast(context, '连接服务器失败!');
      }
    });
  }
}

String getPhone() {
  String phones;
  PreferencesUtils.readData(Strings.cache_phone).then((phone) {
    phones = phone;
  });
  return phones;
}
