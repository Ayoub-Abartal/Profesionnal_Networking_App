import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Returns the height based on the percentage entered and the height of the screen
double aHeight(double percentage, context) {
  return MediaQuery.of(context).size.height * percentage / 100;
}

/// Returns the width based on the percentage entered and the wif=dth of the screen
double aWidth(double percentage, context) {
  return MediaQuery.of(context).size.width * percentage / 100;
}
