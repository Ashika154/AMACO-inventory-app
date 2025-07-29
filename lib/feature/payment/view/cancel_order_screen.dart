import 'package:amaco_app/feature/payment/controller/checkout_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_dimensions.dart';
import '../../../config/app_strings.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/custom_app_bar.dart';
import '../../../core/custom_widgets/custom_text.dart';
import '../../../core/custom_widgets/custom_text_form_field.dart';

class CancelOrderScreen extends StatelessWidget {
  const CancelOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final checkOutController = Provider.of<CheckoutController>(context);

    List<Map<String,dynamic>> reasons =[
      {
        'reasonId':1,
        'reasonContent':'Ordered by mistake'
      },
      {
        'reasonId':2,
        'reasonContent':'Found a better price elsewhere'
      },
      {
        'reasonId':3,
        'reasonContent':'Item no longer needed'
      },
      {
        'reasonId':4,
        'reasonContent':'Wrong item or quantity selected'
      },
      {
        'reasonId':5,
        'reasonContent':'Another reason'
      }
    ];

    void showSecondBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: true,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 230,
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
                        text: 'Order Cancelled',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomText(
                          textAlign:  TextAlign.center,
                          text: 'Your order has been successfully cancelled.',
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ).then((_){
        checkOutController.showCancelOrderSuccess();
      });
    }

    Widget content(){
      return Scaffold(
          appBar: CustomAppBar(
            title: 'Cancel Order',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    fontSize: AppFontSize.s14,
                    fontWeight: AppFontWeight.w500,
                    text: 'Why are you cancelling this order?',
                    fontFamily: ConstantString.appFontBold,
                  ),
                  Consumer<CheckoutController>(
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
                    text: 'Cancel Oder',
                    onPressed: () {
                      showSecondBottomSheet();
                      checkOutController.showCancelOrderSuccess();
                    }
                  )
                ],
              ),
            ),
          )
      );
    }

    return checkOutController.cancelOrderSuccess?
    Blur(
        blur: 2.5,
        blurColor: AppColors.secondaryColor,
        child: content()) :content();
  }
}
