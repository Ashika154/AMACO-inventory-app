class ProfileDataModel {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;


  ProfileDataModel({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.profileImage
  });

  factory ProfileDataModel.fromJson(Map<String,dynamic> json){
    return ProfileDataModel(
        id:  json['id'],
        email: json['email'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        dateOfBirth: json['dateOfBirth'],
        gender: json['gender'],
        profileImage: json['profileImage']
    );
  }

  Map<String,dynamic> toJson() => {
     'email':email,
     'name':name,
     'phoneNumber':phoneNumber,
     'dateOfBirth':dateOfBirth,
     'gender':gender,
     'profileImage':profileImage
  };
}