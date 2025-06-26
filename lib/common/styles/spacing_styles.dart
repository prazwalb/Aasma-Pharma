import 'package:android_std/utils/constants/sizes.dart';
import 'package:flutter/widgets.dart';

class PSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: PSizes.appBarHeight,
    left: PSizes.defaultSpace,
    bottom: PSizes.defaultSpace,
    right: PSizes.defaultSpace,
  );
}
