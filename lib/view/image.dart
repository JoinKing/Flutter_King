import 'package:flutter/material.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';

//主页按钮切换状态

class ImageTab extends StatelessWidget {
  bool selected;
  IconData icon;
  String tab;
  ImageTab({this.selected, this.icon, this.tab});
  @override
  Widget build(BuildContext context) {
    Color color = Colors.brown;
    if (!this.selected) {
      color = Color(0xff999999);
    }
    return Center(
        child: Column(
          children: <Widget>[
            Icon(this.icon, color: color,),
            Text(this.tab, style: TextStyle(
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

