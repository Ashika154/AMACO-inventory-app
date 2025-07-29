import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text_form_field.dart';
import 'package:amaco_app/feature/my_orders/controller/my_order_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/custom_text.dart';
import '../../../core/routes/route_name.dart';

class LeaveReviewScreen extends StatelessWidget {
  const LeaveReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final myOrderController = Provider.of<MyOrderController>(context);
    void showSecondBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: true,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Column(
                    spacing: 30,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Icon(
                          Icons.star,
                          size: 50,
                          color: AppColors.orangeF99125,
                        ),
                        CustomText(
                          text: 'Review Submitted ',
                          fontSize: AppFontSize.s20,
                          fontWeight: AppFontWeight.w700,
                        ),
                      CustomText(
                        text: 'Thank you for your feedback!',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      )
                    ],
                  ),
                ),
              )
      ).then((value){
        myOrderController.showReviewSubmitSuccess();
      });
    }
    Widget content(){
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Leave Review',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              spacing: 15,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.secondaryColor
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child:Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Container(
                            width: size.width<=390?80:100,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                  fit: BoxFit.cover,
                                  ReImages.cementProductDetail),
                            ),
                          ),
                          11.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: size.width<=390? 100:120
                                ),
                                child: CustomText(
                                  text: 'SRC Cement',
                                  fontSize: size.width<=390?AppFontSize.s14 :AppFontSize.s16,
                                  fontWeight: AppFontWeight.w700,
                                ),
                              ),
                              5.height,
                              CustomText(
                                  text: 'Cement',
                                  fontSize: AppFontSize.s14,
                                  fontWeight: AppFontWeight.w400
                              ),
                              20.height,
                              Row(
                                spacing: 30,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "AED",
                                        fontSize: AppFontSize.s14,
                                        fontWeight: AppFontWeight.w700,
                                      ),
                                      5.width,
                                      CustomText(
                                        text:'25', //item['aed'].toString(),
                                        fontSize: AppFontSize.s14,
                                        fontWeight: AppFontWeight.w700,
                                      ),
                                      CustomText(
                                        text:'/bag', //"/${item['name']}",
                                        fontSize: AppFontSize.s12,
                                        fontWeight: AppFontWeight.w500,
                                        color: AppColors.greyText,
                                      ),
                                    ],
                                  ),
                                  AppButton(
                                    cornerRadius: 10,
                                    fontSize:(size.width<390)?AppFontSize.s10 :AppFontSize.s12,
                                    text: 'Re-Order',
                                    width: size.width<390?80 :100,
                                    height: 35,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                35.height,
                CustomText(
                  text: 'How is your order?',
                  fontSize: AppFontSize.s20,
                  fontWeight: AppFontWeight.w500,
                ),
                Row(
                  spacing: 3,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index){
                    return GestureDetector(
                      onTap: (){
                        if(myOrderController.previousRating>index ){
                          myOrderController.changeRating(index);
                        }
                        else{
                          myOrderController.setRating(index);
                        }
                      },
                      child: Icon(
                        (myOrderController.rating > index ) ?Icons.star_purple500_sharp:Icons.star_border_outlined,
                        size: 40,
                        color: AppColors.orangeF99125,
                      ),
                    );
                  }),
                ),
                15.height,
                SizedBox(
                  height: 150,
                  child: CustomTextFieldWidget(
                    borderColor: AppColors.greyText,
                    inputType: TextInputType.text,
                    maxLines: 20,
                    hintText: 'Add a comment',
                  ),
                ),
                100.height,
                Row(
                  spacing: 20,
                  children: [
                    Flexible(
                      child: AppButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          color: AppColors.primaryColor,
                          textColor: AppColors.secondaryColor,
                          border: Border.all(
                              color: AppColors.secondaryColor
                          ),
                          text: 'Cancel'),
                    ),
                    Flexible(
                      child: AppButton(
                          onPressed: (){showSecondBottomSheet(); myOrderController.showReviewSubmitSuccess();},
                          text: 'Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return myOrderController.reviewSubmitSuccess?Blur(child: content()): content();
  }
}
