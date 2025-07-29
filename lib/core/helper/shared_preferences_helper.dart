
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeToken(String token)async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}


Future<bool> isUserLoggedIn() async{
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  if(token == null || token.isEmpty){
    return false;
  }

  return !JwtDecoder.isExpired(token);
}

Future<void> logout() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}
