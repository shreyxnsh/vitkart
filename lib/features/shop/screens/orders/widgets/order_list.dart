import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TOrderListItems extends StatefulWidget {
  final List<ProductData> productList;

  const TOrderListItems({
    super.key,
    this.productList = const [],
  });

  @override
  State<TOrderListItems> createState() => _TOrderListItemsState();
}

class _TOrderListItemsState extends State<TOrderListItems> {
  int extend = -1;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.productList.length,
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwItems,
      ),
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
                const Icon(Iconsax.box),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),

                /// status and date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Requested Approval',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(widget.productList[index].productName,
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            /// Row - 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// icon
                      const Icon(Iconsax.tag),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),

                      /// status and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Price',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('₹ ${widget.productList[index].productPrice}',
                                style: Theme.of(context).textTheme.titleMedium),
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
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),

                      /// status and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Order Date :',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                                DateFormat('dd : MMM : yyyy').format(
                                    widget.productList[index].updatedAt),
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            // seller details
            Row(
              children: [
                /// icon
                const Icon(Iconsax.user),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),

                /// status and date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Seller',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(widget.productList[index].sellerName,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      extend = extend == index ? -1 : index;
                    });
                  },
                  icon: Icon(
                    extend == index ? Iconsax.arrow_up_2 : Iconsax.arrow_down_2,
                    size: TSizes.iconSm,
                  ),
                ),
              ],
            ),
            if (extend == index)
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            if (extend == index)
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        /// icon
                        const Icon(Iconsax.mobile),
                        const SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),

                        /// status and date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Contact',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(widget.productList[index].seller.userContact,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        /// icon
                        const Icon(Icons.email_outlined),
                        const SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),

                        /// status and date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Email',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(widget.productList[index].seller.userEmail,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
