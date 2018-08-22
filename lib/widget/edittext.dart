import 'package:flutter/material.dart';
import 'package:flutter_tab_button/view/line.dart';

//输入框控件案例
class EditText extends StatelessWidget {
  TextEditingController editText = TextEditingController();

  Paint paint = Paint();


  @override
  Widget build(BuildContext context) {
    TextEditingController editText1 = TextEditingController();

    paint.color = Color.fromARGB(255, 255, 255, 255);

    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("輸入"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: editText,
              //输入控件
              maxLength: 12,
              obscureText: false,
              //输入模糊文字
              decoration: InputDecoration( //输入框样式设置
//                  icon: const Icon(Icons.person),
                //关闭系统自带字数统计
//                  border: InputBorder.none,
                //该属性关闭外框
                  hintText: '用户名',
                  //hint提示，与android一样
                  labelText: '用户名',
                  //标签
                  contentPadding: const EdgeInsets.all(12.0)
              ),
              onChanged: (String phone) { //输入完成调此方法
                print(phone);
              },
            ),

            padding: EdgeInsets.all(15.0),
          ),
//          Lines.getLine(Colors.blue, null, 1.0),

          new TextFormField( //文本表单（常用的）
            style: TextStyle(
              color: Colors.blue,
            ),
            controller: editText1,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              filled: true,
              icon: const Icon(
                Icons.person,
              ),
              hintText: 'What do people call you?',
//              labelText: 'Name *',
            ),
            onSaved: (String value) {
              print(value);
            },
            validator: _validateName,
          ),
          Lines(
            color: Colors.grey[500],
            height: 0.5,
          ),

          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: ()async{
                print('测试数据'+editText1.text);
              }),
        ],

      ),
    );
  }

  bool _formWasEdited = false;

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

}