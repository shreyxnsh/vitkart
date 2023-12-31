import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Add a new Address',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                
                decoration: const InputDecoration(
                  
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Contact Number'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.home), labelText: 'Room Number'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_34),
                    labelText: TTexts.block),
                onChanged: (value) {},
                items: [
                  'Block 1',
                  'Block 2',
                  'Block 3',
                  'Block 4',
                  'Block 5',
                ]
                    .map((option) =>
                        DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building),
                    labelText: TTexts.hostel),
                onChanged: (value) {},
                items: [
                  'Boys Hostel',
                  'Girls Hostel',
                ]
                    .map((option) =>
                        DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
