import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_back_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../../../core/custom_widgets/custom_text.dart';
import '../../../core/routes/route_name.dart';
import '../controller/products_controller.dart';
class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({super.key});

  final Map<String, dynamic> categoriesList = {
    "Block": {
      "items": {
        1: {
          "image": ReImages.categoryBlock,
          "type": "4 Inc Hollow Block",
          "aed": 3.5,
        },
        2: {
          "image": ReImages.categoryBlock,
          "type": "6 Inc Hollow Block",
          "aed": 4.5,
        },
        3: {
          "image": ReImages.categoryBlock,
          "type": "8 Inc Hollow Block",
          "aed": 3.5,
        },
        4: {
          "image": ReImages.categoryBlock,
          "type": "4 Inc Solid Block",
          "aed": 3.5,
        },
        6: {
          "image": ReImages.categoryBlock,
          "type": "6 Inc Solid Block",
          "aed": 3.5,
        }
      },
      "name": "block"
    },
  };

  @override
  Widget build(BuildContext context) {
    final items = categoriesList["Block"]["items"] as Map;
    final itemList = items.entries.toList();

    final productController = context.watch<ProductsController>();
    final dynamicProductList = productController.productList;

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        title: SearchButton(),
        backgroundColor: AppColors.primaryColor,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          mainAxisExtent: 230,
        ),
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          if (index < 2 && index < dynamicProductList.length) {
            final product = dynamicProductList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => context.pushNamed(RouteName.productDetailsScreen),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        fit: BoxFit.cover,
                        '${ConstantString.baseImageUrl}${product.productImage}',
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
                    ),
                  ),
                ),
                10.height,
                CustomText(
                  text: product.name ?? "No Name",
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
                      text: product.productCost.toString() ?? "0",
                      fontSize: AppFontSize.s14,
                      fontWeight: AppFontWeight.w700,
                    ),
                    CustomText(
                      text: "/${product.productUnit ?? ''}",
                      fontSize: AppFontSize.s12,
                      fontWeight: AppFontWeight.w500,
                      color: AppColors.greyText,
                    ),
                  ],
                )
              ],
            );
          }

          final item = itemList[index].value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => context.pushNamed(RouteName.productDetailsScreen),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(item['image']),
                  ),
                ),
              ),
              10.height,
              CustomText(
                text: item['type'],
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
                    text: item['aed'].toString(),
                    fontSize: AppFontSize.s14,
                    fontWeight: AppFontWeight.w700,
                  ),
                  CustomText(
                    text: "/${categoriesList['Block']['name']}",
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.w500,
                    color: AppColors.greyText,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
