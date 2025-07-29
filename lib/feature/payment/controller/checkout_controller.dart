import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/feature/payment/model/delivery_address_model.dart';
import 'package:amaco_app/feature/payment/model/delivery_payment_model.dart';
import 'package:flutter/material.dart';

class CheckoutController extends ChangeNotifier{


 final List<DeliveryAddressModel> _deliverAddress = [
    DeliveryAddressModel(
        title: 'Home',
        subtitle:'123 Al Wasl Road, Villa 67,Al Wasl, Dubai',
    ),
    DeliveryAddressModel(
        title: 'Office',
        subtitle:'Unit 1504, Marina Diamond 5,Al Marsa Street, Dubai'
    )
  ];

  List<DeliveryAddressModel> get deliveryAddress => _deliverAddress;

 int? _selectedAddressIndex;
 int? _previousAddressIndex;

 void toggleCheck(int index){
   _previousAddressIndex = _selectedAddressIndex;

   if(_previousAddressIndex != null){
     _deliverAddress[_previousAddressIndex!].isChecked = false;
   }

   _deliverAddress[index].isChecked = true;
   _selectedAddressIndex = index;
    notifyListeners();
  }


 final List<DeliveryPaymentModel> _deliveryPayment = [
   DeliveryPaymentModel(
     icon: AppImages.googleLogo,
     method:'Google Pay',
   ),
   DeliveryPaymentModel(
       icon: ReImages.testBankIcon1,
       method:'.... .... .... .... 4567'
   ),
   DeliveryPaymentModel(
       icon: ReImages.testBankIcon2,
       method:'.... .... .... .... 7690'
   )
 ];

 List<DeliveryPaymentModel> get deliveryPayment => _deliveryPayment;

 int? _selectedIndex;
 int? _previousIndex;

 void togglePaymentCheck(int index){

   _previousIndex = _selectedIndex;

   if(_previousIndex != null){
     _deliveryPayment[_previousIndex!].isChecked = false;
   }

   _deliveryPayment[index].isChecked = true;
   _selectedIndex = index;
   notifyListeners();
 }

 bool _paymentSuccess = false;
 bool get paymentSuccess => _paymentSuccess;

 void showPaymentSuccess (){
   _paymentSuccess = !_paymentSuccess;
   notifyListeners();
 }

 int? _selectedReason;
 int? get selectedReason => _selectedReason ;

 void updateSelectedReason(int value){
   _selectedReason = value;
   notifyListeners();
 }

 bool _cancelOrderSuccess = false;
 bool get cancelOrderSuccess => _cancelOrderSuccess;

 void showCancelOrderSuccess (){
   _cancelOrderSuccess = !_cancelOrderSuccess;
   notifyListeners();
 }

 bool _addressAddedSuccess = false;
 bool get addressAddedSuccess => _addressAddedSuccess;

 void showAddressAddedSuccess (){
   _addressAddedSuccess = !_addressAddedSuccess;
   notifyListeners();
 }

 bool _paymentMethodAddedSuccess = false;
 bool get paymentMethodAddedSuccess => _paymentMethodAddedSuccess;

 void showPaymentMethodAddedSuccess (){
   _paymentMethodAddedSuccess = !_paymentMethodAddedSuccess;
   notifyListeners();
 }
}