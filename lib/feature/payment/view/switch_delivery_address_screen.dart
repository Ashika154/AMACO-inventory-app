import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/payment/controller/checkout_controller.dart';
import 'package:blur/blur.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_dimensions.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/custom_app_bar.dart';
import '../../../core/custom_widgets/custom_text.dart';


class SwitchDeliveryAddressScreen extends StatelessWidget {
  const SwitchDeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutController = Provider.of<CheckoutController>(context);
    void showSecondBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: true,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 249,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Column(
                    spacing: 30,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Address Added Successfully!',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomText(
                          textAlign:  TextAlign.center,
                          text: 'Your new address has been saved.',
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ).then((_){
        checkoutController.showAddressAddedSuccess();
      });
    }
    Widget content(){
      return   Scaffold(
        appBar: CustomAppBar(
          title: 'Delivery Address',
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Consumer<CheckoutController>(
                builder: (context,controller,_) {
                  return Column(
                    spacing: 10,
                    children: [
                      Column(
                        children:List.generate(controller.deliveryAddress.length, (index){
                         final address = controller.deliveryAddress[index];
                          return CheckboxListTile(
                            value:address.isChecked,
                            title:  CustomText(
                              fontWeight: AppFontWeight.w700,
                              fontSize: AppFontSize.s14,
                              text: address.title,
                            ),
                            subtitle: CustomText(
                              fontWeight: AppFontWeight.w400,
                              fontSize: AppFontSize.s14,
                              text: address.subtitle,
                            ),
                            onChanged:(bool? value){
                              controller.toggleCheck(index);
                              },
                            secondary:SvgPicture.asset(
                                AppIcons.location
                            ),
                            checkboxShape:OutlinedBorder.lerp(
                                CircleBorder(),
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                0.5
                            ),
                            checkboxScaleFactor: 1.3,
                            activeColor: AppColors.green24AB38,
                          );
                        }),
                      ),
                      20.height,
                      GestureDetector(
                        onTap: (){
                          context.pushNamed(RouteName.addAddressScreen);
                          checkoutController.showAddressAddedSuccess();
                          showSecondBottomSheet();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(16),
                          color: AppColors.secondaryColor,
                          dashPattern: [6,3],
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: SizedBox(
                            width: 343,
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.secondaryColor,
                                  size:15 ,
                                ),
                                CustomText(
                                  text: 'Add Shipping Address',
                                  fontSize: AppFontSize.s16,
                                  fontWeight: AppFontWeight.w700,
                                  color: AppColors.secondaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
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
            text: 'Select',
            onPressed: (){
              context.pop();
            },
          ),
        ),
      );
    }
    return checkoutController.addressAddedSuccess?
          Blur(
              blur: 2.5,
              blurColor: AppColors.secondaryColor,
              child: content()
          )
        :content() ;
  }
}
