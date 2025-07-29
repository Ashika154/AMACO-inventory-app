import 'package:amaco_app/Apiservice/graphql_service.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:amaco_app/feature/auth/model/user_verification_model.dart';

import '../../feature/auth/model/company_list_model.dart';
import '../graphql_queries.dart';

class AuthRepository {
  final GraphQLService graphQLService;

  AuthRepository({required this.graphQLService});


  Future<UserAuthResponseModel?> registerUser(UserRegisterRequestModel input) async{
    final result = await graphQLService.runMutation(
        mutation: userRegisterMutation,
        variables: {
          "input": input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserRegister"];

    return UserAuthResponseModel.fromJson(data);
  }


  Future<UserAuthResponseModel?> verifyRegisterUser(UserVerificationRequestModel input) async{

    final result = await graphQLService.runMutation(
        mutation: userVerificationRegisterMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserVerifyregister"];

    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> loginUser(UserEmailAndPasswordRequestModel input) async{

    final result = await graphQLService.runMutation(
        mutation: loginMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserLogin"];

    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> resendCode(UserEmailRequestModel input) async{

    final result = await graphQLService.runMutation(
        mutation: resendMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserResendVerifyCode"];

    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> forgotPassword(UserEmailRequestModel input) async{

    final result = await graphQLService.runMutation(
        mutation: forgotPasswordMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserForgotPassword"];

    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> forgotPasswordVerification(UserVerificationRequestModel input) async{

    final result = await graphQLService.runMutation(
        mutation: forgotPasswordEmailVerificationMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserVerifyforgotPassword"];
    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> resetPassword(UserEmailAndNewPasswordRequestModel input) async{

    final result = await graphQLService.runMutation(
        mutation: resetPasswordMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserResetPassword"];

    return UserAuthResponseModel.fromJson(data);
  }

  Future<List<CompanyModel>> fetchCompanyList() async {
    final result = await graphQLService.runQuery(query: fetchCompanyListQuery);
    print('Raw result: ${result?.data}'); // Debug line

    if (result?.data == null) return [];

    final List<dynamic> data = result?.data?['companies']; // lowercase key

    return data.map((e) => CompanyModel.fromJson(e)).toList();
  }


}