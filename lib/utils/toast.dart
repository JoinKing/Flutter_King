import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_button/values/dimens.dart';

class Toast{


  static toast(BuildContext context,String msg){

    Scaffold.of(context).showSnackBar(new SnackBar(
      backgroundColor: Colors.blueGrey[500],
      content: new Container(
        alignment: Alignment.center,
        width: Dimens.width(context),
        height: Dimens.d30,
        child: new Text(msg),
      ),
    ));
  }
}