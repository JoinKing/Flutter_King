import 'package:flutter/material.dart';

class RatingStarView extends StatelessWidget {
  int starNum = 1;
  double size = 10.0;

  Color color = Colors.yellow;
  static StarModel model1 = new StarModel();
  static StarModel model2 = new StarModel();
  static StarModel model3 = new StarModel();
  static StarModel model4 = new StarModel();
  static StarModel model5 = new StarModel();


  RatingStarView({this.starNum, this.size});


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    switch (starNum) {
      case 1:
        model1.color = Colors.yellow;
        break;
      case 2:
        model1.color = Colors.yellow;
        model2.color = Colors.yellow;
        break;
      case 3:
        model1.color = Colors.yellow;
        model2.color = Colors.yellow;
        model3.color = Colors.yellow;
        break;
      case 4:
        model1.color = Colors.yellow;
        model2.color = Colors.yellow;
        model3.color = Colors.yellow;
        model4.color = Colors.yellow;
        break;
      case 5:
        model1.color = Colors.yellow;
        model2.color = Colors.yellow;
        model3.color = Colors.yellow;
        model4.color = Colors.yellow;
        model5.color = Colors.yellow;
        break;
    }
    

    return new Container(
      child: new GestureDetector(
        child: new Row(
          children: <Widget>[

            new Icon(Icons.star, color: model1.color,size: size,),
            new Icon(Icons.star, color: model2.color,size: size),
            new Icon(Icons.star, color: model3.color,size: size),
            new Icon(Icons.star, color: model4.color,size: size),
            new Icon(Icons.star, color: model5.color,size: size),


          ],
        ),

      )
    );
  }
}

class StarModel {
  Color color = Colors.grey;
}