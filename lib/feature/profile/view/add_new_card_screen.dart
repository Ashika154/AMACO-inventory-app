import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text_form_field.dart';
import 'package:amaco_app/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_dimensions.dart';
import '../../../core/custom_widgets/app_decorations.dart';
import '../../../core/custom_widgets/custom_text.dart';
import '../model/card_model.dart';

class AddNewCardScreen extends StatelessWidget {
   AddNewCardScreen({super.key});

  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profileController = Provider.of<ProfileController>(context,listen:false);
    final saveToggleValue = context.watch<ProfileController>().savePrimaryCard;

    Widget content(){
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Add New Card',
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 15,
              children: [
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Card Holder’s Name'.makeLabel(),
                    CustomTextFieldWidget(
                        controller: cardHolderNameController,
                        hintText: 'Card Holder’s Name',
                        inputType: TextInputType.text),
                  ],
                ),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Card Number'.makeLabel(),
                    CustomTextFieldWidget(
                        hintText: 'Card Number',
                        controller: cardNumberController,
                        inputType: TextInputType.text),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'EXP'.makeLabel(),
                          CustomTextFieldWidget(
                              hintText: 'Exp',
                              controller: expiryDateController,
                              inputType: TextInputType.text),
                        ],
                      )),
                      Flexible(child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'CVV'.makeLabel(),
                          CustomTextFieldWidget(
                              hintText: 'Cvv',
                              controller: cvvController,
                              inputType: TextInputType.text),
                        ],
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Save as primary card'.makeLabel(),
                      Switch(
                          value: saveToggleValue,
                          onChanged:(value){
                            profileController.clickPrimaryCard(value);
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height-600,),
                  child: AppButton(
                      onPressed: () async {
                        final response = await profileController.addCard(
                            CardModel(
                              cardHolderName: cardHolderNameController.text,
                              cardNumber: cardNumberController.text,
                              cvv: cvvController.text,
                              expiryDate: expiryDateController.text,
                              primaryCard: saveToggleValue
                            )
                        );
                        if(response!.success){
                          profileController.showSaveCardSuccess();
                          context.pop();
                        }
                        else{
                          showSnackBar(context,response.message);
                        }
                      },
                        text: 'Save Card'),
                )
              ],
            ),
          ),
        ),
      );
    }
    return content();
  }
}

extension on String{
  Widget makeLabel(){
    return CustomText(
      text: this,
      fontSize: AppFontSize.s14,
      fontWeight: AppFontWeight.w500,
    );
  }
}