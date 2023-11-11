import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:t_store/common/widgets/images/t_circular.image.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/products/products_cart/cart_menu_item.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/common/widgets/text/t_brand_title_with_verifiedicon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Store', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: false,
        actions: [
        TCartCounterIcon(onPressed: (){}, iconColor: dark ?  TColors.white : TColors.black,)
      ]),
      body: NestedScrollView(
          headerSliverBuilder: (_,innerBoxIsScrolled){
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,
                automaticallyImplyLeading: false,

                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [

                      /// search bar
                      SizedBox(height: TSizes.spaceBtwItems,),
                      TSearchContainer(text: 'Search in Store', showBorder: true, icon: Iconsax.search_normal, padding: EdgeInsets.zero,),
                      SizedBox(height: TSizes.spaceBtwSections,),

                      /// featured
                      TsectionHeading(title: 'Featured Brands', showActionButton: true,),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5,),

                      TGridLayout(itemCount: 4, mainAxisExtend: 80, itemBuilder: (_, index){
                        return GestureDetector(
                        onTap: (){},
                        child: TRoundedContainer(
                          padding: const EdgeInsets.all(TSizes.sm),
                          showBorder: true,
                          backgroundColor: Colors.transparent,
                          child: Row(
                            children: [
                              Flexible(

                                child: TCircularImage(
                                  dark: dark,
                                  isNetworkImage: false,
                                  backgroundColor: Colors.transparent,
                                  overlayColor: dark ? TColors.white : TColors.black, 
                                  image: TImages.clothIcon,
                                  ),
                              ),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems/2,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TBrandTitleWithVerifiedIcon(
                                            title: 'Nike',
                                            brandTextSizes: TextSizes.large,
                                          ),
                                          Text(
                                            '256 Products',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.labelMedium,
                                          )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        
                        ),
                        );
                      })
                    
                    ],
                  ),
                ),
              )
            ];
          }, 
          body: Container(

          ))
      );
  }
}

