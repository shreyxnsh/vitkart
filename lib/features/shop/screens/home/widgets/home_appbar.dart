import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class ThemeHomeAppBar extends StatelessWidget {
  const ThemeHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the token from GetStorage
    final storedToken = GetStorage().read('token');

    // Define an empty userName
    String userName = UserDataService.getUserName();


    return TAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: TColors.grey)),
          Text(
            userName, // Display the userName here
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.white),
          ),
        ],
      ),
    );
  }
}
