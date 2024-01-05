import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    required this.dark,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.backgroundColor,
    this.overlayColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
  });

  final bool dark;

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final Color? overlayColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        image: isNetworkImage
            ? NetworkImage(image)
            : AssetImage(image) as ImageProvider,
        color: overlayColor,
      ),
    );
  }
}
