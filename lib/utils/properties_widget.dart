import 'package:flutter/material.dart';

//for card decoration
BoxDecoration boxShadowDecoration({
  double borderRadius = 10.0,
  Color shadowColor = Colors.grey,
  double spreadRadius = 1.0,
  double blurRadius = 10.0,
  Color backgroundColor = Colors.white,
}) {
  return BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: shadowColor.withOpacity(0.2),
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      ),
    ],
  );
}
