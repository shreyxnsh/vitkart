import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/events/screens/widgets/tEventCategoryCard.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/constants/check_mark_indicator.dart';
import 'package:vitkart/utils/constants/colors.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class EventCategoryScreen extends StatefulWidget {
  const EventCategoryScreen(
      {Key? key, required this.data, required this.categoryName})
      : super(key: key);

  final List<Map<String, dynamic>> data;
  final String categoryName;

  @override
  _EventCategoryScreenState createState() => _EventCategoryScreenState();
}

class _EventCategoryScreenState extends State<EventCategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.data.shuffle();
  }

  var _forceRefresh = Object();

  Future<Map<String, dynamic>> fetchAllAdvitiyaEvents() async {
    Map<String, dynamic> response = await APIFunctions.getEvents(
        category: widget.categoryName.split(' ').first.toLowerCase());
    // await Future.delayed(Duration(seconds: 2));
    if (response['isSuccess']) {
      return response;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('${widget.categoryName} Events',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: FutureBuilder(
        key: ValueKey(_forceRefresh),
        future: fetchAllAdvitiyaEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Shimmer.fromColors(
                      baseColor: TColors.lightDarkBackground.withOpacity(0.4),
                      highlightColor: TColors.grey.withOpacity(0.18),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        height: 240,
                        width: double.infinity,
                        child: TEventCategoryCard(
                          data: widget.data[0],
                        ),
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
          log("code : ${snapshot.requireData.toString()}");
          return screenUI(snapshot.requireData['events']);
        },
      ),
    );
  }

  Widget screenUI(List data) {
    log("code : ${data.toString()}");
    return CheckMarkIndicator(
      onRefresh: () async {
        setState(() {
          _forceRefresh = Object();
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              data.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 18),
                height: 240,
                width: double.infinity,
                child: TEventCategoryCard(
                  data: data[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
