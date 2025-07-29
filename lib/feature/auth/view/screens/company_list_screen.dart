import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_dimensions.dart';
import '../../../../config/app_strings.dart';
import '../../../../core/custom_widgets/custom_search.dart';
import '../../../../core/custom_widgets/custom_text.dart';
import '../../../../core/routes/route_name.dart';
import '../../controller/auth_controller.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  bool _isInitialized = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<AuthController>(context, listen: false).loadCompanylist();
      });
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Choose Company',
                fontFamily: ConstantString.appFontBold,
                fontSize: AppFontSize.s32,
                fontWeight: AppFontWeight.w700,
                color: AppColors.secondaryColor,
              ),
              const SearchButton(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
                itemCount: authController.companies.length,

                itemBuilder: (context, index) {
                  final company = authController.companies[index];
                 // print('${ConstantString.baseImageUrl}${company.logo}');

                  return InkWell(
                    onTap: () => context.pushNamed(RouteName.dashboardScreen),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        border: Border.all(color: AppColors.secondaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child:
                      Image.network(
                        fit: BoxFit.cover,
                        '${ConstantString.baseImageUrl}${company.logo}',
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
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}