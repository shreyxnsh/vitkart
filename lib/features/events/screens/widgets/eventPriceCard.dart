import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TEventPriceCard extends StatelessWidget {
  final String image;
  final String type;
  final String desc;
  final String price;
  final VoidCallback? onTap;
  final bool isScelected;

  const TEventPriceCard({
    Key? key,
    required this.image,
    required this.type,
    required this.desc,
    required this.price,
    required this.isScelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isScelected
              ? TColors.primary
              : (dark ? TColors.lightDarkBackground : TColors.light),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: isScelected ? 1 : 0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                image,
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(desc, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const Spacer(),
              Text(
                price,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
