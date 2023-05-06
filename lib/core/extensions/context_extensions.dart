import 'package:flutter/material.dart';

extension ConextHelper on BuildContext {
  // Sizes
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  Orientation get orientation => MediaQuery.of(this).orientation;
  // Sizes - Helpers
  double propHeight(double inputHeight) => (inputHeight / 812.0) * height;
  double propWidth(double inputWidth) => (inputWidth / 375.0) * width;
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  // void showToast(String text) => Fluttertoast.showToast(
  //       msg: text,
  //       toastLength: Toast.LENGTH_LONG,
  //       timeInSecForIosWeb: 30,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );

  // void showInDev() => Fluttertoast.showToast(
  //       msg: 'inDev'.tr(),
  //       toastLength: Toast.LENGTH_LONG,
  //       timeInSecForIosWeb: 30,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );

  // void showAPIError() => Future<void>.delayed(const Duration(seconds: 1), () {
  //       Fluttertoast.showToast(
  //         msg: 'apiErrorHappend'.tr(),
  //         toastLength: Toast.LENGTH_LONG,
  //         timeInSecForIosWeb: 30,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     });

  // void showAPISuccess() => Future<void>.delayed(const Duration(seconds: 1), () {
  //       Fluttertoast.showToast(
  //         msg: 'apiSuccess'.tr(),
  //         toastLength: Toast.LENGTH_LONG,
  //         timeInSecForIosWeb: 30,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     });
}
