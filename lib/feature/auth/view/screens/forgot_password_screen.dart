import 'package:amaco_app/core/helper/string_validations.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/auth/controller/auth_controller.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:amaco_app/feature/auth/model/user_verification_model.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_dimensions.dart';
import '../../../../config/app_strings.dart';
import '../../../../core/custom_widgets/app_back_button.dart';
import '../../../../core/custom_widgets/app_button.dart';
import '../../../../core/custom_widgets/app_decorations.dart';
import '../../../../core/custom_widgets/custom_text.dart';
import '../../../../core/custom_widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: AppBackButton(),
        elevation: 0,
        shape: Border(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Forgot Password?',
                      fontFamily: ConstantString.appFontBold,
                      fontSize: AppFontSize.s32,
                      fontWeight: AppFontWeight.w700,
                      color: AppColors.secondaryColor,
                    ),
                    18.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Recover you password if you have forgot',
                          fontFamily: ConstantString.appFont,
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        ),
                        CustomText(
                          text: 'the password!',
                          fontFamily: ConstantString.appFont,
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        )
                      ],
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
                          hintText: 'abc@gmail.com',
                          controller: emailController,
                          validator: (value)=>value.checkEmail(),
                          prefixIcon: Icon(
                            size: 18,
                            Icons.alternate_email,
                            color: AppColors.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                AppButton(
                  text: 'Submit',
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      final response = await context.read<AuthController>().forgotPassword(UserEmailRequestModel(email: emailController.text));
                      if(response!.success){
                        showSnackBar(
                            context, response.message
                        );
                        context.pushNamed(RouteName.emailVerificationScreen,extra:emailController.text);                      }
                      else{
                        showSnackBar(context,response.message);
                      }
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen ({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: AppBackButton(),
        elevation: 0,
        shape: Border(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Forgot Password?',
                      fontFamily: ConstantString.appFontBold,
                      fontSize: AppFontSize.s32,
                      fontWeight: AppFontWeight.w700,
                      color: AppColors.secondaryColor,
                    ),
                    18.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'We have sent an email to your email ',
                          fontFamily: ConstantString.appFont,
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        ),
                        CustomText(
                          text: 'account with a verification code',
                          fontFamily: ConstantString.appFont,
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        )
                      ],
                    ),
                    27.height,
                    Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Verification Code',
                          fontWeight: AppFontWeight.w500,
                          fontSize: AppFontSize.s16,
                        ),
                        CustomTextFieldWidget(
                          inputType: TextInputType.number,
                          hintText: '432123',
                          controller:otpController,
                          validator: (value)=>value.checkOtp(),
                        )
                      ],
                    ),
                  ],
                ),
                AppButton(
                  text: 'Submit',
                  onPressed: () async {
                   // context.pushNamed(RouteName.changePasswordScreen);
                    if(formKey.currentState?.validate() ?? false){
                      final response = await context.read<AuthController>().forgotPasswordEmailVerification(UserVerificationRequestModel(email: email,verificationCode: otpController.text));
                      if(response!.success)
                      {
                        showSnackBar(
                            context, response.message
                        );
                        context.pushNamed(RouteName.changePasswordScreen,extra: email);
                      }
                    else{
                      showSnackBar(context,response.message);
                    }
                  }
                    else{
                      showSnackBar(context,"Invalid Form");
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  late  TextEditingController passwordController;
  late  TextEditingController confrimPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confrimPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: false,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                height: 356,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CustomText(
                          text: 'Your password has been changed',
                          fontSize: AppFontSize.s32,
                          fontWeight: AppFontWeight.w700,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      CustomText(
                        text: 'You can now log in with your new credentials.',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      20.height,
                      AppButton(
                        text: 'Back to Login',
                        onPressed: ()=>context.pushNamed(RouteName.loginScreen),
                      )
                    ],
                  ),
                ),
              )
      );
    }

    Widget content(){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: AppBackButton(),
          elevation: 0,
          shape: Border(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Forgot Password?',
                        fontFamily: ConstantString.appFontBold,
                        fontSize: AppFontSize.s32,
                        fontWeight: AppFontWeight.w700,
                        color: AppColors.secondaryColor,
                      ),
                      18.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Set your new password to login into your',
                            fontFamily: ConstantString.appFont,
                            fontSize: AppFontSize.s16,
                            fontWeight: AppFontWeight.w400,
                          ),
                          CustomText(
                            text: 'account!',
                            fontFamily: ConstantString.appFont,
                            fontSize: AppFontSize.s16,
                            fontWeight: AppFontWeight.w400,
                          )
                        ],
                      ),
                      27.height,
                      Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'New Password',
                            fontWeight: AppFontWeight.w500,
                            fontSize: AppFontSize.s16,
                          ),
                          CustomTextFieldWidget(
                            obscureText: true,
                            maxLines: 1,
                            inputType: TextInputType.phone,
                            hintText: 'password',
                            controller: passwordController,
                            validator: (value) => value.checkPassword(),
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
                            controller: confrimPasswordController,
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
                    ],
                  ),
                  AppButton(
                    text: 'Submit',
                    onPressed: () async {
                      if(formKey.currentState!.validate()) {
                        final response = await context.read<AuthController>()
                            .resetPassword(
                            UserEmailAndNewPasswordRequestModel(
                                email: widget.email, newPassword: passwordController.text));
                        if (response!.success) {
                          showBottomSheet();
                          showSnackBar(context, response.message);
                        }
                        else {
                          showSnackBar(context, response.message);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Consumer<AuthController>(
      builder: (context,controller,_) {
        return controller.changePasswordSuccess?
        Blur(
            blur: 2.5,
            blurColor: AppColors.primaryColor,
            child: content()) :content();
      }
    );
  }
}
