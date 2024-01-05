import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class TCirclularContainer extends StatelessWidget {
  const TCirclularContainer(
      {super.key,
      this.child,
      this.border,
      this.width = 400,
      this.height = 400,
      this.radius = 400,
      this.padding = EdgeInsets.zero,
      this.margen = EdgeInsets.zero,
      this.backgroundColor = TColors.white,
      this.onTap});

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsets? padding;
  final EdgeInsets? margen;
  final Widget? child;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margen,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}
