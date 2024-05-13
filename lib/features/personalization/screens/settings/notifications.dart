import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                
              ],
            )),
      ),
    );
  }
}
