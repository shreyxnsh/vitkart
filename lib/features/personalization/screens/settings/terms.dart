import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Terms & Conditions',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Legal",
                answer: "We are VITKart ('Company', 'we', 'us', or 'our'), a company registered in India at VITKart, VIT Bhopal University, Kothri - Kalan, Sehore, Madhya Pradesh 466114. \n\nWe operate the mobile application VITKart (the 'App'), as well as any other related products and services that refer or link to these legal terms (the 'Legal Terms') (collectively, the 'Services').",
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "VITKart Operations",
                answer: TTexts.vitkartOps,
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "User Representation",
                answer: "By using the Services, you represent and warrant that: (1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary; (3) you have the legal capacity and you agree to comply with these Legal Terms; (4) you are not a minor in the jurisdiction in which you reside; (5) you will not access the Services through automated or non-human means, whether through a bot, script or otherwise; (6) you will not use the Services for any illegal or unauthorised purpose; and (7) your use of the Services will not violate any applicable law or regulation. If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Services (or any portion thereof).",
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "User Registration",
                answer: "You may be required to register to use the Services. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable.",
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "User Data",
                answer: "We will maintain certain data that you transmit to the Services for the purpose of managing the performance of the Services, as well as data relating to your use of the Services. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Services. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data."
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Purchases & Payments",
                answer: "We accept the following forms of payment : \n\n Razorpay Payment Gateway \n\n You agree to provide current, complete, and accurate purchase and account information for all purchases made via the Services. You further agree to promptly update account and payment information, including email address, payment method, and payment card expiration date, so that we can complete your transactions and contact you as needed. Sales tax will be added to the price of purchases as deemed required by us. We may change prices at any time. All payments shall be in INR. \n You agree to pay all charges at the prices then in effect for your purchases and any applicable shipping fees, and you authorise us to charge your chosen payment provider for any such amounts upon placing your order. We reserve the right to correct any errors or mistakes in pricing, even if we have already requested or received payment. \n We reserve the right to refuse any order placed through the Services. We may, in our sole discretion, limit or cancel quantities purchased per person, per household, or per order. These restrictions may include orders placed by or under the same customer account, the same payment method, and/or orders that use the same billing or shipping address. \nWe reserve the right to limit or prohibit orders that, in our sole judgement, appear to be placed by dealers, resellers, or distributors."
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Cancellation",
                answer: "All purchases are non-refundable. You can cancel your tickets at any time by contacting us using the contact information provided below. Your cancellation will take effect at the end of the current paid term.\n\n If you are unsatisfied with our Services, please email us at support@vitkart.in"
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Refunds",
                answer: "In case of any purchase failures of the event tickets, please wait for 10 minutes until we remove your blocked spot so that you can buy the ticket again. \n\nIn case of payment completion but still no creation of tickets you may contact us at :\n\nrefunds@vitkart.in "
              ),
              
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Mobile Application License",
                answer: "Use License\n\nIf you access the Services via the App, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the App on wireless electronic devices owned or controlled by you, and to access and use the App on such devices strictly in accordance with the terms and conditions of this mobile application licence contained in these Legal Terms. You shall not: (1) except as permitted by applicable law, decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the App; (2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the App; (3) violate any applicable laws, rules, or regulations in connection with your access or use of the App; (4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the App; (5) use the App for any revenue-generating endeavour, commercial enterprise, or other purpose for which it is not designed or intended; (6) make the App available over a network or other environment permitting access or use by multiple devices or users at the same time; (7) use the App for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the App; (8) use the App to send automated queries to any website or to send any unsolicited commercial email; or (9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the App.\n"
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Advertisements",
                answer: "We allow advertisers to display their advertisements and other information in certain areas of the Services, such as sidebar advertisements or banner advertisements. We simply provide the space to place such advertisements, and we have no other relationship with advertisers."
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              EasyFaq(
                backgroundColor: TColors.lightDarkBackground,
                expandedIcon: Icon(Iconsax.minus),
                collapsedIcon: Icon(Iconsax.add),
                question: "Contact Us",
                answer: "In case of any difficulties or inconvenience caused, you can contact us via e-mail :\n\nsupport@vitkart.in\n"
              ),
            ],
          ),
        ),
      ),
    );
  }
}
