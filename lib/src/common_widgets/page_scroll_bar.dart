import 'package:flutter/material.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';

import '../../core/constants/app_padding.dart';

class PageScrollBar extends StatelessWidget {
  final Widget child;
  const PageScrollBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const double scrollBarRadius = 10;
    const double scrollbarThickness = 5;
    return RawScrollbar(
      thumbVisibility: true,
      padding: AppPadding.onlyRight4,
      thumbColor: context.mainThemeColor,
      thickness: scrollbarThickness,
      radius: const Radius.circular(scrollBarRadius),
      interactive: true,
      child: child,
    );
  }
}
