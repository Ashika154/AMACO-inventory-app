class DeliveryPaymentModel {
  final String icon;
  final String method;
  bool isChecked;
  DeliveryPaymentModel({required this.icon,required this.method ,this.isChecked = false});
}