import 'package:android_std/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:android_std/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:android_std/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: PColors.primaryColor,
        padding: EdgeInsets.all(0),
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              ///--- Background Custom Shapes
              Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                  backgroundcolor: PColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  backgroundcolor: PColors.textWhite.withOpacity(0.1),
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
