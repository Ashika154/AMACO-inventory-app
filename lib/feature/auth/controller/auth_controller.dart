import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:amaco_app/Apiservice/graphql_client.dart';

import 'package:amaco_app/Apiservice/repositories/auth_repository.dart';
import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/core/helper/shared_preferences_helper.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:amaco_app/feature/auth/model/user_verification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mime/mime.dart';
import '../../../Apiservice/graphql_queries.dart';
import '../../../Apiservice/graphql_service.dart';

import '../model/company_list_model.dart';

class AuthController extends ChangeNotifier {
  bool _verificationSuccess = false;
  bool get verificationSuccess => _verificationSuccess;

  void showVerificationSuccess() {
    _verificationSuccess = !_verificationSuccess;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void updateCarouselIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _changePasswordSuccess = false;
  bool get changePasswordSuccess => _changePasswordSuccess;

  void showChangePasswordSuccess() {
    _changePasswordSuccess = !_changePasswordSuccess;
    notifyListeners();
  }

  String _licenceFileName = "";
  String? _filePath;
  String get licenceFileName => _licenceFileName;

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      final file = result.files.single;
      _filePath = file.path!;
      _licenceFileName = file.name;
      notifyListeners();
    }
  }

  Future<UserRegisterRequestModel> buildRegisterRequest(name, email, password) async {
    if (_filePath == null) throw Exception("File Not Selected");
    final fileBytes = await File(_filePath!).readAsBytes();
    final base64String = base64Encode(fileBytes);
    final mimeType = lookupMimeType(_filePath!) ?? 'application/pdf';

    final base64WithHeader = 'data:$mimeType;base64,$base64String';

    return UserRegisterRequestModel(
      name: name,
      email: email,
      password: password,
      tradeLicense: base64WithHeader,
    );
  }


  List<CompanyModel> _companyModel = [];
  List<CompanyModel> get companies => _companyModel;

  final AuthRepository authRepository;

  bool _registrationLoading = false;
  bool get registrationLoading => _registrationLoading;

  AuthController(this.authRepository){
    loadCompanylist();
  }

  Future<void> loadCompanylist() async {
    notifyListeners();
    _companyModel = await authRepository.fetchCompanyList();
   // print('Companies fetched: ${companies.length}');
   //  for (var company in companies) {
   //    print(company.name);
   //  }
    notifyListeners();
  }


  Future<UserAuthResponseModel?> userRegister(name,email,password)async {
    _registrationLoading = true;
    notifyListeners();

    final request = await buildRegisterRequest(name, email, password);
    final response = await authRepository.registerUser(request);

    _registrationLoading = false;
    notifyListeners();

    if (response != null && response.success) {
      return response;
    } else {
      if (kDebugMode) {
        print(response?.message);
      }
      return null;
    }
  }

  bool _verifyRegisterUserLoading = false;
  bool get verifyRegisterUserLoading => _verifyRegisterUserLoading;

  Future<UserAuthResponseModel?> verifyRegisterUser(UserVerificationRequestModel verificationRequest)async{
    _verifyRegisterUserLoading = true;
    final UserVerificationRequestModel request = UserVerificationRequestModel(email:verificationRequest.email, verificationCode:verificationRequest.verificationCode);
    final response = await authRepository.verifyRegisterUser(request);

    if(response != null && response.success){
      _verifyRegisterUserLoading = false;
      storeToken(response.accessToken!);
      return response;
    }
    else{
      if (kDebugMode) {
        _verifyRegisterUserLoading= false;
        print(response?.message);
      }
    }
    notifyListeners();
    return null;
  }

  bool _loginUserLoading = false;
  bool get loginUserLoading => _loginUserLoading;

  Future<UserAuthResponseModel?> loginUser(UserEmailAndPasswordRequestModel loginRequest)async{
    _loginUserLoading = true;
    final UserEmailAndPasswordRequestModel request = UserEmailAndPasswordRequestModel(email: loginRequest.email,password: loginRequest.password);
    final response = await authRepository.loginUser(request);

    if(response != null && response.success){
      _loginUserLoading = false;
      storeToken(response.accessToken!);
      return response;
    }
    else{
      if (kDebugMode) {
        _loginUserLoading= false;
        print(response?.message);
      }
    }
    notifyListeners();
    return null;
  }

  bool _resendVerificationCodeLoading = false;
  bool get resendVerificationCodeLoading => _resendVerificationCodeLoading;

  Future<UserAuthResponseModel?> resendVerificationCode(UserEmailRequestModel resendCodeRequest)async{
    _resendVerificationCodeLoading = true;
    final UserEmailRequestModel request = UserEmailRequestModel(email: resendCodeRequest.email);
    final response = await authRepository.resendCode(request);

    if(response != null && response.success){
      _resendVerificationCodeLoading = false;
      return response;
    }
    else{
      if (kDebugMode) {
        _resendVerificationCodeLoading= false;
        print(response?.message);
      }
    }
    notifyListeners();
    return null;
  }

  Future<UserAuthResponseModel?> forgotPassword(UserEmailRequestModel request) async {
    final response = await authRepository.forgotPassword(request);

    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return null;
  }

  Future<UserAuthResponseModel?> forgotPasswordEmailVerification(UserVerificationRequestModel request) async {


    final response = await authRepository.forgotPasswordVerification(request);

    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return null;
  }

  Future<UserAuthResponseModel?> resetPassword(UserEmailAndNewPasswordRequestModel request) async {
    final response = await authRepository.resetPassword(request);

    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return null;
  }


}

