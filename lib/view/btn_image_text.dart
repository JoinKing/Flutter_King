import 'package:flutter/material.dart';
import 'package:flutter_tab_button/manager/router.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';

class ButtonImageText extends StatelessWidget {
  int onClickIndex = -1;
  String icon;
  String tabText;
  ButtonImageText({this.onClickIndex, this.icon, this.tabText}); //健康方案


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new GestureDetector(
        behavior: HitTestBehavior.translucent,//设置该属性item默认点击空白处生效
        onTap: () {
          switch (onClickIndex) {
            case 1:
              print('' + "患者消息");
              break;
            case 2:
              Navigator.of(context).pushNamed(RouterManager.homeWarning);
              break;
            case 3:
              print('' + "工作计划");
              break;
            case 4:
              print('' + "健康方案");
              break;
          }
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              icon == null ? MyIcon.icon_home : icon,
              width: Dimens.d38,
              height: Dimens.d36,
              fit: BoxFit.scaleDown,
            ),
            new Container(
              margin: EdgeInsets.only(top: Dimens.d5),
              child: new Text(
                tabText==null?"按钮":tabText,
                style: TextStyle(
                    color: MyColors.textBlack,
                    fontSize: Dimens.d14
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
