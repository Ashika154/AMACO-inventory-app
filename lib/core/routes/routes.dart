import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/auth/view/screens/company_list_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/dashboard_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/forgot_password_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/home_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/login_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/register_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/verification_screen.dart';
import 'package:amaco_app/feature/auth/view/screens/welcome_screen.dart';
import 'package:amaco_app/feature/my_orders/view/leave_review_screen.dart';
import 'package:amaco_app/feature/my_orders/view/my_orders_screen.dart';
import 'package:amaco_app/feature/notification/view/notification_screen.dart';
import 'package:amaco_app/feature/payment/view/cancel_order_screen.dart';
import 'package:amaco_app/feature/payment/view/checkout_screen.dart';
import 'package:amaco_app/feature/payment/view/order_details_screen.dart';
import 'package:amaco_app/feature/payment/view/switch_delivery_address_screen.dart';
import 'package:amaco_app/feature/payment/view/switch_payment_method_screen.dart';
import 'package:amaco_app/feature/product/view/my_cart_screen.dart';
import 'package:amaco_app/feature/product/view/product_details_screen.dart';
import 'package:amaco_app/feature/product/view/products_list_screen.dart';
import 'package:amaco_app/feature/profile/view/add_address_screen.dart';
import 'package:amaco_app/feature/profile/view/add_new_card_screen.dart';
import 'package:amaco_app/feature/profile/view/cards_screen.dart';
import 'package:amaco_app/feature/profile/view/profile_data_screen.dart';
import 'package:amaco_app/feature/profile/view/profile_screen.dart';
import 'package:amaco_app/feature/settings/view/change_password_screen.dart';
import 'package:amaco_app/feature/settings/view/change_password_verification_screen.dart';
import 'package:amaco_app/feature/settings/view/delete_account_screen.dart';
import 'package:amaco_app/feature/settings/view/help_and_support_screen.dart';
import 'package:amaco_app/feature/settings/view/privacy_policy_screen.dart';
import 'package:amaco_app/feature/settings/view/settings_screen.dart';
import 'package:amaco_app/feature/settings/view/terms_and_condition_screen.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/view/screens/splash_screen.dart';
import '../../feature/profile/view/address_screen.dart';

