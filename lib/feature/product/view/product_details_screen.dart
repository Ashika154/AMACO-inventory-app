import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/custom_widgets/app_back_button.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/product/controller/products_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productController = Provider.of<ProductsController>(context);

    void showSecondBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: false,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 244,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Product Added To Cart',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(
                            child: AppButton(
                                onPressed: ()=>Navigator.pop(context),
                                color: AppColors.primaryColor,
                                textColor: AppColors.secondaryColor,
                                border: Border.all(
                                    color: AppColors.secondaryColor
                                ),
                                text: 'Ok'),
                          ),
                          Flexible(
                            child: AppButton(
                                onPressed: ()=>context.pushNamed(RouteName.myCartScreen),
                                text: 'View Cart'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
      );
    }

    void showFirstBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: false,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context){
            return productController.showSecondBottomSheetSuccess?
          Blur(
              blur: 2.5,
              blurColor: AppColors.primaryColor,
              child:Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Minimum Order Quantity:',
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.w400,
                          ),
                          CustomText(
                            text: '20 bags',
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        spacing: 30,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Select Quantity',
                            fontWeight: AppFontWeight.w400,
                            fontSize: AppFontSize.s16,
                          ),
                          Consumer<ProductsController>(
                              builder: (context,controller,_) {
                                return Row(
                                  children: [
                                  controller.disableDec ?IconButton(
                                      onPressed: ()=>controller.decCount(),
                                      icon:Icon(
                                          color:AppColors.black000000 ,
                                          Icons.remove),
                                    ):Icon(
                                      color: AppColors.violetB0A4B4,
                                      Icons.remove
                                  ),
                                    CustomText(
                                      text: '${controller.productCount}',
                                    ),
                                    IconButton(
                                      onPressed: ()=>controller.incCount(),
                                      icon:Icon(Icons.add),
                                    ),
                                  ],
                                );
                              }
                          )
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(
                            child: AppButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  productController.showBottomSheet();
                                  productController.showSecondBottomSheet();
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
                                onPressed: (){showSecondBottomSheet();
                                  productController.showSecondBottomSheet();
                                  },
                                text: 'Add to Cart'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
          ):
              Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Minimum Order Quantity:',
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.w400,
                          ),
                          CustomText(
                            text: '20 bags',
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        spacing: 30,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Select Quantity',
                            fontWeight: AppFontWeight.w400,
                            fontSize: AppFontSize.s16,
                          ),
                          Consumer<ProductsController>(
                            builder: (context,controller,_) {
                              return Row(
                                children: [
                                 controller.disableDec? IconButton(
                                    onPressed: (){controller.decCount();},
                                    icon:Icon(Icons.remove),
                                  ):Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(
                                      color: AppColors.violetB0A4B4,
                                       Icons.remove),
                                  ),
                                  CustomText(
                                    text: '${controller.productCount}',
                                  ),
                                  IconButton(
                                    onPressed: ()=>controller.incCount(),
                                    icon:Icon(Icons.add),
                                  ),
                                ],
                              );
                            }
                          )
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(
                            child: AppButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  productController.showBottomSheet();
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
                                onPressed: ()=>showSecondBottomSheet(),
                                text: 'Add to Cart'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ); }
      );
    }

    Widget content(){
      return Scaffold(
        appBar: AppBar(
          leading: AppBackButton(),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: CustomText(
            text: 'SRC Cement',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width:size.width ,
                      height: 377,
                      child: Image.asset(
                          fit: BoxFit.cover,
                          ReImages.cementProductDetail)),
                  Positioned(
                    left: size.width-50,
                    child: IconButton(onPressed: (){}, icon:Icon(
                      size: 24,
                      Icons.share_outlined,
                      color: AppColors.primaryWhite,
                    )),
                  ),
                ],
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: 14,
                      children: [
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Sulphate Resistant Cement (SRC),',
                                    style: TextStyle(
                                        fontSize: AppFontSize.s16,
                                        fontWeight: AppFontWeight.w500,
                                        color: AppColors.black000000
                                    )
                                ),
                                TextSpan(
                                    text: 'ideal for marine, sewage, and sulphate-rich environments (50kg/bag)',
                                    style: TextStyle(
                                      fontFamily: ConstantString.appFont,
                                      fontSize: AppFontSize.s14,
                                      fontWeight: AppFontWeight.w400,
                                        color: AppColors.black000000
                                    )
                                )
                              ]
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index){
                          return GestureDetector(
                            onTap: (){
                              if(productController.previousRating>index ){
                                productController.changeRating(index);
                              }
                              else{
                                productController.setRating(index);
                              }
                            },
                            child: Icon(
                              (productController.rating > index ) ?Icons.star_purple500_sharp:Icons.star_border_outlined,
                              size: 15,
                              color: AppColors.yellowF5D342,
                            ),
                          );
                        }),
                            ),
                            CustomText(
                              text: '${productController.rating}.0(2 review)',
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'AED 12',
                              fontWeight: AppFontWeight.w700,
                              fontSize: AppFontSize.s20,
                            ),
                            CustomText(
                              text: '/bag',
                              fontWeight: AppFontWeight.w400,
                              fontSize: AppFontSize.s14,
                              color: AppColors.greyText,
                            )
                          ],
                        ),
                        CustomText(
                          text: 'Delivery charge AED 50',
                          fontWeight: AppFontWeight.w500,
                          fontSize: AppFontSize.s10,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'Minimum Order Quantity:',
                          fontSize: AppFontSize.s14,
                          fontWeight: AppFontWeight.w400,
                        ),
                        CustomText(
                          text: '20 bags',
                          fontSize: AppFontSize.s14,
                          fontWeight: AppFontWeight.w500,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        Flexible(
                          child: AppButton(
                              onPressed: (){
                                showFirstBottomSheet(); productController.showBottomSheet();},
                              color: AppColors.primaryColor,
                              textColor: AppColors.secondaryColor,
                              border: Border.all(
                                  color: AppColors.secondaryColor
                              ),
                              text: 'Add to Cart'),
                        ),
                        Flexible(
                          child: AppButton(
                              onPressed: ()=>context.pushNamed(RouteName.checkoutScreen,extra: false),
                              text: 'Buy Now'),
                        ),
                      ],
                    ),
                    CustomText(
                      text: 'Product Details',
                      fontSize: AppFontSize.s16,
                      fontWeight: AppFontWeight.w700,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Category: Cement',
                          fontWeight: AppFontWeight.w400,
                          fontSize: AppFontSize.s14,
                        ),
                        CustomText(
                          text: 'Type: Sulphate Resistant Cement',
                          fontWeight: AppFontWeight.w400,
                          fontSize: AppFontSize.s14,
                        ),                        CustomText(
                          text: 'Quantity: 50kg/bag',
                          fontWeight: AppFontWeight.w400,
                          fontSize: AppFontSize.s14,
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.primaryWhite,
                      thickness: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Ratings & Reviews',
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w700,
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Row(
                              children: List.generate
                                (5, (index)=>Icon(
                                size: 16,
                                  Icons.star_border_outlined,
                                  color: AppColors.yellowF5D342,
                              )
                              ),
                            ),
                            CustomText(
                              text: '2 review',
                              fontSize: AppFontSize.s12,
                              fontWeight: AppFontWeight.w500,
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: AppColors.primaryColor
                                  )
                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                    ReImages.testReviewProfile
                                ),
                              ) ,
                            ),
                            CustomText(
                              text: 'Ahmad Khan',
                              fontSize: AppFontSize.s12,
                              fontWeight: AppFontWeight.w500,
                            )
                          ],
                        ),
                        Row(
                          children: List.generate
                            (5, (index)=>Icon(
                            size: 16,
                            Icons.star_border_outlined,
                            color: AppColors.yellowF5D342,
                          )
                          ),
                        ),
                        CustomText(
                          text: 'Satisfied',
                          fontSize: AppFontSize.s12,
                          fontWeight: AppFontWeight.w400,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: AppColors.primaryColor
                                  )
                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                    ReImages.testReviewProfile2
                                ),
                              ) ,
                            ),
                            CustomText(
                              text: 'Ahmad Khan',
                              fontSize: AppFontSize.s12,
                              fontWeight: AppFontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: List.generate
                            (5, (index)=>Icon(
                            size: 16,
                            Icons.star_border_outlined,
                            color: AppColors.yellowF5D342,
                          )
                          ),
                        ),
                        CustomText(
                          text: 'Good Product. Fast delivery',
                          fontSize: AppFontSize.s12,
                          fontWeight: AppFontWeight.w400,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return productController.showBottomSheetSuccess?Blur(
        blur: 2.5,
        blurColor: AppColors.primaryColor,
        child: content()) :content();

  }
}
