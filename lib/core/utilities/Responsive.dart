import 'package:flutter/widgets.dart';

class Responsive {
  bool isMobile(BuildContext context) =>
      MediaQuery
          .sizeOf(context)
          .width < 600;

  bool isTablet(BuildContext context) {
    double w = MediaQuery
        .sizeOf(context)
        .width;
    return w >= 600 && w < 1100;
  }
  bool isDeskTop(BuildContext context) {
    double w = MediaQuery
        .sizeOf(context)
        .width;
    return w >= 1100;
  }
}