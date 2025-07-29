import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/profile/controller/profile_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/custom_widgets/app_decorations.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profileController = Provider.of<ProfileController>(context);
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
                        text: ' Card Added Successfully!',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Your new card has been saved.',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      )
                    ],
                  ),
                ),
              )
      ).then((_){
        profileController.showSaveCardSuccess();
        profileController.fetchUserCards();
      });
    }
    void showFirstBottomSheet(String cardId)async{
      await showModalBottomSheet(
          context: context,
          isDismissible: false,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 294,
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
                        text: 'Confirm Delete Card?',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Are you sure to delete this card?',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(
                            child: AppButton(
                                onPressed: (){context.pop();profileController.showRemoveCardSuccess();},
                                color: AppColors.primaryColor,
                                textColor: AppColors.secondaryColor,
                                border: Border.all(
                                    color: AppColors.secondaryColor
                                ),
                                text: 'Cancel'),
                          ),
                          Flexible(
                            child: AppButton(
                                onPressed: () async {
                                  final response = await profileController.deleteCard(
                                    cardId
                                  );
                                  if(response!.success){
                                    profileController.showRemoveCardSuccess();
                                    context.pop();
                                  }
                                  else{
                                    showSnackBar(context,response.message);
                                  }
                                  context.pop();
                                  },
                                text: 'Yes'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
      );
    }

    Widget content(){
      return   Scaffold(
        appBar: CustomAppBar(
          title: 'Cards',
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Consumer<ProfileController>(
              builder: (context,controller,_) {
                return Column(
                  spacing: 10,
                  children:List.generate(
                    controller.fetchUserCardsList.length,
                      (index)
                      {
                        final cardDetails = controller.fetchUserCardsList[index];
                        String cardNumber = cardDetails.cardNumber;
                        if(cardNumber.length >= 4){
                          cardNumber = cardNumber.substring(cardNumber.length -4);
                        }
                        return ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColors.secondaryColor,
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                          leading: Image.asset(
                            ReImages.testBankIcon1,
                          ),
                          title: CustomText(
                            fontWeight: AppFontWeight.w500,
                            fontSize: AppFontSize.s16,
                            text: '.... .... .... .... $cardNumber',
                          ),
                          trailing:InkWell(
                            onTap: (){
                              showFirstBottomSheet(cardDetails.id.toString());
                              controller.showRemoveCardSuccess();
                              },
                            child: SvgPicture.asset(
                              AppIcons.deleteProduct,
                              color: AppColors.black000000,
                            ),
                          ),
                        );
                      }
                  )
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
              onPressed: (){
                context.pushNamed(RouteName.addNewCardsScreen);
              },
              text: 'Add New Card'
          ),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(profileController.saveCardSuccess){
        showSecondBottomSheet();
      }
    });
    return Consumer<ProfileController>(builder: (context,controller,_){
      return ( controller.saveCardSuccess || controller.removeCardSuccess )?Blur(
          blurColor: AppColors.secondaryColor,
          blur: 2.5,
          child: content()): content();
    });

  }
}
