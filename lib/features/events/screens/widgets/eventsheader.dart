import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';

class TEventsHeader extends StatelessWidget {
  const TEventsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
                Image.asset(
                  'assets/images/content/headerBgimg.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 50, // Adjust the top position based on your preference
                  left: 20, // Adjust the left position based on your preference
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Events 🎉',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                      ),
                      
                    ],
                  ),
                ),
                const Positioned(
                  top: 100, // Adjust the top position based on your preference
                  left: 10, // Adjust the left position based on your preference
                  right: 10, // Adjust the left position based on your preference
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSearchContainer(text: "Search Events" , icon: Iconsax.search_normal,)
                      
                    ],
                  ),
                ),
              ],
    );
  }
}