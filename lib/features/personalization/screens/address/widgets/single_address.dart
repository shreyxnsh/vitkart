import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
                width: double.infinity,
                showBorder: true,
                borderColor: selectedAddress ? Colors.transparent : dark ? TColors.darkerGrey : TColors.grey,
                backgroundColor: selectedAddress ? TColors.primary.withOpacity(0.5) : Colors.transparent,
                margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                child: Stack(
                  children: [
                    Positioned(
                      right: 5,
                      top: 0,
                      child: Icon(
                        selectedAddress ? Iconsax.tick_circle5 : null,
                        color: selectedAddress ?  dark ? TColors.light : TColors.dark : null,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shreyansh Jain',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: TSizes.sm/2,
                        ),
                        const Text('+91 9494315111', maxLines: 1, overflow: TextOverflow.ellipsis,),
                        const SizedBox(
                          height: TSizes.sm/2,
                        ),
                        const Text('Room no: B504, Block 3, Boys Hostel, VIT Bhopal University.', softWrap: true,),
                      ],
                    )
                  ],
                ),
                

                
              );
  }
}