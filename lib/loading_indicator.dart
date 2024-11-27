import 'package:flutter/material.dart';


Widget loadingIndicator({circleColor = Colors.red}){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),
  );
}