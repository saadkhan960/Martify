import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/curved_header/bottom_curved_edge_widget.dart';
import 'package:martify/utils/common/widgets/curved_header/header_circular_container.dart';
import 'package:martify/utils/constants/color.dart';

class MPrimaryHeaderWidget extends StatelessWidget {
  final Widget child;
  const MPrimaryHeaderWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BottomCurvedEdgeWidget(
      child: Container(
        color: MAppColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          //380 height sizebox
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: HeaderCircularContainer(
                    bgColor: MAppColors.white.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: HeaderCircularContainer(
                    bgColor: MAppColors.white.withOpacity(0.1))),
            child
          ],
        ),
      ),
    );
  }
}
