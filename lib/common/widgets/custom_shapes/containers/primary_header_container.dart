import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/curved_edges/curved_edges_widget.dart';

import '../../../../features/shop/screens/home/widgets/circular_widget.dart';
import '../../../../utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
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
            Positioned(
                top: -150,
                right: -250,
                child: TCirclularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: TCirclularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
