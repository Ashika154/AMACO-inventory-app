import 'package:blur/blur.dart';
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
import '../../../core/routes/route_name.dart';
import '../controller/profile_controller.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
                        text: 'Address Added Successfully!',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Your new address has been saved.?',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      )
                    ],
                  ),
                ),
              )
      ).then((_){
        profileController.showSaveAddressSuccess();
        profileController.fetchUserAddresses();
      });
    }
    void showFirstBottomSheet(addressId)async{
      await showModalBottomSheet(
          context: context,
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
                        text: 'Confirm Delete Address?',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Are you sure to delete this Address?',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(
                            child: AppButton(
                                onPressed: (){
                                  context.pop();
                                  profileController.showRemoveAddressSuccess();},
                                color: AppColors.primaryColor,
                                textColor: AppColors.secondaryColor,
                                border: Border.all(
                                    color: AppColors.secondaryColor
                                ),
                                text: 'Cancel'),
                          ),
                          Flexible(
                            child: AppButton(
                                onPressed: (){
                                  context.pop();
                                    profileController.deleteAddress(addressId);
                                  },
                                text: 'Remove'),
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
//profileController.fetchUserAddresses();
      return   Scaffold(
        appBar: CustomAppBar(
          title: 'Shipping Address',
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<ProfileController>(
                builder: (context,controller,_) {
                  return Column(
                    children: List.generate(
                        controller.getAddressList.length,
                        (index){
                          final address = controller.getAddressList[index];
                          return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10
                              ),
                              child: ListTile(
                                leading: SvgPicture.asset(
                                    AppIcons.location
                                ),
                                title: CustomText(
                                  fontWeight: AppFontWeight.w700,
                                  fontSize: AppFontSize.s14,
                                  text: address.addressType,
                                ),
                                subtitle: CustomText(
                                  fontWeight: AppFontWeight.w400,
                                  fontSize: AppFontSize.s14,
                                  text: "${address.address},${address.state},${address.city},${address.country},${address.pinNumber}",
                                ),
                                trailing:InkWell(
                                  onTap: (){
                                    showFirstBottomSheet(address.id);
                                    controller.showRemoveAddressSuccess();
                                    },
                                  child: SvgPicture.asset(
                                    AppIcons.deleteProduct,
                                    color: AppColors.black000000,
                                  ),
                                ),
                              )
                          );
                        }
                    ),
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
                context.pushNamed(RouteName.addAddressScreen);
              },
              text: 'Add Shipping Address'
          ),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(profileController.saveAddressSuccess){
        showSecondBottomSheet();
      }
    });
    return Consumer<ProfileController>(builder: (context,controller,_){
      return ( controller.saveAddressSuccess || controller.removeAddressSuccess )?Blur(
          blurColor: AppColors.secondaryColor,
          blur: 2.5,
          child: content()): content();
    });

  }
}
