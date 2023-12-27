import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TEventPriceCard extends StatefulWidget {
  final String image;
  final String type;
  final String desc;
  final String price;
  final VoidCallback? onTap;

  const TEventPriceCard({
    Key? key,
    required this.image,
    required this.type,
    required this.desc,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  _TEventPriceCardState createState() => _TEventPriceCardState();
}

class _TEventPriceCardState extends State<TEventPriceCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? TColors.primary : (dark ? TColors.lightDarkBackground : TColors.light),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: isSelected ? 1 : 0, ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                widget.image,
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.type, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(widget.desc, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const Spacer(),
              Text(
                widget.price,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}