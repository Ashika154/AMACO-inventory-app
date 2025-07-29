import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_dimensions.dart';
import '../../../core/custom_widgets/custom_text.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget ordersListing(String order){
      String buttonText ='';
      VoidCallback onPressed = () {} ;
      if(order == 'active'){
        buttonText = 'Track Order';
      }
      else if (order == 'completed'){
        buttonText = 'Leave Review';
        onPressed = ()=>context.pushNamed(RouteName.leaveReviewScreen);
      }
      else{
        buttonText = 'Re-Order';
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: ListView.builder(
                itemCount: 3,
               shrinkWrap: true,
               itemBuilder: (BuildContext context, int index) {
                  return  Column(
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
                                            onPressed: onPressed,
                                            fontSize:(order == 'completed' && size.width<390)?AppFontSize.s10 :AppFontSize.s12,
                                            text: buttonText,
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
                      15.height
                    ],
                  );
               },
        ),
      );
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Orders',
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal:20,vertical: 15 ),
                child: Material(
                  color: AppColors.primaryColor,
                  child: TabBar(
                      indicatorWeight: 5.0,
                      tabs: [
                        Tab(
                          text: 'Active',
                        ),
                        Tab(
                          text: 'Completed',
                        ),
                        Tab(
                          text: 'Cancelled',
                        )
                      ]
                  ),
                ),
            ),
            Expanded(
                child: TabBarView(
                    children: [
                      ordersListing('active'),
                      ordersListing('completed'),
                      ordersListing('cancelled'),
                    ]
                ))
          ],
        ),
      ),
    );

  }
}
