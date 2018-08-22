import 'package:flutter/material.dart';
import 'package:flutter_tab_button/values/colors.dart';
import 'package:flutter_tab_button/values/dimens.dart';
import 'package:flutter_tab_button/values/strings.dart';

class PatientActivity extends StatefulWidget {
  PatientActivity({Key key}) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PatientUi();
  }
}

class PatientUi extends State<PatientActivity> {

  final GlobalKey<PatientUi> _patientKey = GlobalKey<PatientUi>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[
        new Container(
          width: Dimens.width(context),
          height: Dimens.height(context),
          color: Colors.blue,
          child: new ListView.builder(
              itemCount: 15,
              itemBuilder: (context,position){
            return new Text(position.toString());
          }),
        )
        
      ],
    );
  }
}


