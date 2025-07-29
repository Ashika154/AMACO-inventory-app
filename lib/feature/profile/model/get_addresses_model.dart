class GetAddressModel {
  final String addressType;
  final String address;
  final String state;
  final String city;
  final String country;
  final int pinNumber;
  final String phoneNumber;
  final bool primaryAddress;
  final String userId;
  final String id;

  GetAddressModel({
    required this.addressType,
    required this.address,
    required this.state,
    required this.country,
    required this.city,
    required this.phoneNumber,
    required this.pinNumber,
    required this.primaryAddress,
    required this.id,
    required this.userId
  });

  factory GetAddressModel.fromJson(Map<String,dynamic> json){
    return GetAddressModel(
        addressType: json["addressType"],
        address: json["address"],
        state: json["state"],
        country: json["country"],
        city: json["city"],
        phoneNumber: json["phonenumber"],
        pinNumber: json["pinnumber"],
        primaryAddress: json["primaryAddress"],
        id: json["id"],
        userId: json["userId"]
    );
  }
}