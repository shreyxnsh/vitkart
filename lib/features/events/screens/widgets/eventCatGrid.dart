import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/features/events/screens/categoryScreens/eventCategoryScreen.dart';
import 'package:vitkart/features/events/screens/categoryScreens/culturalScreen.dart';
import 'package:vitkart/features/events/screens/categoryScreens/danceScreen.dart';
import 'package:vitkart/features/events/screens/categoryScreens/dramaScreen.dart';
import 'package:vitkart/features/events/screens/categoryScreens/guestSpeakerScreen.dart';
import 'package:vitkart/features/events/screens/categoryScreens/musicScreen.dart';
import 'package:vitkart/features/events/screens/widgets/eventCatCard.dart';
import 'package:vitkart/utils/constants/image_strings.dart';

class TEventCategoryGrid extends StatelessWidget {
  const TEventCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> groomingData = [
      {
        'discount': 'OD Provided',
        'eventName': 'New Year 2024',
        'clubName': 'VIT Bhopal',
        'venue': 'Auditorium',
        'datetime': ' 01 Jan 2024 - 10:00 AM',
        'backgroundImage': 'assets/images/content/popular1.png',
        'ticketPrice': '500',
      },
      {
        'discount': 'Full Day OD',
        'eventName': 'AI Conclave',
        'clubName': 'AI Club',
        'venue': 'MPH',
        'datetime': '09 Jan 2024 - 11:00 AM',
        'backgroundImage': 'assets/images/content/popular2.png',
        'ticketPrice': '200',
      },
      {
        'discount': 'OD Not Provided',
        'eventName': 'New Year 2024',
        'clubName': 'VIT Bhopal',
        'venue': 'Auditorium',
        'datetime': ' 01 Jan 2024 - 10:00 AM',
        'backgroundImage': 'assets/images/content/popular1.png',
        'ticketPrice': '500',
      },
      {
        'discount': 'OD Provided',
        'eventName': 'New Year 2024',
        'clubName': 'VIT Bhopal',
        'venue': 'Auditorium',
        'datetime': ' 01 Jan 2024 - 10:00 AM',
        'backgroundImage': 'assets/images/content/popular1.png',
        'ticketPrice': '500',
      },
      {
        'discount': 'Full Day OD',
        'eventName': 'AI Conclave',
        'clubName': 'AI Club',
        'venue': 'MPH',
        'datetime': '09 Jan 2024 - 11:00 AM',
        'backgroundImage': 'assets/images/content/popular2.png',
        'ticketPrice': '200',
      },
      {
        'discount': 'OD Not Provided',
        'eventName': 'New Year 2024',
        'clubName': 'VIT Bhopal',
        'venue': 'Auditorium',
        'datetime': ' 01 Jan 2024 - 10:00 AM',
        'backgroundImage': 'assets/images/content/popular1.png',
        'ticketPrice': '500',
      },
      // Add more grooming data as needed
    ];
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
            Get.to(EventCategoryScreen(
              data: groomingData,
              categoryName: "Coding",
            ));
          },
        ),
        TEventCategoryCard(
          image: TImages.culturalIcon,
          title: "Cultural",
          onPressed: () {
            Get.to(EventCategoryScreen(
              data: groomingData,
              categoryName: "Cultural",
            ));
          },
        ),
        TEventCategoryCard(
          image: TImages.guestIcon,
          title: "Guest Speaker",
          onPressed: () {
            Get.to(EventCategoryScreen(
              data: groomingData,
              categoryName: "Guest Speaker",
            ));
          },
        ),
        TEventCategoryCard(
          image: TImages.danceIcon,
          title: "Dance",
          onPressed: () {
            Get.to(EventCategoryScreen(
              data: groomingData,
              categoryName: "Dance",
            ));
          },
        ),
        TEventCategoryCard(
          image: TImages.musicIcon,
          title: "Music",
          onPressed: () {
            Get.to(EventCategoryScreen(
              data: groomingData,
              categoryName: "Music",
            ));
          },
        ),
        TEventCategoryCard(
          image: TImages.dramaIcon,
          title: "Drama",
          onPressed: () {
            Get.to(EventCategoryScreen(
              data: groomingData,
              categoryName: "Drama",
            ));
          },
        ),
      ],
    );
  }
}
