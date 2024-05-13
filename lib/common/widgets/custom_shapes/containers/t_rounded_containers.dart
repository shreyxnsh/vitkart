import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.padding,
    this.margin,
    this.child,
    this.clipBehavior,
    this.backgroundColor = TColors.white,
    this.borderColor = TColors.borderPrimary,
    this.showBorder = false,
    this.duration,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBorder;
  final Clip? clipBehavior;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration ?? const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      clipBehavior: clipBehavior ?? Clip.none,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}
