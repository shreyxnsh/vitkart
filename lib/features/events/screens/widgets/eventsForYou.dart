import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:t_store/features/events/screens/widgets/discount.dart';
import 'package:t_store/utils/constants/colors.dart';

class EventsForYouList extends StatelessWidget {
  final List<Map<String, dynamic>> groomingData = [
    {
      'discount': 'Flat 20% off',
      'eventName': 'Garba Event',
      'clubName': 'Gujrati Club',
      'venue': 'Auditorium',
     
      'datetime': '07 Jan 2024 - 10:00 AM',
      'backgroundImage': 'assets/images/content/event1.png',
      'ticketPrice': '500',
    },
    {
      'discount': '5% off on 3+ services',
      'eventName': 'AI Conclave',
      'clubName': 'AI Club',
      'venue': 'MPH',
      
      'datetime': '09 Jan 2024 - 11:00 AM',
      'backgroundImage': 'assets/images/content/event2.png',
      'ticketPrice': '200',
    },
    {
      'discount': 'Flat 20% off',
      'eventName': 'Garba Event',
      'clubName': 'Gujrati Club',
      'venue': 'Auditorium',
     
      'datetime': '07 Jan 2024 - 10:00 AM',
      'backgroundImage': 'assets/images/content/event1.png',
      'ticketPrice': '500',
    },
    // Add more grooming data as needed
  ];

   EventsForYouList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: groomingData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: EventForYouCard(data: groomingData[index]),
          );
        },
      ),
    );
  }
}

class EventForYouCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const EventForYouCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      
      decoration: BoxDecoration(
        color: TColors.lightDarkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section with Background Image
          Container(
            margin: const EdgeInsets.only(top : 10),
            width: double.infinity,
            height: 150, // Set the desired height for the background image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              
            ),
            child: Image.asset(
              data['backgroundImage'],
              
            ),
          ),

          // Bottom Section with Event Details
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: TColors.lightDarkBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                color: TColors.lightDarkBackground,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      data['eventName'],
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                            "₹ " + data['ticketPrice'],
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.primary),
                          ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  data['clubName'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                Text(
                      data['datetime'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                Text(
                      data['venue'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}