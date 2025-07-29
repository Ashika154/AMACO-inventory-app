class UserVerificationRequestModel{
  final String email;
  final String verificationCode;

  UserVerificationRequestModel({
    required this.email,
    required this.verificationCode,
  });

  Map<String,dynamic> toJson() =>{
    "email":email,
    "verificationCode":verificationCode,
  };
}