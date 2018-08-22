import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tab_button/api/base_api.dart';
import 'package:flutter_tab_button/api/response_result.dart';
import 'package:flutter_tab_button/response/home_statistics.dart';
import 'package:flutter_tab_button/utils/preferences.dart';
import 'package:flutter_tab_button/utils/url.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';
import 'package:flutter_tab_button/values/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tab_button/view/btn_image_text.dart';
import 'package:flutter_tab_button/view/line.dart';
import 'package:flutter_tab_button/view/rating_star_view.dart';

class HomeActivity extends StatefulWidget {
  HomeActivity({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeUi();
  }
}

//统计接口
Future<StatisticsModel> get() async {
  String token = await PreferencesUtils.readData(Strings.cache_token);
  String CYSBM = await PreferencesUtils.readData(Strings.CACHE_CYSBM);
  //查询医生工作台首页信息
  String params =
      '{"MSH.1":"docStage", "MSH.2": "qryStageIndexHomeInfo", "CYSBM": "$CYSBM"}';
  ResponseResult result =
      await BaseApi.post(UrlUtils.FUNCTION_API + token, params);
  var statisticsModel =
      StatisticsModel.fromJson(PreferencesUtils.getMap(result.body));
  return statisticsModel;
}

class HomeUi extends State<HomeActivity> {
  final GlobalKey<HomeUi> _homeKey = GlobalKey<HomeUi>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget listContent(StatisticsModel model){
      return new ListView(
        children: <Widget>[
          new Container(
            key: _homeKey,
            color: Colors.grey[100],
            height: Dimens.d350,
            child: new Stack(
              alignment: new Alignment(0.0, 0.0),
              children: <Widget>[
                new Positioned(
                  top: 0.0,
                  child: new Stack(
                    alignment: new Alignment(0.0, 0.0),
                    children: <Widget>[
                      new Container(
                        child: new Image.asset(
                          MyIcon.icon_home_banner,
                          width: Dimens.width(context),
                          height: Dimens.d240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      new Positioned(
                        child: new Image.asset(
                          MyIcon.icon_home_head_bg,
                          width: Dimens.d108,
                          height: Dimens.d108,
                        ),
                      ),
                      new Positioned(
                        child: new ClipRRect(
                          //加载网络圆形图片
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.d40)),
                          child: new CachedNetworkImage(
                            imageUrl: UrlUtils.HOST+model.data.CYSTX,
                            width: Dimens.d80,
                            height: Dimens.d80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      new Positioned(
                        bottom: 16.0,
                        child: docInfoMation(model),
                      ),
                    ],
                  ),
                ),
                new Positioned(
                    top: Dimens.d25,
                    right: Dimens.d16,
                    child: Row(
                      children: <Widget>[
                        new Image.asset(
                          MyIcon.icon_notification,
                          width: Dimens.d16,
                          height: Dimens.d23,
                          fit: BoxFit.fill,
                        ),
                      ],
                    )),
                new Positioned(
                  bottom: 20.0,
                  left: 15.0,
                  right: 15.0,
                  child: new Material(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    color: Colors.white,
                    elevation: 2.0,
                    child: _messagePlan(context),
                  ),
                ),
              ],
            ),
          ),
          //统计部分模块
          _statistics(context),
          _statisticsList(context,model),
        ],
      );
    }

    return new Scaffold(
      body: new Container(
          color: Colors.grey[100],
          width: Dimens.width(context),
          child: new FutureBuilder(
              future: get(),
              builder: (context,data){
                return data.hasData?listContent(data.data): Center(child: CircularProgressIndicator());
              })),
    );
  }
}

Widget _statistics(BuildContext context) {
  return new Container(
    color: Colors.white,
    padding: EdgeInsets.only(left: Dimens.d11, top: Dimens.d11),
    width: Dimens.width(context),
    child: new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Image.asset(
              MyIcon.icon_statistics,
              width: Dimens.d18,
              height: Dimens.d18,
              fit: BoxFit.fill,
            ),
            new Container(
              padding: EdgeInsets.only(left: Dimens.d5),
              child: new Text(
                Strings.textStatistics,
                style: TextStyle(
                    fontSize: Dimens.d15, color: MyColors.color_606775),
              ),
            )
          ],
        ),
        new Container(
          margin: EdgeInsets.only(left: Dimens.d0, top: Dimens.d10),
          child: Lines(
            color: MyColors.color_F1F1F1,
            height: Dimens.d1,
          ),
        )
      ],
    ),
  );
}

