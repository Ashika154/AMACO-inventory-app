import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_back_button.dart';
import 'package:amaco_app/core/helper/string_validations.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/auth/controller/auth_controller.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:amaco_app/feature/auth/model/user_verification_model.dart';
import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../config/app_strings.dart';
import '../../../../core/custom_widgets/app_button.dart';
import '../../../../core/custom_widgets/app_decorations.dart';
import '../../../../core/custom_widgets/custom_text.dart';
import '../../../../core/custom_widgets/custom_text_form_field.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late  TextEditingController otpController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authController = Provider.of<AuthController>(context,listen: false);
    void showBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: false,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                height: 310,
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
                      CustomText(
                        text: 'You\'re all set!',
                        fontSize: AppFontSize.s32,
                        fontWeight: AppFontWeight.w700,
                        color: AppColors.secondaryColor,
                      ),
                      CustomText(
                        text: 'Your account has been successfully verified.',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      20.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppButton(
                            text: 'Start Exploring',
                            onPressed: ()=>context.pushNamed(RouteName.homeScreen),
                        ),
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
        ),
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
                    text: 'Verification',
                    fontFamily: ConstantString.appFontBold,
                    fontSize: AppFontSize.s32,
                    fontWeight: AppFontWeight.w700,
                    color: AppColors.secondaryColor,
                  ),
                  RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'We have sent an email to your email account with a verification code!'
                                ,style: TextStyle(
                              color: AppColors.black000000,
                              fontFamily: ConstantString.appFont,
                              fontSize: AppFontSize.s16,
                              fontWeight: AppFontWeight.w400,
                            )
                            )
                          ]
                      )),
                  15.height,
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
                  Padding(
                    padding:  EdgeInsets.only(right: size.width<390?10 :30),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          authController.resendVerificationCode(UserEmailRequestModel(email: widget.email));
                        },
                        child: CustomText(
                          text: 'Resend code',
                          fontWeight: AppFontWeight.w400,
                          fontSize: AppFontSize.s12,
                          color: AppColors.secondaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  AppButton(
                    text: 'Confirm',
                    onPressed: ()async{
                      if(formKey.currentState!.validate()){
                        UserVerificationRequestModel request = UserVerificationRequestModel(
                            email: widget.email,
                            verificationCode: otpController.text
                        );
                        final response = await authController.verifyRegisterUser(request);
                        if(response!.success){
                          showSnackBar(
                            context, response.message
                          );
                          authController.showVerificationSuccess();showBottomSheet();
                        }
                        else{
                          showSnackBar(context,response.message);
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
        return controller.verificationSuccess?
        Blur(
          blur: 2.5,
          blurColor: AppColors.primaryColor,
          child:content()
        )
        :content();
      }
    );
  }
}
