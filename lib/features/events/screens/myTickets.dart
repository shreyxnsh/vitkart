import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/widgets/eventTicketVertical.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/check_mark_indicator.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({
    super.key,
  });

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  var _forceRefresh = Object();

  @override
  void initState() {
    super.initState();
    fetchUserTickets();
  }

  Future<Map<String, dynamic>> fetchUserTickets() async {
    try {
      Map<String, dynamic> response = await APIFunctions.getUserTickets(
        UserDataService.getUserID(),
      );

      log("Data : ${response.toString()}");
      if (response['isSuccess']) {
        return response;
      }
    } catch (error) {
      log(error.toString());
      // Handle error
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "My Tickets",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: CheckMarkIndicator(
        onRefresh: () async {
          setState(() {
            _forceRefresh = Object();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                TSectionHeading(
                  title: "Upcoming",
                  textColor: TColors.primary,
                  showActionButton: false,
                ),
                FutureBuilder(
                  key: ValueKey(_forceRefresh),
                  future: fetchUserTickets(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      // shimmer
                      return Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              4,
                              (index) => Shimmer.fromColors(
                                baseColor: TColors.lightDarkBackground
                                    .withOpacity(0.4),
                                highlightColor: TColors.grey.withOpacity(0.18),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 18),
                                  height: 240,
                                  width: double.infinity,
                                  color: TColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // data call
                    return screenUI(snapshot.data!['tickets']);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView screenUI(List data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            data.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 18),
              // height: TSizes.displayHeight(context) * 0.147,
              width: double.infinity,
              child: EventTicketVertical(
                data: data[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
