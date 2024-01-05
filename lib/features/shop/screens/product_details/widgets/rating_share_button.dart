import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/curved_edges/curved_edges.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Rating
        

        // Share Button
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            size: TSizes.iconMd,
          ),
        ),
      ],
    );
  }
}

class TCurverEdgesWidget extends StatelessWidget {
  const TCurverEdgesWidget({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}
