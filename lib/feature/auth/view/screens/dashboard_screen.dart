import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/custom_search.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';


class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});
  final List<String> carouselContent = [
      ReImages.carouselContent1,
    ReImages.carouselContent2
  ];

  final Map<String,String> categoriesList = {
    "Blocks":ReImages.categoryBlock,
    "Cement":ReImages.categoryCement,
    "Aggregates":ReImages.categoryAggregate
  };

  final Map<String,dynamic> allCategoriesList = {
    "Block":{
      "items" : {
      1 : {
        "image": ReImages.categoryBlock,
        "type":"4 Inc Hollow Block",
        "aed":3.5,
      },
      2 : {
        "image": ReImages.categoryBlock,
        "type":"6 Inc Hollow Block",
        "aed":4.5,
      },
      3 : {
        "image": ReImages.categoryBlock,
        "type":"8 Inc Hollow Block",
        "aed":3.5,
      },
      4 : {
        "image": ReImages.categoryBlock,
        "type":"4 Inc Solid Block",
        "aed":3.5,
      },
      6 : {
        "image": ReImages.categoryBlock,
        "type":"6 Inc Solid Block",
        "aed":3.5,
      }
    },
      "name":"block"
    },
    "Concrete":{
      "items":  {
      1 : {
        "image": ReImages.categoryCement,
        "type":"OPC Cement",
        "aed":10,
      },
      2 : {
        "image": ReImages.categoryCement,
        "type":"SRC Cement",
        "aed":12,
      },
    },
      "name":"bag"
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 52,horizontal: 20),
          child: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: CustomText(
                  text: 'Location',
                  fontWeight: AppFontWeight.w600,
                  fontSize: AppFontSize.s16,
                ),
                subtitle: Row(
                  spacing: 8,
                  children: [
                    CustomText(
                      text: 'Chennai, Tamilnadu',
                      fontWeight: AppFontWeight.w400,
                      fontSize: AppFontSize.s14,
                    ),
                    Icon(
                     Icons.keyboard_arrow_down_outlined,
                      size: 25,
                    )
                  ],
                ),
                trailing:InkWell(
                    onTap: ()=>context.pushNamed(RouteName.notificationScreen),
                    child: SvgPicture.asset(
                        AppIcons.dashboardNotification
                    )
                )
              ),
              SearchButton(),
              Column(
                children: [
                  Consumer<AuthController>(
                    builder: (context,controller,_){
                      return CarouselSlider(
                          items: carouselContent.map((item)=>
                              SizedBox(
                                  width:354 ,
                                  height: 207,
                                  child:Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                            fit: BoxFit.cover,
                                            item),
                                      ),
                                    ],
                                  ))
                          ).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index,reason){
                              controller.updateCarouselIndex(index);
                            }
                          )
                      );
                    },
                  ),
                  12.height,
                  Consumer<AuthController>(
                    builder: (context,controller,_){
                      return Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: carouselContent.asMap().entries.map((entry){
                            return GestureDetector(
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 4.0
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.currentIndex == entry.key ? AppColors.secondaryColor:AppColors.greyText
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              CustomText(
                text: 'Categories',
                fontSize: AppFontSize.s16,
                fontWeight: AppFontWeight.w600,
              ),
              Row(
                spacing: 20,
                children: categoriesList.entries.map((item){
                  return 
                    InkWell(
                      onTap: ()=>context.pushNamed(RouteName.productsListScreen,) ,
                      child: Column(
                      spacing: 10,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.secondaryColor
                            ),
                            borderRadius: BorderRadius.circular(75),
                          ),
                          width: 75,
                          height: 75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.asset(
                                item.value,
                                fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        CustomText(
                          text: item.key,
                          fontWeight: AppFontWeight.w500,
                          fontSize: AppFontSize.s14,
                        )
                      ],
                                        ),
                    );
                }).toList(),
              ),
              CustomText(
                text: 'All Categories',
                fontSize: AppFontSize.s16,
                fontWeight: AppFontWeight.w600,
              ),
              Column(
                children: allCategoriesList.entries.map((category){
                  final Map<int ,Map<String,dynamic>> items = category.value["items"];
                  return Column(
                    spacing: 20,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: category.key,
                            fontSize: AppFontSize.s16,
                            fontWeight: AppFontWeight.w500,
                          ),
                          InkWell(
                            onTap:()=>context.pushNamed(RouteName.productsListScreen),
                            child: CustomText(
                              text: 'See all',
                              fontSize: AppFontSize.s14,
                              fontWeight: AppFontWeight.w500,
                              color: AppColors.secondaryColor,
                            ),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 20,
                          children: items.entries.map((item)=> Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:()=> context.pushNamed(RouteName.productDetailsScreen,extra: false),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(item.value['image'])),
                                ),
                              ),
                              10.height,
                              CustomText(
                                text: item.value['type'],
                                fontSize: AppFontSize.s12,
                                fontWeight: AppFontWeight.w500,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: "AED",
                                    fontSize: AppFontSize.s14,
                                    fontWeight: AppFontWeight.w700,
                                  ),
                                  5.width,
                                  CustomText(
                                    text: item.value['aed'].toString(),
                                    fontSize: AppFontSize.s14,
                                    fontWeight: AppFontWeight.w700,
                                  ),
                                  CustomText(
                                    text: "/${category.value['name']}",
                                    fontSize: AppFontSize.s12,
                                    fontWeight: AppFontWeight.w500,
                                    color: AppColors.greyText,
                                  ),
                                ],
                              )
                            ],
                          )).toList(),
                        ),
                      ),
                      40.height
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
