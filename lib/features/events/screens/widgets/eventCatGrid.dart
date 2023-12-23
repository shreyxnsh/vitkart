import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/events/screens/widgets/eventCatCard.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class TEventCategoryGrid extends StatelessWidget {
  const TEventCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 12.0, // Add spacing between items horizontally
      mainAxisSpacing: 16.0,
      padding: const EdgeInsets.all(0),
      children: [
        TEventCategoryCard(
          image: TImages.codingIcon,
          title: "Coding",
          onPressed: () {
            Get.to(const LoginScreen());
          },
        ),
        TEventCategoryCard(
          image: TImages.culturalIcon,
          title: "Cultural",
          onPressed: () {
            Get.to(const LoginScreen());
          },
        ),
        TEventCategoryCard(
          image: TImages.guestIcon,
          title: "Guest Speaker",
          onPressed: () {
            Get.to(const LoginScreen());
          },
        ),
        TEventCategoryCard(
          image: TImages.danceIcon,
          title: "Dance",
          onPressed: () {
            Get.to(const LoginScreen());
          },
        ),
        TEventCategoryCard(
          image: TImages.musicIcon,
          title: "Music",
          onPressed: () {
            Get.to(const LoginScreen());
          },
        ),
        TEventCategoryCard(
          image: TImages.dramaIcon,
          title: "Drama",
          onPressed: () {
            Get.to(const LoginScreen());
          },
        ),
      ],
    );
  }
}