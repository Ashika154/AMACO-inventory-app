class AddAddressModel {
   final String addressType;
   final String address;
   final String state;
   final String city;
   final String country;
   final String pinNumber;
   final String phoneNumber;
   final bool primaryAddress;

   AddAddressModel({
    required this.addressType,
    required this.address,
    required this.state,
    required this.country,
    required this.city,
    required this.phoneNumber,
    required this.pinNumber,
    required this.primaryAddress
   });

   Map<String,dynamic> toJson() => {
     "addressType":addressType,
    "address":address,
    "state":state,
    "country":country,
    "city":city,
    "phonenumber":phoneNumber,
    "pinnumber":int.parse(pinNumber),
     "primaryAddress":primaryAddress
   };
}