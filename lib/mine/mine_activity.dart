import 'package:flutter/material.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/strings.dart';

class MineActivity extends StatefulWidget {
  MineActivity({Key key}) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MineUi();
  }
}

class MineUi extends State<MineActivity> {
  final GlobalKey<MineUi> _mineKey = GlobalKey<MineUi>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[
        new Container(
          width: Dimens.width(context),
          height: Dimens.height(context),
          color: Colors.blue,

          child: new Text(Strings.mine),
        )

      ],
    );
  }
}



