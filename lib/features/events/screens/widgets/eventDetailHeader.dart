import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/curved_edges/curved_edges_widget.dart';

import '../../../../utils/constants/colors.dart';

class TEventHeaderContainer extends StatelessWidget {
  const TEventHeaderContainer({
    super.key,
    required this.child, this.height,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        height: height,
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/content/popular1.png",
              fit: BoxFit.fitWidth,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
