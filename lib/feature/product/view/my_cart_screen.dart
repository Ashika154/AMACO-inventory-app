import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/product/controller/products_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyCartScreen extends StatelessWidget {
   const MyCartScreen({super.key});


  @override
  Widget build(BuildContext context) {
    List <Map<String,dynamic>> cartList = [
      {
        "productImage":ReImages.cementProductDetail,
        "productName":"SRC Cement",
        "productCategory":"Cement",
        "productAed":12,
        "productType":"bag",
        "productQuantity":20
      },
      {
        "productImage":ReImages.categoryAggregate,
        "productName":"3/8 Aggregates 5-10mm",
        "productCategory":"Aggregates",
        "productAed":35,
        "productType":"ton",
        "productQuantity":5
      },
      {
        "productImage":ReImages.categoryBlock,
        "productName":"Blocks",
        "productCategory":"Blocks",
        "productAed":3.5,
        "productType":"block",
        "productQuantity":100
      }
    ];
    final size = MediaQuery.of(context).size;
    final productController = Provider.of<ProductsController>(context,listen: false);
    void showBottomSheet( )async{
      await showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.primaryColor,
          isDismissible: false,
          builder: (context)=>Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            width: size.width,
            height:366,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
                spacing: 25,
                children: [
                  CustomText(
                    text: 'Remove from Cart?',
                    fontWeight: AppFontWeight.w700,
                    fontSize: AppFontSize.s20,
                  ),
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
                                  spacing: 105,
                                  children: [
                                    CustomText(
                                        text: "AED 290",
                                        fontSize:size.width<=390?AppFontSize.s14 : AppFontSize.s16,
                                        fontWeight: AppFontWeight.w700
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: 'Qty:',
                                          fontSize: AppFontSize.s14,
                                          fontWeight: AppFontWeight.w500,
                                          color: AppColors.greyText,
                                        ),
                                        CustomText(
                                          text: '20',
                                          fontSize: AppFontSize.s14,
                                          fontWeight: AppFontWeight.w700,
                                        ),
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
                    spacing: 20,
                    children: [
                      Flexible(
                        child: AppButton(
                            onPressed: (){
                              Navigator.pop(context);
                              productController.showRemoveSubmitSuccess();
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
                              productController.showRemoveSubmitSuccess();
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
      return Scaffold(
        appBar: CustomAppBar(
          title: 'My Cart',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children:
                    List.generate(
                        cartList.length,
                            (index){
                          final item = cartList[index];
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
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
                                                    item['productImage']),
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
                                                    text: item['productName'],
                                                    fontSize: size.width<=390?AppFontSize.s14 :AppFontSize.s16,
                                                    fontWeight: AppFontWeight.w700,
                                                  ),
                                                ),
                                                5.height,
                                                CustomText(
                                                    text: item['productCategory'],
                                                    fontSize: AppFontSize.s14,
                                                    fontWeight: AppFontWeight.w400
                                                ),
                                                20.height,
                                                Row(
                                                  children: [
                                                    CustomText(
                                                        text: "AED ${item['productAed']}",
                                                        fontSize:size.width<=390?AppFontSize.s14 : AppFontSize.s16,
                                                        fontWeight: AppFontWeight.w700
                                                    ),
                                                    CustomText(
                                                      text: '/${item['productType']}',
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          spacing: 45,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                              InkWell(
                                                child: SvgPicture.asset(AppIcons.deleteProduct),
                                                onTap: ()async{
                                                  showBottomSheet();
                                                  productController.showRemoveSubmitSuccess();
                                                },
                                            ),
                                            Row(
                                              spacing: 10,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors.secondaryColor
                                                      ),
                                                      borderRadius: BorderRadius.circular(32)
                                                  ),
                                                  child:Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                                    child:Icon(
                                                        size: 16,
                                                        Icons.remove),
                                                  ),
                                                ),
                                                CustomText(
                                                  text: "${item['productQuantity']}",
                                                  fontWeight: AppFontWeight.w600,
                                                  fontSize: AppFontSize.s14,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors.secondaryColor
                                                      ),
                                                      borderRadius: BorderRadius.circular(32)
                                                  ),
                                                  child:Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                                    child:Icon(
                                                        size: 16,
                                                        Icons.add),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              10.height
                            ],
                          );
                        }),
                ),
                CustomText(
                  text: 'Order Info',
                  fontSize: AppFontSize.s17,
                  fontWeight: AppFontWeight.w500,
                ),
                Column(
                  spacing: 13,
                  children:[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Subtotal',
                            fontSize: AppFontSize.s15,
                            fontWeight: AppFontWeight.w400,
                            color: AppColors.greyText,
                          ),
                          CustomText(
                            text: 'AED 765',
                            fontSize: AppFontSize.s15,
                            fontWeight: AppFontWeight.w500,
                          ),
                        ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Shipping cost',
                            fontSize: AppFontSize.s15,
                            fontWeight: AppFontWeight.w400,
                            color: AppColors.greyText,

                          ),
                          CustomText(
                            text: 'AED 100',
                            fontSize: AppFontSize.s15,
                            fontWeight: AppFontWeight.w500,
                          ),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Total',
                            fontSize: AppFontSize.s15,
                            fontWeight: AppFontWeight.w400,
                            color: AppColors.greyText,

                          ),
                          Flexible(
                            child: CustomText(
                              text: 'AED 838484',
                              fontSize: AppFontSize.s15,
                              fontWeight: AppFontWeight.w500,
                            ),
                          )
                        ]
                    )
                  ],

                ),
              ],
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
              onPressed: ()=>context.pushNamed(RouteName.checkoutScreen,extra: true),
              text: 'Proceed to Checkout'
          ),
        ),
      );
    }
    return Consumer<ProductsController>(
      builder: (context,controller,_) {
        return controller.removeSubmitSuccess? Blur(child: content()):content();
      }
    );
  }
}
