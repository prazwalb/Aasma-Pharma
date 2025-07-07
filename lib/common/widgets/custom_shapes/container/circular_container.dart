import 'package:android_std/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.backgroundcolor = PColors.textWhite,
    this.radius = 400,
    this.padding = 0,
    this.child,
  });

  final double? height;
  final double? width;
  final Color? backgroundcolor;
  final double radius;
  final double padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: PColors.textWhite.withOpacity(0.1),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
