import 'package:flutter/material.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';
import 'package:flutter_tab_button/values/strings.dart';

class HeadTitle extends StatelessWidget {
  String titleCenter = "";
  String titleRight = "";
  bool isShowRight = false;

  HeadTitle({this.titleCenter, this.titleRight, this.isShowRight});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(//设置布局阴影效果套Material
      child: new Container(
        color: Colors.white,
        height: Dimens.d48,
        width: Dimens.width(context),
        constraints: new BoxConstraints.expand(width: Dimens.width(context), height: 48.0),

        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new FlatButton.icon(
                onPressed: () {
                  _backFinash(context);
                },
                icon: new Image.asset(
                  MyIcon.icon_back,
                  height: 25.0,
                ),
                label: new Text(Strings.textBack)),
            new Container(
              margin: isShowRight == true?EdgeInsets.only(right: Dimens.d40):EdgeInsets.only(right: Dimens.d20),
              child: new Text(
                titleCenter,
                style: TextStyle(
                    fontSize: Dimens.d20,
                    color: MyColors.color_333333,
                    fontWeight: FontWeight.bold),
              ),
            ),
            new Container(
                margin: EdgeInsets.only(right: Dimens.d16),
                child: isShowRight == true
                    ? new Text(
                  Strings.textSave,
                  style: TextStyle(
                    fontSize: Dimens.d20,
                    color: MyColors.color_606775,
                  ),
                )
                    : new Text(
                  Strings.textSave,
                  style: TextStyle(
                    fontSize: Dimens.d20,
                    color: Colors.white,
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }

  _backFinash(BuildContext context) {
    Navigator.of(context).pop();
  }
}
