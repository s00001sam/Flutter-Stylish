import 'package:flutter/cupertino.dart';

bool isPhoneDevice(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  return deviceWidth <= 600;
}