import 'package:flutter/material.dart';
import 'package:flutter_tab_button/home/home_activity.dart';
import 'package:flutter_tab_button/mine/mine_activity.dart';
import 'package:flutter_tab_button/patient/patient_activity.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';
import 'package:flutter_tab_button/values/strings.dart';
import 'package:flutter_tab_button/view/image.dart';
import 'package:flutter_tab_button/view/image_select.dart';

//主页Activity 包含三个子页面
class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabMainStateActivity();
  }
}

class TabMainStateActivity extends State<MainActivity> {
  int currentIndex = 0;
  final GlobalKey<HomeUi> _homeKey = GlobalKey<HomeUi>();
  final GlobalKey<PatientUi> _patientKey = GlobalKey<PatientUi>();
  final GlobalKey<MineUi> _mineKey = GlobalKey<MineUi>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget activity = Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Stack(
              children: <Widget>[
                Offstage(
                  offstage: currentIndex != 0,
                  child: HomeActivity(
                    key: _homeKey,
                  ),
                ),
                Offstage(
                  offstage: currentIndex != 1,
                  child: PatientActivity(
                    key: _patientKey,
                  ),
                ),
                Offstage(
                  offstage: currentIndex != 2,
                  child: MineActivity(
                    key: _mineKey,
                  ),
                )
              ],
            ),
          ),

          //底部布局
          new Container(
            height: Dimens.d50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                  top: const BorderSide(color: Color(0xffeaeaea))
              ),
            ),


            child: new Row(
              children: <Widget>[
                //home
                Expanded(
                  flex: 1,
                  child: new GestureDetector(
                    onTap: () {
                      tapTab(0);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimens.d5),
                      child: ImageSelect(
                        icon: MyIcon.icon_home,
                        selected: this.currentIndex == 0,
                        tab: Strings.home,
                        index: 0,
                      ),
                    ),
                  ),
                ),
                //patient
                Expanded(
                  flex: 1,
                  child: new GestureDetector(
                    onTap: () {
                      tapTab(1);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimens.d5),
                      child: ImageSelect(
                        icon: MyIcon.icon_patient,
                        selected: this.currentIndex == 1,
                        tab: Strings.patient,
                        index: 1,
                      ),
                    ),
                  ),
                ),
                //mine
                Expanded(
                  flex: 1,
                  child: new GestureDetector(
                    onTap: () {
                      tapTab(2);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimens.d5),

                      child: ImageSelect(
                        icon: MyIcon.icon_person,
                        selected: this.currentIndex == 2,
                        tab: Strings.mine,
                        index: 2,
                      ),
                    ),
                  ),
                ),

              ],

            ),
          )
        ],
      ),
    );
    return activity;
  }

  void tapTab(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }
}