Widget _statisticsList(BuildContext context,StatisticsModel model) {
  return new Container(
    color: Colors.white,
    width: Dimens.width(context),
    height: Dimens.d250,
    child: new ListView.builder(
        controller: ScrollController(
            keepScrollOffset: false), //关闭Scroll滑动效果(listView嵌套也可以取消滑动冲突)
        itemCount: model.data.list.length,
        padding: EdgeInsets.only(left: Dimens.d15, top: Dimens.d15),
        itemBuilder: (context, position) {
          return model!=null
              ? new StatisticsList(
            model: model,
            position: position,
          )
              : Center(child: CircularProgressIndicator());
        }),
  );
}

class StatisticsList extends StatelessWidget {
  final StatisticsModel model;
  final int position;
  StatisticsList({this.model, this.position});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,//设置该属性item默认点击空白处生效
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(model.data.list[position].title,
                  style: TextStyle(
                      color: MyColors.color_2D374B, fontSize: Dimens.d17)),
              new Container(
                padding: EdgeInsets.only(right: Dimens.d15),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      position==1?model.data.list[position].value+' 人':model.data.list[position].value,
                      style: TextStyle(
                          color: MyColors.color_96979E, fontSize: Dimens.d17),
                    ),
                    new Image.asset(
                      MyIcon.img_function_arrows_right,
                      width: Dimens.d20,
                      height: Dimens.d20,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              )
            ],
          ),
          new Divider(
            height: 35.0,
            indent: 0.0,
            color: MyColors.color_F1F1F1,
          ),
        ],
      ),
      onTap: () {
        //统计点击事件
        _statisticsOnClick(position);
      },
    );
  }
}

//统计点击事件
void _statisticsOnClick(int position) {
  switch (position) {
    case 0:
      print(position.toString());
      break;
    case 1:
      print(position.toString());
      break;
    case 2:
      print(position.toString());
      break;
    case 3:
      print(position.toString());
      break;
  }
}

//患者消息，预警，计划，方案

Widget _messagePlan(BuildContext context) {
  Widget messagePlan = new Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width,
    height: Dimens.d100,
    margin: EdgeInsets.only(right: Dimens.d15, left: Dimens.d15),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ButtonImageText(
          onClickIndex: 1,
          tabText: '患者消息',
          icon: MyIcon.icon_home_patients_msg,
        ),
        ButtonImageText(
          onClickIndex: 2,
          tabText: '预警消息',
          icon: MyIcon.icon_home_warning_msg,
        ),
        ButtonImageText(
          onClickIndex: 3,
          tabText: '工作计划',
          icon: MyIcon.icon_home_work_plan,
        ),
        ButtonImageText(
          onClickIndex: 4,
          tabText: '健康方案',
          icon: MyIcon.icon_home_health_plan,
        ),
      ],
    ),
  );
  return messagePlan;
}

//医生信息
Widget docInfoMation(StatisticsModel model) {
  return new Container(
    child: new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            new Text(
              model.data.CYSMC,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimens.d20,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: Dimens.d5, top: Dimens.d3),
              child: new Material(
                color: MyColors.bgYellow,
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
                child: Container(
                  color: MyColors.bgYellow,
                  padding: EdgeInsets.all(1.0),
                  child: new Text(
                    model.data.CYSLX,
                    style: TextStyle(fontSize: Dimens.d8, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            new Text(
              Strings.textPatientNum,
              style: TextStyle(color: Colors.white, fontSize: Dimens.d12),
            ),
            new Text(
              model.data.patientCount+'人',
              style: TextStyle(color: Colors.white, fontSize: Dimens.d12),
            ),
            new Container(
              padding: EdgeInsets.only(left: Dimens.d9),
              child: new Text(
                model.data.doctorGrade+'分',
                style: TextStyle(
                  fontSize: Dimens.d15,
                  color: Colors.white,
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: Dimens.d2),
              child: new RatingStarView(
                starNum: double.parse(model.data.doctorGrade)~/2,
                size: 15.0,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
