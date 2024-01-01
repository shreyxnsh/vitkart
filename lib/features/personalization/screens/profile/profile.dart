import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('assets/images/content/user.png'),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile picture')),
                ]),
              ),

              ///Details
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Personal Information'),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                title: 'Name',
                value: UserDataService.getUserName(),
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Contact',
                value: '+91 9494315111',
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Date of Birth',
                value: UserDataService.getUserBirthDate(),
                onPressed: () {},
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'College Information'),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                title: 'Registration Number',
                value: UserDataService.getUserRegID(),
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Email',
                value: UserDataService.getUserEmail(),
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Year of Joining',
                value: UserDataService.getUserBatch().toString(),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
