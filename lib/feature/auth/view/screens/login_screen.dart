import 'package:amaco_app/core/helper/string_validations.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_dimensions.dart';
import '../../../../config/app_strings.dart';
import '../../../../core/custom_widgets/app_button.dart';
import '../../../../core/custom_widgets/app_decorations.dart';
import '../../../../core/custom_widgets/custom_text.dart';
import '../../../../core/custom_widgets/custom_text_form_field.dart';
import '../../../../core/routes/route_name.dart';
import '../../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final authController = Provider.of<AuthController>(context,listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 75),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 28,
              children: [
                CustomText(
                  text: 'Login',
                  fontFamily: ConstantString.appFontBold,
                  fontSize: AppFontSize.s32,
                  fontWeight: AppFontWeight.w700,
                  color: AppColors.secondaryColor,
                ),
                27.height,
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Email',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    CustomTextFieldWidget(
                      inputType: TextInputType.text,
                      controller: emailController,
                      hintText: 'abc@gmail.com',
                      validator: (value) => value?.checkEmail(),
                      prefixIcon: Icon(
                        size: 18,
                        Icons.alternate_email,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Your Password',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    CustomTextFieldWidget(
                      obscureText: true,
                      maxLines: 1,
                      inputType: TextInputType.text,
                      hintText: 'password',
                      controller: passwordController,
                      validator: (value) => value.checkPassword(),
                      prefixIcon: Icon(
                        size: 18,
                        Icons.lock,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: ()=>context.pushNamed(RouteName.forgotPasswordScreen),
                      child: CustomText(
                        text: 'Forgot Password?',
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondaryColor,
                        color: AppColors.secondaryColor,
                        fontSize: AppFontSize.s12,
                        fontWeight: AppFontWeight.w400,
                      ),
                    )
                  ],
                ),
                AppButton(
                  text: 'Login',
                  onPressed: () async{
                    if(formKey.currentState!.validate()){
                      final response = await authController.loginUser(UserEmailAndPasswordRequestModel(email: emailController.text, password: passwordController.text));
                      if(response!.success){
                        showSnackBar(
                            context, response.message
                        );
                        context.pushNamed(RouteName.homeScreen);
                      }
                      else{
                        showSnackBar(context,response.message);
                      }
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6,
                  children: [
                    CustomText(
                      text: 'Don’t have an account?',
                      fontWeight: AppFontWeight.w400,
                      fontSize: AppFontSize.s16,
                    ),
                    GestureDetector(
                      onTap: ()=>context.pushNamed(RouteName.registerScreen),
                      child: CustomText(
                        text: 'Register',
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondaryColor,
                        fontWeight: AppFontWeight.w700,
                        fontSize: AppFontSize.s16,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
