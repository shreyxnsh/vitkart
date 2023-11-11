import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtend = 288,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtend;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtend,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
