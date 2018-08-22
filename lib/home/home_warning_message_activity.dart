import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_button/api/base_api.dart';
import 'package:flutter_tab_button/api/response_result.dart';
import 'package:flutter_tab_button/response/home_early_warning.dart';
import 'package:flutter_tab_button/response/home_statistics.dart';
import 'package:flutter_tab_button/utils/preferences.dart';
import 'package:flutter_tab_button/utils/url.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/icon.dart';
import 'package:flutter_tab_button/values/strings.dart';
import 'package:flutter_tab_button/view/layout_head_title.dart';
import 'package:flutter_tab_button/view/line.dart';

class TheWarningMessageActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TheWarningMessageUi();
  }
}

/*
 * 枚举类，标签演示样式
 *  图标和文本
 *  仅图标
 *  仅文本
 */
enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class _Page {
  _Page({
    this.icon,
    this.text,
    this.IZT,
  });

  final IconData icon;
  final String text;
  final String IZT;
}

// 存储所有页面的列表
final List<_Page> _allPages = <_Page>[
  new _Page(icon: Icons.event, text: '全部', IZT: ''),
  new _Page(icon: Icons.home, text: '未处理', IZT: '0'),
  new _Page(icon: Icons.android, text: '已处理', IZT: '1'),
  new _Page(icon: Icons.alarm, text: '已取消', IZT: '2'),
];

Future<EarlyWarning> initData(String IZT, String pageSize, String pageNum) async {
  String token = await PreferencesUtils.readData(Strings.cache_token);
  String CYSBM = await PreferencesUtils.readData(Strings.CACHE_CYSBM);
  //查询预警模块列表
  String params =
      '{"MSH.1":"docStage","MSH.2":"qeyEarlyWarning","pageSize":"$pageSize","pageNum":"$pageNum","$CYSBM":"10001","IZT":"$IZT"}';
  ResponseResult result =
      await BaseApi.post(UrlUtils.FUNCTION_API + token, params);
  var earlyWarning =
      EarlyWarning.fromJson(PreferencesUtils.getMap(result.body));
  print('实体类:' + earlyWarning.toString());
  return earlyWarning;
}

class TheWarningMessageUi extends State<TheWarningMessageActivity>
    with SingleTickerProviderStateMixin {
  /*
   * 在TabBar和TabBarView之间的坐标选项卡选择
   *  TabBar：质感设计控件，显示水平的一行选项卡
   *  TabBarView：可分布列表，显示与当前所选标签对应的控件
   */

  TabController _controller;
  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;

  @override
  void initState() {
    super.initState();
    /*
     * 创建一个对象，用于管理TabBar和TabBarView所需的状态
     *  length：选项卡的总数，存储所有页面的列表中的元素个数
     */
    _controller = new TabController(vsync: this, length: _allPages.length);
  }

  // 释放对象使用的资源
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Color iconColor = Theme.of(context).accentColor;
    return new Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          actions: <Widget>[
            new HeadTitle(
              titleCenter: '预警',
              isShowRight: false,
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: new TabBar(
            // 控件的选择和动画状态
            indicatorColor: Colors.blue,
            controller: _controller,
            labelColor: Colors.blue,
            //tab文字标签颜色
            indicatorWeight: 2.0,
            // 标签栏是否可以水平滚动
            isScrollable: true,
            // 标签控件的列表
            tabs: _allPages.map((_Page page) {
//              switch(_demoStyle) {
//                case TabsDemoStyle.iconsAndText:
//                  return new Tab(text: page.text, icon: new Icon(page.icon));
//                case TabsDemoStyle.iconsOnly:
//                  return new Tab(icon: new Icon(page.icon));
//                case TabsDemoStyle.textOnly:
              return new Tab(text: page.text);
//              }
            }).toList(),
          ),
        ),
        body: new TabBarView(
          // 控件的选择和动画状态
          controller: _controller,
          // 每个标签一个控件
//          children: <Widget>[
//            new Text('1'),
//            new Text('2'),
//            new Text('3'),
//            new Text('4'),
//            new Text('5'),
//          ],
//          children: _allPages.map((_Page page) {
//            return new Container(
//                key: new ObjectKey(page.icon),
//                // 质感设计卡片
//                child: new Card(
//                    child: new Center(
//                        child: new Icon(
//                  page.icon,
//                  color: iconColor,
//                  size: 128.0,
//                ))));
//          }).toList(),
          children: _allPages.map((_Page page) {
            return new Container(
              key: new ObjectKey(page.icon),
              // 质感设计卡片
              child: new RefreshIndicator(
                  child: new FutureBuilder(
                      future: initData(page.IZT, '10', '1'),
                      builder: (context, dataBean) {
                        return dataBean.hasData
                            ? _EarlyWarningList(
                          earlyWarning: dataBean.data,
                        )
                            : Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  onRefresh: loadData,
              ),
            );
          }).toList(),
        ));
  }

  Future<Null>loadData()async{
    await initData('', '', '');
    if(!mounted)return;
    setState(() {

    });
  }
}

class _EarlyWarningList extends StatelessWidget {
  EarlyWarning earlyWarning;

  _EarlyWarningList({this.earlyWarning});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount:
            earlyWarning.code == '200' ? earlyWarning.data.list.length : 1,
        itemBuilder: (context, position) {
          return earlyWarning.code == '200'
              ? _itemEarlyWarning(context, earlyWarning, position)
              : new Text('没有数据');
        });
  }
}

