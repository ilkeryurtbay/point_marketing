import 'package:flutter/cupertino.dart';

class AppSpace {
  AppSpace._();
  static final vertical = _VerticalSpace();
  static final horizontal = _HorizontalSpace();
}

class _VerticalSpace {
  final SizedBox space5 = const SizedBox(
    height: 5,
  );
  final SizedBox space10 = const SizedBox(
    height: 10,
  );
  final SizedBox space20 = const SizedBox(
    height: 20,
  );
  final SizedBox space60 = const SizedBox(
    height: 60,
  );
}

class _HorizontalSpace {
  final SizedBox space10 = const SizedBox(
    width: 10,
  );
  final SizedBox space20 = const SizedBox(
    width: 20,
  );
  final SizedBox space40 = const SizedBox(
    width: 40,
  );
}
