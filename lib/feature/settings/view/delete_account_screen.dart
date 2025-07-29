import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/custom_widgets/custom_text_form_field.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/settings_controller.dart';


class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<Map<String,dynamic>> reasons =[
      {
        'reasonId':1,
        'reasonContent':'Found a better app/service'
      },
      {
        'reasonId':2,
        'reasonContent':'Prices are too high'
      },
      {
        'reasonId':3,
        'reasonContent':'Delivery issues or delays'
      },
      {
        'reasonId':4,
        'reasonContent':'Created account by mistake'
      },
      {
        'reasonId':5,
        'reasonContent':'Another reason'
      }
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Delete Account',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontWeight: AppFontWeight.w400,
                fontSize: AppFontSize.s14,
                text: 'Deleting your account will permanently remove all your data, order history, saved addresses, and payment methods. This action cannot be undone.',
              ),
              CustomText(
                fontSize: AppFontSize.s14,
                fontWeight: AppFontWeight.w500,
                text: 'Tell us why you\'re leaving',
                fontFamily: ConstantString.appFontBold,
              ),
              Consumer<SettingsController>(
                  builder:(context,controller,_){
                    return Column(
                      children: reasons.map((reason){
                        return RadioListTile(
                            title: CustomText(
                              fontWeight: AppFontWeight.w500,
                              fontSize: AppFontSize.s14,
                              text: reason['reasonContent'],
                            ),
                            value: reason['reasonId'],
                            activeColor: AppColors.secondaryColor,
                            groupValue: controller.selectedReason,
                            onChanged: (value){
                              if(value != null){
                                controller.updateSelectedReason(value);
                              }
                            }
                        );
                      }).toList()
                    );
                  }),
                SizedBox(
                  height: 250,
                  child: CustomTextFieldWidget(
                    maxLines: 7,
                      inputType: TextInputType.text,
                    hintText: 'Tell us Reason',
                  ),
                ),
              AppButton(
                  text: 'Delete Account',
                onPressed: ()=>context.pushNamed(RouteName.changePasswordVerificationScreen),
              )
            ],
          ),
        ),
      )
    );
  }
}


