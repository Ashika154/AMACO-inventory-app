import 'package:amaco_app/Apiservice/graphql_service.dart';
import 'package:amaco_app/Apiservice/repositories/auth_repository.dart';
import 'package:amaco_app/Apiservice/repositories/profile_repository.dart';
import 'package:amaco_app/core/helper/check_internet_connectivity_controller.dart';
import 'package:amaco_app/feature/my_orders/controller/my_order_controller.dart';
import 'package:amaco_app/feature/payment/controller/checkout_controller.dart';
import 'package:amaco_app/feature/product/controller/products_controller.dart';
import 'package:amaco_app/feature/profile/controller/profile_controller.dart';
import 'package:amaco_app/feature/settings/controller/settings_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../Apiservice/repositories/product_repository.dart';
import '../feature/auth/controller/auth_controller.dart';


List<SingleChildWidget> getAppProviders(client) {
  return [
    ChangeNotifierProvider(create: (_) => CheckInternetConnectivityController()),
    ChangeNotifierProvider(create: (_) => AuthController(AuthRepository(graphQLService: GraphQLService(client:client)))),
    ChangeNotifierProvider(create: (_) => ProductsController(ProductRepository(graphQLService: GraphQLService(client: client)),)),
    ChangeNotifierProvider(create: (_) => MyOrderController()),
    ChangeNotifierProvider(create: (_) => ProfileController(ProfileRepository(graphQLService: GraphQLService(client:client)))),
    ChangeNotifierProvider(create: (_) => SettingsController()),
    ChangeNotifierProvider(create: (_) => CheckoutController()),
  ];
}

