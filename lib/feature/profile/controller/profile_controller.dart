import 'dart:io';

import 'package:amaco_app/Apiservice/graphql_service.dart';
import 'package:amaco_app/Apiservice/repositories/profile_repository.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:amaco_app/feature/profile/model/add_address_model.dart';
import 'package:amaco_app/feature/profile/model/card_model.dart';
import 'package:amaco_app/feature/profile/model/get_addresses_model.dart';
import 'package:amaco_app/feature/profile/model/profile_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../Apiservice/graphql_client.dart';
import '../../../core/helper/date_time_picker_helper.dart';

class ProfileController extends ChangeNotifier{

  Future<String> selectPreferredDate(BuildContext context) async {
    DateTime? pickedDate = await DateTimeHelper.pickDate(context);
    if (pickedDate != null) {
      String formattedDate = DateTimeHelper.formatDate(pickedDate);
      notifyListeners();
      return formattedDate;
    }
    return "";
  }

  File? _image;
  File? get image => _image;

  void setImage(File imageFile){
    _image = imageFile;
    notifyListeners();
  }

  bool _clickSignOutSuccess = true;
  bool get clickSignOutSuccess =>_clickSignOutSuccess;

  void showSignOutSuccess(){
    _clickSignOutSuccess = !_clickSignOutSuccess;
    notifyListeners();
  }

  bool _savePrimaryCard = false;
  bool get savePrimaryCard =>_savePrimaryCard;

  void clickPrimaryCard(bool value){
    _savePrimaryCard = value;
    notifyListeners();
  }

  bool _saveCardSuccess = false;
  bool get saveCardSuccess =>_saveCardSuccess;

  void showSaveCardSuccess(){
    _saveCardSuccess = !_saveCardSuccess;
    notifyListeners();
  }

  bool _removeCardSuccess = false;
  bool get removeCardSuccess =>_removeCardSuccess;

  void showRemoveCardSuccess(){
    _removeCardSuccess = !_removeCardSuccess;
    notifyListeners();
  }

  bool _savePrimaryAddress = false;
  bool get savePrimaryAddress =>_savePrimaryAddress;

  void clickPrimaryAddress(bool value){
    _savePrimaryAddress = value;
    notifyListeners();
  }

  bool _saveAddressSuccess = false;
  bool get saveAddressSuccess =>_saveAddressSuccess;

  void showSaveAddressSuccess(){
    _saveAddressSuccess = !_saveAddressSuccess;
    notifyListeners();
  }

  bool _removeAddressSuccess = false;
  bool get removeAddressSuccess =>_removeAddressSuccess;

  void showRemoveAddressSuccess(){
    _removeAddressSuccess = !_removeAddressSuccess;
    notifyListeners();
  }

  late GraphQLClient client;

  ProfileDataModel? _profileDataModel;
  bool _isLoading = false;

  ProfileDataModel? get profileDataModel => _profileDataModel;
  bool get isLoading => _isLoading;


  Future<void> loadProfileData() async{
    client = await GraphQLConfig.getClient();
    _isLoading = true;
    notifyListeners();

    _profileDataModel = await _profileRepository.fetchProfileData();
    //print(profileDataModel!.name);
    _isLoading = false;
    notifyListeners();
  }


  Future<UserAuthResponseModel?> profileUpdate(ProfileDataModel request) async{
    final response = await _profileRepository.updateProfileData(request);
    if(response != null && response.success){
      loadProfileData();
      notifyListeners();
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return response;
  }

  Future<UserAuthResponseModel?> addAddress(AddAddressModel request) async{
    final response = await _profileRepository.addAddress(request);

    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return response;
  }

  List<GetAddressModel> _getAddressList = [];
  List<GetAddressModel> get getAddressList  => _getAddressList;

  Future<void> fetchUserAddresses() async{
    _getAddressList = await _profileRepository.fetchUserAddress();
    notifyListeners();
  }


  Future<UserAuthResponseModel?> deleteAddress(addressId) async{
    final response = await _profileRepository.deleteAddress(addressId);

    if(response != null && response.success){
      fetchUserAddresses();
      showRemoveAddressSuccess();
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return response;
  }

  Future<UserAuthResponseModel?> addCard(CardModel request) async{
    final response = await _profileRepository.addCard(request);

    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return response;
  }

  Future<UserAuthResponseModel?> deleteCard(cardId) async{
    final response = await _profileRepository.deleteCard(cardId);
    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return response;
  }

  List<CardModel> _fetchUserCardsList = [];
  List<CardModel> get fetchUserCardsList  => _fetchUserCardsList;

  Future<void> fetchUserCards() async{
    _fetchUserCardsList = await _profileRepository.fetchUserCard();
    notifyListeners();
  }


  Future<UserAuthResponseModel?> changePassword(String newPassword,String oldPassword) async{
    final response = await _profileRepository.changePassword(newPassword,oldPassword);
    if(response != null && response.success){
      return response;
    }
    else{
      if (kDebugMode) {
        print(response?.message);
      }
    }
    notifyListeners();
    return response;
  }

  final ProfileRepository _profileRepository;

  ProfileController(this._profileRepository){
    fetchUserAddresses();
    fetchUserCards();
    loadProfileData();
  }

}