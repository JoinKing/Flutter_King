import 'package:flutter/material.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';
import 'package:flutter_tab_button/values/strings.dart';

//主页按钮切换状态

class ImageSelect extends StatelessWidget {
  bool selected;
  String icon;
  String tab;
  int index = 0;

  ImageSelect({this.selected, this.icon, this.tab,this.index});

  @override
  Widget build(BuildContext context) {
    Color color = MyColors.tvBlur;

    if (!this.selected) {
      color = MyColors.tvHomeGay;
    }else{
      if(index==0){
        icon = MyIcon.icon_home_select;
      }else if(index==1){
        icon = MyIcon.icon_patient_select;
      }else if(index==2){
        icon = MyIcon.icon_person_select;
      }
    }

    return Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              icon,
              width: Dimens.d23,
              height: Dimens.d23,
              fit: BoxFit.fill,
            ),
            Text(this.tab, style:
            TextStyle(
              color: color,
              fontSize: Dimens.d11,
              decorationColor: Color(MyColors.transparent), //隐藏文本下划线
            ),
            ),
          ],
        )
    );
  }

}

