import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/custom_widgets/custom_text.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.showMultipleDetails});
  final bool showMultipleDetails;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map<String,dynamic>> orderStages = [
      {
        "name":"Order Placed",
        "dateTime":"25 Jul 2025, 04:25 PM",
        "status":true
      },
      {
        "name":"In Progress",
        "dateTime":"Expected 26 Jul 2025",
        "status":false
      },
      {
        "name":"Shipped",
        "dateTime":"Expected 27 Jul 2025",
        "status":false
      },
      {
        "name":"Delivered",
        "dateTime":"Expected 03 Aug 2025",
        "status":false
      },
    ];

    List<String> orderStageIcons = [
      AppIcons.notificationOrderPlaced,
      AppIcons.notificationOrderInProgress,
      AppIcons.notificationOrderShipped,
      AppIcons.notificationOrderDelivered
    ];

    return
      Scaffold(
      appBar: CustomAppBar(
        title: 'Order Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              if(showMultipleDetails == false)...[
                Column(
                  spacing: 10,
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
                                    spacing:size.width<390?78:90,
                                    children: [
                                      CustomText(
                                          text: "AED 290",
                                          fontSize:size.width<=390?AppFontSize.s14 : AppFontSize.s16,
                                          fontWeight: AppFontWeight.w700
                                      ),
                                      Row(
                                        spacing: 6,
                                        children: [
                                          CustomText(
                                            text: 'Qty:',
                                            fontWeight: AppFontWeight.w500,
                                            fontSize: AppFontSize.s14,
                                            color: AppColors.violetB0A4B4,
                                          ),
                                          CustomText(
                                            text: '20',
                                            fontWeight: AppFontWeight.w700,
                                            fontSize: AppFontSize.s14,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            CustomText(
                              text: 'Note:',
                              fontSize: AppFontSize.s14,
                              fontWeight: AppFontWeight.w500,
                            ),
                            CustomText(
                              text: 'No cancellation after \'In Progress\'',
                              fontSize: AppFontSize.s14,
                              fontWeight: AppFontWeight.w400,
                            ),
                            AppButton(
                              text: 'Cancel Order',
                              width: size.width<390?50:100,
                              height:size.width<390?25 :35,
                              fontSize: size.width<390?6 :12,
                              onPressed: ()=>context.pushNamed(RouteName.cancelOrderScreen),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                10.height,
              ],
                CustomText(
                  text: 'Order Details',
                  fontSize: AppFontSize.s17,
                  fontWeight: AppFontWeight.w500,
                ),
                Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: CustomText(
                              text: 'Expected Delivery Date',
                              fontWeight: AppFontWeight.w400,
                              fontSize: AppFontSize.s14,
                              color: AppColors.violetB0A4B4,
                            )
                        ),
                        Flexible(
                            child: CustomText(
                              text: '03 Aug 2025',
                              fontWeight: AppFontWeight.w400,
                              fontSize: AppFontSize.s14,
                            )
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: CustomText(
                              text: 'Tracking ID',
                              fontWeight: AppFontWeight.w400,
                              fontSize: AppFontSize.s14,
                              color: AppColors.violetB0A4B4,
                            )
                        ),
                        Flexible(
                            child: CustomText(
                              text: 'TRK456789023',
                              fontWeight: AppFontWeight.w400,
                              fontSize: AppFontSize.s14,
                            )
                        )
                      ],
                    )
                  ],
                ),
                20.height,
                CustomText(
                  text: 'Delivery Address',
                  fontSize: AppFontSize.s17,
                  fontWeight: AppFontWeight.w500,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    AppIcons.location
                  ),
                  title: CustomText(
                    text: '123 Al Wasl Road, Villa 67,Al Wasl, Dubai',
                    fontSize: AppFontSize.s14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  subtitle: CustomText(
                    text: 'Home',
                    fontWeight: AppFontWeight.w400,
                    fontSize: AppFontSize.s12,
                    color: AppColors.violetB0A4B4,
                  ),
                ),
                CustomText(
                  text: 'Payment Method',
                  fontSize: AppFontSize.s17,
                  fontWeight: AppFontWeight.w500,
                ),
                ListTile(
                  leading: Image.asset(
                      ReImages.testBankIcon2
                  ),
                  title: CustomText(
                    text: 'Visa Classic',
                    fontSize: AppFontSize.s14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  subtitle: CustomText(
                    text: '**** 7690',
                    fontWeight: AppFontWeight.w400,
                    fontSize: AppFontSize.s12,
                    color: AppColors.violetB0A4B4,
                  ),
                ),
                CustomText(
                  text: 'Order Status',
                  fontSize: AppFontSize.s17,
                  fontWeight: AppFontWeight.w500,
                ),
                Row(
                  children: [
                    Column(
                      children: List.generate(7, (index){
                        if(index.isEven){
                          final stageIndex = index~/2;
                          final stage = orderStages[stageIndex];
                          if(stage['status']== true) {
                            return createCircle(circleColor: AppColors.green24AB38);
                          }
                          else{
                            return createCircle();
                          }
                        }
                        else{
                          return CustomPaint(
                            painter: LinePainter(),
                            size: Size(50, 40),
                          );
                        }
                      }),
                    ),
                    Flexible(
                      child: Column(
                        children: List.generate(7, (index){
                          if(index.isEven){
                            final stageIndex = index~/2;
                            final stage = orderStages[stageIndex];
                            return ListTile(
                              title: CustomText(
                                  fontWeight: AppFontWeight.w400,
                                  fontSize: AppFontSize.s14,
                                  text:  stage['name']
                              ),
                              subtitle:CustomText(
                                  fontWeight: AppFontWeight.w400,
                                  fontSize: AppFontSize.s14,
                                 color: AppColors.violetB0A4B4,
                                 text:  stage['dateTime']
                              ),
                              trailing: SvgPicture.asset(
                                width: 19,
                                height: 19,
                                orderStageIcons[stageIndex]
                              ),
                            );
                          }
                          return Container();
                        }),
                      ),
                    )
                  ],
                ),
                if(showMultipleDetails)...[
                  20.height,
                  Row(
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          CustomText(
                            text: 'Note:',
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.w500,
                          ),
                          CustomText(
                            text: 'No cancellation after \'In Progress\'',
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.w400,
                          ),
                          AppButton(
                            text: 'Cancel Order',
                            width: size.width<390?50:100,
                            height:size.width<390?25 :35,
                            fontSize: size.width<390?6 :12,
                            onPressed: ()=>context.pushNamed(RouteName.cancelOrderScreen),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(3,(index){
                      return Column(
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
                                          spacing: size.width<390? 78:90,
                                          children: [
                                            CustomText(
                                                text: "AED 290",
                                                fontSize:size.width<=390?AppFontSize.s14 : AppFontSize.s16,
                                                fontWeight: AppFontWeight.w700
                                            ),
                                            Row(
                                              spacing: 6,
                                              children: [
                                                CustomText(
                                                  text: 'Qty:',
                                                  fontWeight: AppFontWeight.w500,
                                                  fontSize: AppFontSize.s14,
                                                  color: AppColors.violetB0A4B4,
                                                ),
                                                CustomText(
                                                  text: '20',
                                                  fontWeight: AppFontWeight.w700,
                                                  fontSize: AppFontSize.s14,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          15.height,
                        ],
                      );
                    }),
                  )
                ]
              ],
            ),
        ),
      ),
    );
  }
  Widget createCircle ({Color? circleColor}){
    return Stack(
      alignment: Alignment.center,
      children:[
        CustomPaint(
          size: Size(50, 30),
          painter: CirclePainter(
            circleColor: circleColor
          ),
        ),
        Icon(
          Icons.check,
          color: AppColors.whiteF6F6F6,
        ),
      ]
    );
  }
}

class CirclePainter extends CustomPainter{
  CirclePainter({this.circleColor});

  Color? circleColor;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
        ..color = circleColor ?? AppColors.violetB0A4B4
        ..strokeWidth = 4
        ..style = PaintingStyle.fill;

    final radius = 15.0;
    final center = Offset(size.width/2,15);

    canvas.drawCircle(
        center,
        radius,
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class LinePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.violetB0A4B4
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset(size.width/2, 0),
        Offset(size.width/2, size.height),
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}