import 'package:flutter/cupertino.dart';

class AppPadding {
  AppPadding._();
  static const pagePadding = EdgeInsets.fromLTRB(16, 32, 16, 16);

  static const allSides8 = EdgeInsets.all(8);
  static const allSides16 = EdgeInsets.all(16);
  static const allSides24 = EdgeInsets.all(24);

  static const horizontalSymmetric8 = EdgeInsets.symmetric(horizontal: 8);
  static const horizontalSymmetric16 = EdgeInsets.symmetric(horizontal: 16);
  static const horizontalSymmetric24 = EdgeInsets.symmetric(horizontal: 24);

  static const verticalSymmetric8 = EdgeInsets.symmetric(vertical: 8);
  static const verticalSymmetric16 = EdgeInsets.symmetric(vertical: 16);
  static const verticalSymmetric24 = EdgeInsets.symmetric(vertical: 24);

  static const onlyRight4 = EdgeInsets.only(right: 4);
}
