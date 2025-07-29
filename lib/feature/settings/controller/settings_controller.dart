import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier{

  bool _onNotification = false;
  bool get onNotification =>_onNotification;

  void clickOnNotification(bool value){
    _onNotification = value;
    notifyListeners();
  }

  bool _passwordChangedSuccess = false;
  bool get passwordChangedSuccess =>_passwordChangedSuccess;

  void showPasswordChangedSuccess(){
    _passwordChangedSuccess = !_passwordChangedSuccess;
    notifyListeners();
  }

  int? _selectedReason;
  int? get selectedReason => _selectedReason ;

  void updateSelectedReason(int value){
    _selectedReason = value;
    notifyListeners();
  }

  bool _clickDeleteSuccess = false;
  bool get clickDeleteSuccess =>_clickDeleteSuccess;

  void showDeleteOption(){
    _clickDeleteSuccess = !_clickDeleteSuccess;
    notifyListeners();
  }
}