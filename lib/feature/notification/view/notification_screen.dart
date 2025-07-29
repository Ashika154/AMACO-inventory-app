import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> data = [
      {
        "title":"Product Delivered",
        "description":"Your SRC Cement (Qty: 20) has been delivered. Thank you for your order! You are requested to share your review with us.",
        "hours":"2h",
        "date":"31/05/2025",
      },
      {
        "title":"Order Placed",
        "description":"Your SRC Cement (Qty: 20) has been placed successfully. We'll update you as it progresses.",
        "hours":"10d",
        "date":"19/05/2025"
      },
      {
        "title":"Order Shipped",
        "description":"Your SRC Cement (Qty: 20) has been shipped. Tracking ID: TRK456789023.",
        "hours":"7d",
        "date":"21/05/2025"
      },
      {
        "title":"New Card Added",
        "description":"A new Visa card (** **** **** 4321) has been added to your account.",
        "hours":"10d",
        "date":"19/05/2025"
      },
      {
        "title":"In Progress",
        "description":"Your SRC Cement (Qty: 20) is being prepared for shipment.",
        "hours":"7d",
        "date":"11/05/2025"
      }
    ];


    data.sort((a,b)=> DateFormat('dd/MM/yy').parse(b['date']).compareTo(DateFormat('dd/MM/yy').parse(a['date'])) );

    final Map<String,List<Map<String,dynamic>>> groupedData = {};
    for(var item in data){
      groupedData.putIfAbsent(item['date'],()=>[]).add(item);
    }

    final List<Map<String,dynamic>> displayList = [];
    groupedData.forEach((date,items){
      displayList.add({'isHeader':true,'date':date});
      displayList.addAll(items.map((e)=>{'isHeader':false,...e}));
    });


    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notification',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: ListView.builder(
            itemCount: displayList.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
              final item = displayList[index];
              return  (item['isHeader'] == true )?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.height,
                  CustomText(
                    text:item['date'].toString().appFormatDate() ,
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.w500,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ):
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    ListTile(
                      leading:Container(
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: SvgPicture.asset(
                          item['title'].toString().setIcon()
                        )
                      ) ,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: item['title'],
                            fontSize: AppFontSize.s16,
                            fontWeight: AppFontWeight.w500,
                          ),
                          CustomText(
                            text: item['hours'],
                            fontSize: AppFontSize.s12,
                            fontWeight: AppFontWeight.w400,
                          )
                        ],
                      ),
                      subtitle: CustomText(
                        text: item['description'],
                        fontSize: AppFontSize.s12,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ),
                    if(item['title'].toString() == "Product Delivered" )...[
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppButton(
                          width: 100,
                          height: 35,
                          text: 'Leave Review',
                          fontSize: AppFontSize.s12,
                        ),
                      )
                    ],
                  ],
                ),
              ) ;
        }),
      ),
    );
  }
}

extension on String{
  String setIcon(){
    switch (this){
      case "Product Delivered":
        return AppIcons.notificationOrderDelivered;
      case "Order Placed":
        return AppIcons.notificationOrderPlaced;
      case "Order Shipped":
        return AppIcons.notificationOrderShipped;
      case "In Progress":
        return AppIcons.notificationOrderInProgress;
      case "New Card Added":
        return AppIcons.notificationNewCardAdded;
      default:
        return AppIcons.notificationOrderInProgress;
    }
  }

  String appFormatDate(){
    return DateFormat('dd MMM yyy').format(
        DateFormat("dd/MM/yyyy").parse(this)
    ).toString();
  }
}
