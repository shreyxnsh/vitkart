import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class BuyerCard extends StatelessWidget {
  final String name;
  final String email;
  final String regId;
  final void Function()? onTap;
  const BuyerCard({
    super.key,
    required this.name,
    required this.email,
    required this.regId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      radius: TSizes.sm,
      backgroundColor: dark ? TColors.lightDarkBackground : TColors.light,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: TSizes.xs,
          ),
          Text(
            regId,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.xs,
          ),
          Text(
            email,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: TColors.light,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size.fromHeight(48),
                maximumSize: const Size.fromHeight(48),
              ),
              child: Text('Remove',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: TColors.warning,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
