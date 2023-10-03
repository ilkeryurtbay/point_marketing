import 'package:flutter/cupertino.dart';

class AppSpace {
  AppSpace._();
  static final vertical = _VerticalSpace();
  static final horizontal = _HorizontalSpace();
}

class _VerticalSpace {
  final SizedBox space20 = const SizedBox(
    height: 20,
  );
}

class _HorizontalSpace {
  final SizedBox space10 = const SizedBox(
    width: 10,
  );
  final SizedBox space40 = const SizedBox(
    width: 40,
  );
}
