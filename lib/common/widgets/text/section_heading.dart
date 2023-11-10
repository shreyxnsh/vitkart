import 'package:flutter/material.dart';

class TsectionHeading extends StatelessWidget {
  const TsectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTitile = "View all",
    this.onPressed,
  });
  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitile;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(buttonTitile),
          ),
      ],
    );
  }
}
