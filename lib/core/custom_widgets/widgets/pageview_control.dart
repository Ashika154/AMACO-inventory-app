// import 'package:easy_move/feature/auth/view/screens/forget_password_screen.dart';
// import 'package:easy_move/feature/auth/view/screens/registration_screen.dart';
// import 'package:easy_move/feature/auth/view/screens/sign_in.dart';
// import 'package:flutter/material.dart';
//
//
// class AuthPageView extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final ValueNotifier<int> currentPage = ValueNotifier(0);
//
//   AuthPageView({super.key});
//
//   void switchToPage(int index) {
//     currentPage.value = index;
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder<int>(
//         valueListenable: currentPage,
//         builder: (context, value, _) {
//           return PageView(
//             controller: _pageController,
//             physics: const NeverScrollableScrollPhysics(),
//             children: [
//               SignInPage(onNavigate: switchToPage),
//               ForgotPasswordPage(onNavigate: switchToPage),
//               SignUpPage(onNavigate:switchToPage),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
