import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/helper/check_internet_connectivity_controller.dart';
import 'package:amaco_app/feature/auth/view/screens/company_list_screen.dart';
import 'package:amaco_app/feature/my_orders/view/my_orders_screen.dart';
import 'package:amaco_app/feature/product/view/my_cart_screen.dart';
import 'package:amaco_app/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 2;

   final List<Widget> _pages = <Widget>[
    DashboardScreen(),
    MyOrdersScreen(),
     CompanyListScreen(),
     MyCartScreen(),
     ProfileScreen()
  ];

   void _onItemTapped(int index){
     setState(() {
       _selectedIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    final networkController = Provider.of<CheckInternetConnectivityController>(context);

    return networkController.hasInternet ?
      Scaffold(
      body:_pages[_selectedIndex],
      bottomNavigationBar:  ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
            backgroundColor: AppColors.primaryWhite,
            unselectedItemColor: AppColors.secondaryLiteColor,
            selectedItemColor: AppColors.secondaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items:<BottomNavigationBarItem> [
              BottomNavigationBarItem(
                  backgroundColor: AppColors.primaryWhite,
                  icon:SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_selectedIndex == 0?AppColors.secondaryColor :AppColors.secondaryLiteColor, BlendMode.srcIn),
                      AppIcons.bottomNavHome
                  ),
                  label:'Home'
              ),
              BottomNavigationBarItem(
                  backgroundColor: AppColors.primaryWhite,
                  icon:SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_selectedIndex == 1?AppColors.secondaryColor :AppColors.secondaryLiteColor, BlendMode.srcIn),
                      AppIcons.bottomNavMyOrder),
                  label:'My Order'
              ),
              BottomNavigationBarItem(
                  backgroundColor: AppColors.primaryWhite,
                  icon:SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_selectedIndex == 2?AppColors.secondaryColor :AppColors.secondaryLiteColor, BlendMode.srcIn),
                      AppIcons.bottomNavCompany),
                  label:'Company'
              ),
              BottomNavigationBarItem(
                  backgroundColor: AppColors.primaryWhite,
                  icon:SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_selectedIndex == 3?AppColors.secondaryColor :AppColors.secondaryLiteColor, BlendMode.srcIn),
                      AppIcons.bottomNavCart),
                  label:'Cart'
              ),
              BottomNavigationBarItem(
                  backgroundColor: AppColors.primaryWhite,
                  icon:SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_selectedIndex == 4?AppColors.secondaryColor :AppColors.secondaryLiteColor, BlendMode.srcIn),
                      AppIcons.bottomNavProfile),
                  label:'Profile'
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
        ),
      )
    ) :Scaffold(
        body: Center(
          child: CustomText(
            text: "No Internet",
          ),
        ),
    );
  }
}
