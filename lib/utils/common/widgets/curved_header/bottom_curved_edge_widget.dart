import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/curved_header/clipper_edges.dart';

class BottomCurvedEdgeWidget extends StatelessWidget {
  final Widget child;
  const BottomCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperEdges(),
      child: child,
    );
  }
}