Widget _itemEarlyWarning(
    BuildContext context, EarlyWarning earlyWarning, int position) {
  return Container(
    margin: EdgeInsets.only(top: Dimens.d16),
    width: Dimens.width(context),
    height:
        earlyWarning.data.list[position].IZT == 0 ? Dimens.d220 : Dimens.d180,
    color: Colors.white,
    child: new Stack(
      alignment: new Alignment(0.0, 0.0),
      children: <Widget>[
        new Positioned(
          child: new Text('状态'),
          top: Dimens.d16,
          right: Dimens.d16,
        ),
        new Positioned(
            top: Dimens.d4,
            left: Dimens.d16,
            child: new Row(
              children: <Widget>[
                new Image.asset(
                  MyIcon.icon_xyyj,
                  width: Dimens.d18,
                  height: Dimens.d18,
                ),
                new Container(
                  padding: EdgeInsets.only(left: Dimens.d5),
                  child: new Text('血压预警'),
                )
              ],
            )),
        new Positioned(
            top: Dimens.d40,
            left: Dimens.d16,
            child: new Row(
              children: <Widget>[
                new ClipRRect(
                  //裁剪
                  //加载网络圆形图片
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.d30)),
                  child: new CachedNetworkImage(
                    imageUrl: MyIcon.test_head_url,
                    width: Dimens.d30,
                    height: Dimens.d30,
                    fit: BoxFit.fill,
                  ),
                ),
                new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(left: Dimens.d16),
                          child: new Text(
                            earlyWarning.data.list[position].CHZXM.toString(),
                            style: TextStyle(
                                fontSize: Dimens.d18,
                                color: MyColors.color_333333),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: Dimens.d10),
                          child: new Text(
                            earlyWarning.data.list[position].CXB.toString(),
                            style: TextStyle(
                                fontSize: Dimens.d12,
                                color: MyColors.color_F4F4F4),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: Dimens.d5),
                          child: new Text(
                            earlyWarning.data.list[position].IZT.toString() +
                                '岁',
                            style: TextStyle(
                                fontSize: Dimens.d12,
                                letterSpacing: 2.0, //文字间距
                                color: MyColors.color_F4F4F4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
        new Positioned(
          child: new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: Dimens.d18),
                child: new Lines(
                  width: Dimens.width(context),
                  height: Dimens.d1,
                  color: MyColors.color_F1F1F1,
                ),
              ),
              new Container(
                width: Dimens.width(context),
                padding: EdgeInsets.only(top: Dimens.d12),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      '血压：' +
                          '/' +
                          earlyWarning.data.list[position].CSZY.toString() +
                          '       心率：' +
                          earlyWarning.data.list[position].CXL.toString(),
//                        '血压：',
                      style: TextStyle(
                          fontSize: Dimens.d18, color: MyColors.color_333333),
                    ),
                  ],
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: Dimens.d10),
                width: Dimens.width(context),
                child: new Text(
                  '向用户简单介绍一些他最近的血压情',
                  style: TextStyle(
                      fontSize: Dimens.d14, color: MyColors.color_F4F4F4),
                ),
              ),
              new Container(
                width: Dimens.width(context),
                child: earlyWarning.data.list[position].IZT == 0
                    ? new Column(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(top: Dimens.d14),
                            child: new Lines(
                              width: Dimens.width(context),
                              height: Dimens.d1,
                              color: MyColors.color_F1F1F1,
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(
                                    top: Dimens.d10, left: 150.0),
                                constraints: new BoxConstraints.expand(
                                    width: 50.0, height: 30.0),
                                //设置按钮的大小
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                    //让矩形四个角都变成圆角
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                child: new GestureDetector(
                                  child: new Material(
                                    elevation: 1.0,
                                    color: Colors.white,
                                    textStyle: TextStyle(color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    child: new Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '完成',
                                        style: TextStyle(
                                            color: MyColors.color_333333),
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              new Container(
                                margin: EdgeInsets.only(
                                    left: Dimens.d20, top: Dimens.d10),
                                constraints: new BoxConstraints.expand(
                                    width: 50.0, height: 30.0),
                                //设置按钮的大小
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                    //让矩形四个角都变成圆角
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                child: new GestureDetector(
                                  child: new Material(
                                    elevation: 1.0,
                                    color: Colors.white,
                                    textStyle: TextStyle(color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    child: new Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '取消',
                                        style: TextStyle(
                                            color: MyColors.color_333333),
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : new Text(''),
              )
            ],
          ),
          left: Dimens.d60,
          top: Dimens.d70,
        )
      ],
    ),
  );
}
