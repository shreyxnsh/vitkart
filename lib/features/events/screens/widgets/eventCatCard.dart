import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TEventCategoryCard extends StatelessWidget {
   const TEventCategoryCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String image;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color:  dark ? TColors.lightDarkBackground : TColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis, // Display ellipsis for overflow
              maxLines: 1, 
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
