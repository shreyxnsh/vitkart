import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/image_text_widget/vertical_text_image.dart';
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
        itemCount: 6,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: TImages.shoeIcon,
            title: "Shoes",
            onTap: () {},
          );
        },
      ),
    );
  }
}
