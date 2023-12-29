import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/features/personalization/screens/profile/profile.dart';
import 'package:vitkart/utils/API/userDataService.dart';

import '../../../utils/constants/colors.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;



  @override
  Widget build(BuildContext context) {


    // Define an empty userName
    String userName = UserDataService.getUserName();
    String userEmail = UserDataService.getUserEmail();


    
    
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/content/user.png'),
      ),
      title: Text(
        userName,
        style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: TColors.white,
            ),
      ),
      subtitle: Text(
        userEmail,
        style: Theme.of(context).textTheme.bodyMedium!.apply(
              color: TColors.white,
            ),
      ),
      trailing: IconButton(
        onPressed: () {
          Get.to(() => const ProfileScreen());
        },
        icon: const Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
