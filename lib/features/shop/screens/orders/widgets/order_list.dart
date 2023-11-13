import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_,__) => const SizedBox(height: TSizes.spaceBtwItems,),
      itemBuilder: (_, index) => TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
    
            /// Row - 1
            Row(
              children: [
    
                /// icon
                const Icon(Iconsax.ship),
                const SizedBox(width: TSizes.spaceBtwItems/2,),
    
                /// status and date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        '12 Nov 2023',
                        style: Theme.of(context).textTheme.headlineSmall
                      ),
                    ],
                  ),
                ),
    
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm,))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),
              
            
            /// Row - 2
            Row(
              children: [
    
                Expanded(
                  child: Row(
                    children: [
                      /// icon
                      const Icon(Iconsax.tag),
                      const SizedBox(width: TSizes.spaceBtwItems/2,),
                
                      /// status and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Order Id',
                              style: Theme.of(context).textTheme.labelMedium
                            ),
                            Text(
                              '[#69420]',
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    
                Expanded(
                  child: Row(
                    children: [
                      /// icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: TSizes.spaceBtwItems/2,),
                
                      /// status and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Shipping Date :',
                              style: Theme.of(context).textTheme.labelMedium
                            ),
                            Text(
                              '14 Nov 2023',
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    
                
              ],
            )
          ],
        ),
      ),
    );
  }
}