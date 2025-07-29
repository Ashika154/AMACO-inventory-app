import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/helper/shared_preferences_helper.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/profile/controller/profile_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final List<Map<String,dynamic>> profileItems = [
      {
        "name":"Personal Data",
        "icon":AppIcons.person,
        "onPress":()=>context.pushNamed(RouteName.profileDataScreen)
      },
      {
        "name":"Settings",
        "icon":AppIcons.settings,
        "onPress":()=>context.pushNamed(RouteName.settingsScreen)

      },
      {
       "name":"Cards",
        "icon":AppIcons.notificationNewCardAdded,
        "onPress":()=>context.pushNamed(RouteName.cardsScreen)
      },
      {
        "name":"Shipping Address",
        "icon":AppIcons.building,
        "onPress":()=>context.pushNamed(RouteName.addressScreen)

      },
    ];

    String name = "";
    String email = "";
    String profile = "";

    final profileController = Provider.of<ProfileController>(context);

    void showSecondBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: true,
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
                        text: 'Sign Out',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Do you want to log out?',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(
                            child: AppButton(
                                onPressed: (){
                                  profileController.showSignOutSuccess();
                                  context.pop(context);
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
                                onPressed: (){
                                  Navigator.pop(context);
                                  context.pushNamed(RouteName.loginScreen);
                                  logout();
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


    Widget getContent(){
      final profileData = profileController.profileDataModel;
      if(profileData != null){
        name =  profileData.name;
        email = profileData.email;
        profile = profileData.profileImage!;
      }
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Profile',
          showBackButton: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              spacing: 30,
              children: [
                Center(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          if(profile.isNotEmpty)...[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 5
                                ),
                                shape: BoxShape.circle,
                              ),
                              child:ClipOval(
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  '${ConstantString.baseImageUrl}$profile',
                                  errorBuilder: (context,error,stackTrace){
                                    return Icon(
                                      Icons.error,
                                      color: AppColors.secondaryColor,
                                    );
                                  },
                                  loadingBuilder: (context,child,loadingProgress){
                                    if(loadingProgress == null) return child;
                                    return Center(child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),);
                                  },
                                ),
                              ) ,
                            ),
                          ]
                          else ...[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 5,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child:ClipOval(
                                child: Icon(
                                    size: 100,
                                    Icons.account_circle,
                                    color: AppColors.secondaryColor,
                                )
                              ) ,
                            ),
                          ],
                          Positioned(
                            top: 100,
                            left: 100,
                            child: CircleAvatar(
                              backgroundColor: AppColors.secondaryColor,
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColors.primaryWhite,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomText(
                        text: name,
                        fontWeight: AppFontWeight.w700,
                        fontSize: AppFontSize.s20,
                      ),
                      CustomText(
                        text: email,
                        fontWeight: AppFontWeight.w400,
                        fontSize: AppFontSize.s16,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                    text: 'Profile',
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.w500,
                  ),
                ),
                Column(
                  children: profileItems.map((item){
                    return Column(
                      children: [
                        InkWell(
                          onTap:item['onPress'],
                          hoverColor: AppColors.secondaryColor,
                          child: ListTile(
                            leading: SvgPicture.asset(
                              width: 16,
                              height: 16,
                              item['icon'],
                            ),
                            title: CustomText(
                                fontWeight: AppFontWeight.w500,
                                fontSize: AppFontSize.s14,
                                text:  item['name'].toString()
                            ),
                            trailing: Icon(
                                size: 15,
                                Icons.arrow_forward_ios_rounded
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                    text: 'Support',
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.w500,
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: ()=>context.pushNamed(RouteName.helpAndSupportScreen),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          width: 16,
                          height: 16,
                          AppIcons.alert,
                        ),
                        title: CustomText(
                            fontWeight: AppFontWeight.w500,
                            fontSize: AppFontSize.s14,
                            text: 'Help & Support'
                        ),
                        trailing: Icon(
                            size: 15,
                            Icons.arrow_forward_ios_rounded
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=>context.pushNamed(RouteName.deleteAccountScreen),
                      hoverColor: AppColors.secondaryColor,
                      child: ListTile(
                        leading: SvgPicture.asset(
                          width: 16,
                          height: 16,
                          AppIcons.deleteProduct,
                        ),
                        title: CustomText(
                            fontWeight: AppFontWeight.w500,
                            fontSize: AppFontSize.s14,
                            text: 'Delete Account'
                        ),
                        trailing: Icon(
                            size: 15,
                            Icons.arrow_forward_ios_rounded
                        ),
                      ),
                    ),
                  ],
                ),
                AppButton(
                    onPressed: (){
                      showSecondBottomSheet();
                      profileController.showSignOutSuccess();
                    },
                    color: AppColors.primaryColor,
                    textColor: AppColors.secondaryColor,
                    fontSize: 16,
                    border: Border.all(
                        color: AppColors.secondaryColor
                    ),
                    prefix:Icon(
                        color: AppColors.secondaryColor,
                        size: 16,
                        Icons.logout) ,
                    text: 'Sign Out'
                )
              ],
            ),
          ),
        ),
      );
    }

    return Consumer<ProfileController>(
      builder: (context,controller,_) {
        return controller.clickSignOutSuccess?
            getContent()
        :Blur(
          blur: 2.5,
          blurColor: AppColors.secondaryColor,
          child: getContent(),
        );
      }
    );
  }
}

