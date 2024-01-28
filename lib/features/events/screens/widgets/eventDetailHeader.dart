import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/curved_edges/curved_edges_widget.dart';

import '../../../../utils/constants/colors.dart';

class TEventHeaderContainer extends StatelessWidget {
  const TEventHeaderContainer({
    this.image,
    super.key,
    required this.child,
    this.height,
  });

  final Widget child;
  final double? height;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        height: height,
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: image ??
                  "https://cdn.vectorstock.com/i/preview-1x/82/99/no-image-available-like-missing-picture-vector-43938299.jpg",
              fit: BoxFit.fill,
              width: double.infinity,
              height: height,
              placeholder: (context, url) => Container(
                // Add a placeholder widget if needed
                color: Colors.grey, // Placeholder background color
              ),
              errorWidget: (context, url, error) => Container(
                // Add an error widget if needed
                color: Colors.red, // Error background color
                child: Icon(Icons.error),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
