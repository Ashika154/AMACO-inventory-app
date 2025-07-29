import 'package:amaco_app/feature/profile/model/add_address_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_dimensions.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/app_decorations.dart';
import '../../../core/custom_widgets/custom_app_bar.dart';
import '../../../core/custom_widgets/custom_text.dart';
import '../../../core/custom_widgets/custom_text_form_field.dart';
import '../../../core/routes/route_name.dart';
import '../controller/profile_controller.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  TextEditingController addressTypeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profileController = Provider.of<ProfileController>(context,listen:false);
    final savePrimaryAddress = context.watch<ProfileController>().savePrimaryAddress;

    Widget content(){
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Add Address',
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
                    'Address type'.makeLabel(),
                    CustomTextFieldWidget(
                        controller: addressTypeController,
                        hintText: 'Home,Company',
                        inputType: TextInputType.text,
                        onFieldSubmitted: (_)=>FocusScope.of(context).unfocus(),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Address'.makeLabel(),
                    CustomTextFieldWidget(
                        controller: addressController,
                        hintText: 'Address',
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
                          'State'.makeLabel(),
                          CustomTextFieldWidget(
                            controller: stateController,
                              hintText: 'State',
                              inputType: TextInputType.text),
                        ],
                      )),
                      Flexible(child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'City'.makeLabel(),
                          CustomTextFieldWidget(
                            controller: cityController,
                              hintText: 'City',
                              inputType: TextInputType.text),
                        ],
                      ))
                    ],
                  ),
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
                          'Country'.makeLabel(),
                          CustomTextFieldWidget(
                            controller: countryController,
                              hintText: 'Country',
                              inputType: TextInputType.text),
                        ],
                      )),
                      Flexible(child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Pin number'.makeLabel(),
                          CustomTextFieldWidget(
                              controller:pinNumberController ,
                              hintText: 'Pin number',
                              inputType: TextInputType.text),
                        ],
                      ))
                    ],
                  ),
                ),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Phone Number'.makeLabel(),
                    CustomTextFieldWidget(
                      controller: phoneNumberController,
                        hintText: 'Number',
                        inputType: TextInputType.number
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Save as primary address'.makeLabel(),
                      Switch(
                          value: savePrimaryAddress,
                          onChanged:(value){
                            profileController.clickPrimaryAddress(value);
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 18),
          width: size.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColor
          ),
          child: AppButton(
              onPressed: ()async{
               final response = await profileController.addAddress(
                  AddAddressModel(
                    addressType: addressController.text,
                    address: addressController.text,
                    state: stateController.text,
                    city: cityController.text,
                    country: countryController.text,
                    pinNumber: pinNumberController.text,
                    phoneNumber: phoneNumberController.text,
                    primaryAddress: savePrimaryAddress,
                  )
                );
               if(response!.success){
                 profileController.showSaveAddressSuccess();
                 context.pop();
               }
               else{
                 showSnackBar(context,response.message);
               }

              },
              text: 'Save Address'
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