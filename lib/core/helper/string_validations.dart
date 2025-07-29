extension PasswordValidator on String? {
  String? checkPassword(){
    if(this == null || this!.isEmpty){
      return 'Password is required';
    }else if(this!.length <6){
      return "Password must be at least 6 characters";
    }
    return null;
  }
}

extension EmailValidator on String? {
  String? checkEmail(){
    if(this == null || this!.isEmpty){
      return 'Email is required';
    }else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!)){
      return 'Enter a valid email';
    }
    return null;
  }
}

extension OtpValidator on String? {
  String? checkOtp(){
    if(this == null || this!.isEmpty){
      return 'OTP is required';
    }
    else if(this!.length != 6){
      return 'Enter exactly 6 digits';
    }
    else if(!RegExp(r'^\d{6}$').hasMatch(this!)){
      return 'Only numeric digits allowed';
    }
    return null;
  }
}