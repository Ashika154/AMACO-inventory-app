import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      selectedIndex = 3;
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.primaryWhite
          )
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
      ),
      child: BottomNavigationBar(
          backgroundColor: AppColors.primaryWhite,
          unselectedItemColor: AppColors.secondaryLiteColor,
          selectedItemColor: AppColors.secondaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: (int index){
            setState(() {
              selectedIndex = index;
              print(selectedIndex);
            });
          },
          items:<BottomNavigationBarItem> [
        BottomNavigationBarItem(
            backgroundColor: AppColors.primaryWhite,
            icon:SvgPicture.asset(AppIcons.bottomNavHome),
            label:'Home'
        ),
        BottomNavigationBarItem(
            backgroundColor: AppColors.primaryWhite,
            icon:SvgPicture.asset(AppIcons.bottomNavMyOrder),
            label:'My Order'
        ),
        BottomNavigationBarItem(
            backgroundColor: AppColors.primaryWhite,
            icon:SvgPicture.asset(AppIcons.bottomNavCompany),
            label:'Company'
        ),
            BottomNavigationBarItem(
                backgroundColor: AppColors.primaryWhite,
                icon:SvgPicture.asset(AppIcons.bottomNavCart),
            label:'Cart'
        ),
        BottomNavigationBarItem(
            backgroundColor: AppColors.primaryWhite,
            icon:SvgPicture.asset(AppIcons.bottomNavProfile),
            label:'Profile'
        ),
      ]
      ),
    );
  }
}
