

class UserAuthResponseModel {
  final bool success;
  final String message;
  final String? accessToken;
  final String? tokenType;
  final bool? requiresOtp;
  final String? otpEmail;

  UserAuthResponseModel({
    required this.success,
    required this.message,
    this.accessToken,
    this.requiresOtp,
    this.otpEmail,
    this.tokenType,
  });

  factory UserAuthResponseModel.fromJson(Map<String,dynamic> json){
    return UserAuthResponseModel(
        success: json['success'],
        message: json['message'] ?? '',
        accessToken: json['accessToken'],
        requiresOtp: json['requiresOtp'],
        otpEmail: json['otpEmail'],
        tokenType: json['tokenType']
    );
  }
}


class UserRegisterRequestModel{

  final String name;
  final String email;
  final String password;
  final String tradeLicense;

  UserRegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.tradeLicense,
  });

  Map<String,dynamic> toJson() => {
    "name":name,
    "email":email,
    "password":password,
    "tradeLicense":tradeLicense
  };
}

class UserEmailAndPasswordRequestModel{

  final String email;
  final String password;

  UserEmailAndPasswordRequestModel({
    required this.email,
    required this.password,
  });

  Map<String,dynamic> toJson() => {
    "email":email,
    "password":password,
  };
}

class UserEmailRequestModel{

  final String email;

  UserEmailRequestModel({
    required this.email,
  });

  Map<String,dynamic> toJson() => {
    "email":email,
  };
}

class UserEmailAndNewPasswordRequestModel{

  final String email;
  final String newPassword;

  UserEmailAndNewPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  Map<String,dynamic> toJson() => {
    "email":email,
    "newPassword":newPassword,
  };
}

