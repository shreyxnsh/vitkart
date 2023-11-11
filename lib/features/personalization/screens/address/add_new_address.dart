import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Add a new Address', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name'),),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
        TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Contact Number'),),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
        TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.home), labelText: 'Room Number'),),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
        TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_34), labelText: 'Block'),),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
        TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'Hostel'),),
              const SizedBox(height: TSizes.defaultSpace,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(child: const Text('Save'), onPressed: (){},),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}