import 'dart:convert';
import 'dart:io';

import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_drop_down.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/custom_widgets/custom_text_form_field.dart';
import 'package:amaco_app/core/helper/string_validations.dart';
import 'package:amaco_app/feature/profile/controller/profile_controller.dart';
import 'package:amaco_app/feature/profile/model/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../core/custom_widgets/app_decorations.dart';

class ProfileDataScreen extends StatefulWidget {
    ProfileDataScreen({super.key});

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String gender = "";
  String? selectedImage;
  bool _isInitialized = false;

  File? _image;
  File? get image => _image;

  @override
  Widget build(BuildContext context) {

    final profileController = Provider.of<ProfileController>(context);

    if(profileController.isLoading) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Profile Data',
          showBackButton: true,
        ),
        body: Center(
          child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: AppColors.secondaryColor,
              )),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile Data',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Consumer<ProfileController>(
              builder: (context,profileController,_) {
                final profileData = profileController.profileDataModel;
                if(!_isInitialized && profileData != null){
                  nameController.text =  profileData.name;
                  emailController.text = profileData.email;
                  phoneController.text = profileData.phoneNumber ?? "";
                  dobController.text = profileData.dateOfBirth ?? "";
                  gender = profileData.gender ?? "";
                 _isInitialized = true;
                }
                return Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          if(_image != null )...[
                      Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.secondaryColor,
                            width: 5
                        ),
                        shape: BoxShape.circle,
                      ),
                      child:ClipOval(
                        child: Image.file(
                          fit: BoxFit.cover,
                          _image!,
                          errorBuilder: (context,error,stackTrace){
                            return Icon(
                              Icons.error,
                              color: AppColors.secondaryColor,
                            );
                          },
                        ),
                      ) ,
                    ),
                  ]
                          else
                            if(profileData!.profileImage != null)...[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 5
                                ),
                                shape: BoxShape.circle,
                              ),
                              child:ClipOval(
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  '${ConstantString.baseImageUrl}${profileData.profileImage}',
                                  errorBuilder: (context,error,stackTrace){
                                    return Icon(
                                      Icons.error,
                                      color: AppColors.secondaryColor,
                                    );
                                  },
                                  loadingBuilder: (context,child,loadingProgress){
                                    if(loadingProgress == null) return child;
                                    return Center(child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),);
                                  },
                                ),
                              ) ,
                            ),
                          ]
                          else...[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 5,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child:ClipOval(
                                    child: Icon(
                                      size: 100,
                                      Icons.account_circle,
                                      color: AppColors.secondaryColor,
                                    )
                                ) ,
                              ),
                            ],
                          Positioned(
                            top: 100,
                            left: 100,
                            child: InkWell(
                              hoverColor: AppColors.secondaryColor,
                              onTap: ()async{
                                final profileImage = (await _pickImage(context))!;
                                setState(() {
                                  selectedImage = profileImage;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.secondaryColor,
                                child: Icon(
                                  Icons.flip_camera_ios_sharp ,
                                  color: AppColors.primaryWhite,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    30.height,
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 15,
                        children: [
                          Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Name'.makeLabel(),
                              CustomTextFieldWidget(
                                  controller: nameController,
                                  inputType: TextInputType.text,
                                  validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Name is required";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Email'.makeLabel(),
                              CustomTextFieldWidget(
                                controller: emailController,
                                  inputType: TextInputType.text,
                                validator: (value) => value.checkEmail(),
                              ),
                            ],
                          ),
                          Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Phone'.makeLabel(),
                              CustomTextFieldWidget(
                                controller: phoneController,
                                  inputType: TextInputType.number,
                              ),
                            ],
                          ),
                          Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Date of Birth'.makeLabel(),
                              CustomTextFieldWidget(
                                  controller: dobController,
                                  onTap: ()async{
                                    String dob = await profileController.selectPreferredDate(context);
                                    setState(() {
                                      dobController.text = dob;
                                    });
                                  },
                                  inputType: TextInputType.none,
                                  readOnly: true,
                                suffixIcon: Icon(Icons.calendar_today_outlined),
                              ),
                            ],
                          ),
                          Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Gender'.makeLabel(),
                                DropdownWithSearch(
                                    initialValue:gender ,
                                    items: ['Male','Female'],
                                    onChanged: (value){
                                      setState(() {
                                        gender = value!;
                                      });
                                    },
                                )
                            ],
                          ),
                          20.height,
                          AppButton(
                              fontSize: AppFontSize.s16,
                              text: 'Save',
                              onPressed: ()async{
                                if(formKey.currentState!.validate()) {
                                  final response  = await profileController.profileUpdate(
                                      ProfileDataModel(
                                          id: profileData!.id,
                                          email: emailController.text,
                                          name:nameController.text,
                                          phoneNumber: phoneController.text,
                                          dateOfBirth:dobController.text,
                                          gender: gender,
                                          profileImage: selectedImage
                                      )
                                  );

                                  if(response!.success){
                                    if(response.success){
                                      showSnackBar(
                                          context, response.message
                                      );
                                    }
                                    else{
                                      showSnackBar(context,response.message);
                                    }
                                  }
                                }
                              },
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            ),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<String?> _pickImage(BuildContext context)async{
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      //Provider.of<ProfileController>(listen: false,context).setImage(File(pickedFile.path));
      final fileBytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(fileBytes);
      final mimeType = lookupMimeType(pickedFile.path) ?? 'application/png';
      final base64WithHeader = 'data:$mimeType;base64,$base64String';

      setState(() {
        _image = File(pickedFile.path);
      });

      return base64WithHeader;
    }
    return "";
  }
}

extension on String{
  Widget makeLabel(){
    return CustomText(
      text: this,
      fontSize: AppFontSize.s16,
      fontWeight: AppFontWeight.w400,
    );
  }
}