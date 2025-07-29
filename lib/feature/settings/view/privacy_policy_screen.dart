import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy Policy',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            spacing: 20,
            children: [
              CustomText(
                fontWeight: AppFontWeight.w400,
                fontSize: AppFontSize.s14,
                textAlign: TextAlign.justify,
                text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vulputate quis ante a vulputate. Sed maximus pellentesque arcu. Phasellus arcu justo, sagittis nec rhoncus at, vehicula aliquam massa. Cras vel est at nisl semper accumsan id vel nisi. Quisque id vulputate libero. Nulla ex augue, sagittis sit amet nisi a, hendrerit ultricies tortor. Suspendisse metus nunc, aliquam sed augue posuere, dignissim mollis tellus. Nam nec ex vel sapien'
              ),
              CustomText(
                  fontWeight: AppFontWeight.w400,
                  fontSize: AppFontSize.s14,
                  textAlign: TextAlign.justify,
                  text: 'Praesent at turpis vel ipsum mollis mollis sit amet a erat. Integer aliquam, sem et congue mollis, augue sem condimentum augue, nec euismod justo tellus sollicitudin libero. Morbi cursus luctus blandit. Nam at ultricies diam, sed rhoncus libero. Nam sit amet erat mi. Suspendisse accumsan nulla diam, vel finibus dolor tincidunt quis. Cras at massa at sapien tincidunt tempor a vitae ex. Mauris in urna porttitor, tristique urna id, accumsan eros. Fusce imperdiet tincidunt sagittis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer blandit libero fermentum orci faucibus venenatis id eu lorem. Mauris id suscipit dui. Fusce la',
              ),
              CustomText(
                fontWeight: AppFontWeight.w400,
                fontSize: AppFontSize.s14,
                textAlign: TextAlign.justify,
                text: 'Duis imperdiet fringilla nulla, a pellentesque sem tempus ut. Phasellus rhoncus iaculis aliquam. Proin hendrerit porttitor leo, eu molestie felis congue ut. Quisque ultricies a lectus at elementum. Fusce dapibus lacus ut lectus imperdiet mattis. Vestibulum accumsan leo id mi elementum, a ullamcorper nisl suscipit. Aliquam rhoncus ipsum est, mollis ullamcorper libero elementum vel. Proin est lacus, tempus eu orci non, ullamcorper pellentesque arcu. Aliquam suscipit iaculis aliquam. Interdum et malesuada fames ac ante ipsum p',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
