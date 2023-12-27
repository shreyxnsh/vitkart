import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Books', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}

