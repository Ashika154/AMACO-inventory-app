import 'package:amaco_app/Apiservice/graphql_client.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/providers.dart';
import 'package:amaco_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async{
  await initHiveForFlutter();
  final ValueNotifier<GraphQLClient> clientNotifier = await GraphQLConfig.initClient();
  final GraphQLClient client = clientNotifier.value;
  runApp(
      GraphQLProvider(
          client: clientNotifier,
          child: MyApp(
            client:client
          )
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.client});

  final GraphQLClient client;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getAppProviders(client),
      child: MaterialApp.router(
        routerConfig: routes,
        title: 'AMACO Inventory App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryColor,
          useMaterial3: true,
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> state){
              return AppColors.primaryWhite;
            }),
            trackColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> state) {
                      if(state.contains(WidgetState.selected)){
                        return AppColors.green24AB38;
                      }
                      return AppColors.greyText;
                }
            ) ,
           trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
               (Set<WidgetState> state) {
                 if(state.contains(WidgetState.selected)){
                   return AppColors.green24AB38;
                 }
                 return AppColors.greyText;
               }
           )
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.secondaryColor,
            titleTextStyle: TextStyle(
              fontFamily: ConstantString.appFont,
              fontWeight: AppFontWeight.w600,
              fontSize: AppFontSize.s16,
              color: AppColors.black000000,
            )
          ),
          tabBarTheme: TabBarTheme(
            data: TabBarThemeData(
              indicatorColor:AppColors.secondaryColor ,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: AppColors.secondaryColor,
                  fontWeight: AppFontWeight.w700,
                  fontSize: AppFontSize.s16,
                  fontFamily: ConstantString.appFont
              ),
              unselectedLabelStyle: TextStyle(
                color: AppColors.secondaryLiteColor,
                  fontWeight: AppFontWeight.w700,
                  fontSize: AppFontSize.s16,
                  fontFamily: ConstantString.appFont
              ),
            ),
          )
        ),
       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