final routes = GoRouter(initialLocation: RoutePath.splashScreen, routes: [
  GoRoute(
      path: RoutePath.splashScreen,
      name: RouteName.splashScreen,
      builder: (context, state) => SplashScreen()),
  GoRoute(
      path: RoutePath.welcomeScreen,
      name: RouteName.welcomeScreen,
      builder: (context, state) => WelcomeScreen()),
  GoRoute(
      path: RoutePath.registerScreen,
      name: RouteName.registerScreen,
      builder: (context, state) => RegisterScreen()),
  GoRoute(
      path: RoutePath.verificationScreen,
      name: RouteName.verificationScreen,
      builder: (context, state){
        String email = state.extra.toString();
       return  VerificationScreen(email: email,);
      }),
  GoRoute(
      path: RoutePath.dashboardScreen,
      name: RouteName.dashboardScreen,
      builder: (context, state) => DashboardScreen()),
  GoRoute(
      path: RoutePath.loginScreen,
      name: RouteName.loginScreen,
      builder: (context, state) => LoginScreen()),
  GoRoute(
      path: RoutePath.forgotPasswordScreen,
      name: RouteName.forgotPasswordScreen,
      builder: (context,state) => ForgotPasswordScreen()
  ),
  GoRoute(
      path: RoutePath.changePasswordScreen,
      name: RouteName.changePasswordScreen,
      builder: (context,state) {
        String email = state.extra.toString();
        return ChangePasswordScreen(email: email,);
      }
  ),
  GoRoute(
      path: RoutePath.emailVerificationScreen,
      name: RouteName.emailVerificationScreen,
      builder: (context,state) {
        String email = state.extra.toString();
        return EmailVerificationScreen(email: email,);
      }
  ),
  GoRoute(
      path: RoutePath.homeScreen,
      name: RouteName.homeScreen,
      builder: (context,state) => HomeScreen()
  ),
  GoRoute(
      path: RoutePath.companyListScreen,
      name: RouteName.companyListScreen,
      builder: (context,state) => CompanyListScreen()
  ),
  GoRoute(
      path: RoutePath.productsListScreen,
      name: RouteName.productsListScreen,
      builder: (context,state) => ProductsListScreen()
  ),
  GoRoute(
      path: RoutePath.productDetailsScreen,
      name: RouteName.productDetailsScreen,
      builder: (context,state) => ProductDetailsScreen()
  ),
  GoRoute(
      path: RoutePath.myCartScreen,
      name: RouteName.myCartScreen,
      builder: (context,state) => MyCartScreen()
  ),
  GoRoute(
      path: RoutePath.myOrderScreen,
      name: RouteName.myOrderScreen,
      builder: (context,state) => MyOrdersScreen()
  ),
  GoRoute(
      path: RoutePath.leaveReviewScreen,
      name: RouteName.leaveReviewScreen,
      builder: (context,state) => LeaveReviewScreen()
  ),
  GoRoute(
      path: RoutePath.notificationScreen,
      name: RouteName.notificationScreen,
      builder: (context,state) => NotificationScreen()
  ),
  GoRoute(
      path: RoutePath.profileScreen,
      name: RouteName.profileScreen,
      builder: (context,state) => ProfileScreen()
  ),
  GoRoute(
      path: RoutePath.profileDataScreen,
      name: RouteName.profileDataScreen,
      builder: (context,state) => ProfileDataScreen()
  ),
  GoRoute(
      path: RoutePath.cardsScreen,
      name: RouteName.cardsScreen,
      builder: (context,state) => CardsScreen()
  ),
  GoRoute(
      path: RoutePath.addNewCardsScreen,
      name: RouteName.addNewCardsScreen,
      builder: (context,state) => AddNewCardScreen()
  ),
  GoRoute(
      path: RoutePath.addAddressScreen,
      name: RouteName.addAddressScreen,
      builder: (context,state) => AddAddressScreen()
  ),
  GoRoute(
      path: RoutePath.addressScreen,
      name: RouteName.addressScreen,
      builder: (context,state) => AddressScreen()
  ),
  GoRoute(
      path: RoutePath.settingsScreen,
      name: RouteName.settingsScreen,
      builder: (context,state) => SettingsScreen()
  ),
  GoRoute(
      path: RoutePath.settingsChangePasswordScreen,
      name: RouteName.settingsChangePasswordScreen,
      builder: (context,state) => SettingsChangePasswordScreen()
  ),
  GoRoute(
      path: RoutePath.privacyPolicyScreen,
      name: RouteName.privacyPolicyScreen,
      builder: (context,state) => PrivacyPolicyScreen()
  ),
  GoRoute(
      path: RoutePath.termsAndConditionScreen,
      name: RouteName.termsAndConditionScreen,
      builder: (context,state) => TermsAndConditionScreen()
  ),
  GoRoute(
      path: RoutePath.helpAndSupportScreen,
      name: RouteName.helpAndSupportScreen,
      builder: (context,state) => HelpAndSupportScreen()
  ),
  GoRoute(
      path: RoutePath.deleteAccountScreen,
      name: RouteName.deleteAccountScreen,
      builder: (context,state) => DeleteAccountScreen()
  ),
  GoRoute(
      path: RoutePath.changePasswordVerificationScreen,
      name: RouteName.changePasswordVerificationScreen,
      builder: (context,state) => ChangePasswordVerificationScreen()
  ),
  GoRoute(
      path: RoutePath.checkoutScreen,
      name: RouteName.checkoutScreen,
      builder: (context,state) {
        final showMultiples = state.extra as bool;
       return  CheckoutScreen(showMultipleOrder: showMultiples,);
      }
  ),
  GoRoute(
      path: RoutePath.switchDeliveryAddressScreen,
      name: RouteName.switchDeliveryAddressScreen,
      builder: (context,state) => SwitchDeliveryAddressScreen()
  ),
  GoRoute(
      path: RoutePath.switchPaymentMethodScreen,
      name: RouteName.switchPaymentMethodScreen,
      builder: (context,state) => SwitchPaymentMethodScreen()
  ),
  GoRoute(
      path: RoutePath.orderDetailsScreen,
      name: RouteName.orderDetailsScreen,
      builder: (context,state){
        final showMultiple = state.extra as bool;
        return OrderDetailsScreen(showMultipleDetails: showMultiple,);}
  ),
  GoRoute(
      path: RoutePath.cancelOrderScreen,
      name: RouteName.cancelOrderScreen,
      builder: (context,state) => CancelOrderScreen()
  )
]);
