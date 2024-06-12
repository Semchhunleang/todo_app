import 'package:flutter/material.dart';

const double padding = 15.0;
const double iPadSize = 600;

double width(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width;
}

bool isIpad(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width > iPadSize;
}

double square(BuildContext context) {
  final square =
      MediaQuery.of(context).size.width - (isIpad(context) ? 60 : 45);
  return square;
}
