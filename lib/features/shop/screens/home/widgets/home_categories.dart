import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/image_text_widget/vertical_text_image.dart';
import 'package:t_store/features/shop/screens/categories/books_screen.dart';
import 'package:t_store/features/shop/screens/categories/bucket_screen.dart';
import 'package:t_store/features/shop/screens/categories/cycle_screen.dart';
import 'package:t_store/features/shop/screens/categories/mattress_screen.dart';
import 'package:t_store/features/shop/screens/categories/other_screen.dart';
import 'package:t_store/features/shop/screens/categories/tech_screen.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: categories[index].icon,
            backgroundColor: TColors.light,
            title: categories[index].title,
            onTap: categories[index].onTap,
          );
        },
      ),
    );
  }
}


class Category {
  final String title;
  final String icon;
 final VoidCallback? onTap;

  Category({required this.title, required this.icon, this.onTap});
}

List<Category> categories = [
  Category(
    title: "Tech",
    icon: TImages.techIcon,
    onTap: () {

      Get.to(()=> const TechScreen());
    },
  ),
  Category(
    title: "Cycles",
    icon: TImages.cycleIcon,
    onTap: () {

      Get.to(()=> const CycleScreen());
    },
  ),
  Category(
    title: "Mattresses",
    icon: TImages.mattressIcon,
    onTap: () {

      Get.to(()=> const MattressScreen());
    },
  ),
  Category(
    title: "Books",
    icon: TImages.bookIcon,
    onTap: () {
     
      Get.to(()=> const BookScreen());
    },
  ),
  Category(
    title: "Buckets",
    icon: TImages.bucketIcon,
    onTap: () {
      
      Get.to(()=> const BucketScreen());
    },
  ),
  Category(
    title: "Others",
    icon: TImages.othersIcon,
    onTap: () {
      
      Get.to(()=> const OtherScreen());
    },
  ),
  // Add more categories here
];