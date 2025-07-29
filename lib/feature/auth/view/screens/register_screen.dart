import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/app_decorations.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/custom_widgets/custom_text_form_field.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/auth/controller/auth_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amaco_app/core/helper/string_validations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context,listen: false);
    final licenceFileName = context.watch<AuthController>().licenceFileName;
    final loadingStatus = context.watch<AuthController>().registrationLoading;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 75),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                CustomText(
                  text: 'Register',
                  fontFamily: ConstantString.appFontBold,
                  fontSize: AppFontSize.s32,
                  fontWeight: AppFontWeight.w700,
                  color: AppColors.secondaryColor,
                ),
                15.height,
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Name',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    CustomTextFieldWidget(
                        inputType: TextInputType.text,
                        controller: nameController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Name is required";
                          }
                          return null;
                        },
                        hintText: 'Name',
                        prefixIcon: Icon(
                            size: 18,
                            Icons.person_outlined,
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
                      text: 'Email',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    CustomTextFieldWidget(
                      inputType: TextInputType.text,
                      hintText: 'abc@gmail.com',
                      controller: emailController,
                      validator: (value) => value.checkEmail(),
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
                      text: 'Trade Licence',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    InkWell(
                      //hoverColor: AppColors.secondaryColor,
                      onTap: (){
                        authController.pickFiles();
                      },
                      child:licenceFileName != ""?
                      CustomText(
                        text: licenceFileName,
                        color: AppColors.secondaryColor,
                      ) :DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(16),
                        color: AppColors.secondaryColor,
                        dashPattern: [6,3],
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SizedBox(
                          width: 343,
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: AppColors.secondaryColor,
                                size:15 ,
                              ),
                              CustomText(
                                text: 'Upload Trade License',
                                fontSize: AppFontSize.s16,
                                fontWeight: AppFontWeight.w700,
                                color: AppColors.secondaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Password',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    CustomTextFieldWidget(
                      obscureText: true,
                      maxLines: 1,
                      inputType: TextInputType.text,
                      hintText: 'password',
                      controller: passwordController,
                      validator: (value)=>
                         value.checkPassword(),
                      prefixIcon: Icon(
                        size: 18,
                        Icons.lock,
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
                      text: 'Confirm Password',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    CustomTextFieldWidget(
                      obscureText: true,
                      maxLines: 1,
                      inputType: TextInputType.text,
                      hintText: 'confirm password',
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Confirm your password';
                        }else if(value != passwordController.text){
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        size: 18,
                        Icons.lock,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                InkWell(
                  child: AppButton(
                      text: 'Register',
                      isLoading: loadingStatus,
                    onPressed: () async{
                      // context.pushNamed(RouteName.verificationScreen,extra: "ram");
                      if(formKey.currentState!.validate()){
                        final response = await authController.userRegister(nameController.text,emailController.text,passwordController.text);
                        if(response!.success){
                          showSnackBar(
                              context, response.message
                          );
                          context.pushNamed(RouteName.verificationScreen,extra: emailController.text);
                        }
                        else{
                          showSnackBar(context,response.message);
                        }
                      }
                      else {
                        licenceFileName.isEmpty ?showSnackBar(context, "Upload Licence"):null;
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6,
                  children: [
                    CustomText(
                      text: 'Already have an account?',
                      fontWeight: AppFontWeight.w400,
                      fontSize: AppFontSize.s16,
                    ),
                    GestureDetector(
                      onTap: ()=>context.pushNamed(RouteName.loginScreen),
                      child: CustomText(
                        text: 'Login',
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

