import 'package:flutter/material.dart';

class Lines extends StatelessWidget {
  Color color = null;
  double width = null;
  double height = null;

  Lines({this.color, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    Container line = Container(
      color: color,
      width: width,
      height: height,
    );
    // TODO: implement build
    return line;
  }


}