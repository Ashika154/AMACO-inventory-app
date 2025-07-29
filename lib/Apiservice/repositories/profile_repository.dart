
import 'package:amaco_app/Apiservice/graphql_queries.dart';
import 'package:amaco_app/Apiservice/graphql_service.dart';
import 'package:amaco_app/core/custom_widgets/app_decorations.dart';
import 'package:amaco_app/feature/auth/model/user_register_model.dart';
import 'package:amaco_app/feature/profile/model/add_address_model.dart';
import 'package:amaco_app/feature/profile/model/card_model.dart';
import 'package:amaco_app/feature/profile/model/profile_data_model.dart';

import '../../feature/profile/model/get_addresses_model.dart';

class ProfileRepository {
  final GraphQLService graphQLService;

  ProfileRepository({required this.graphQLService});

  Future<ProfileDataModel?>  fetchProfileData() async{
    final result = await graphQLService.runQuery(query: fetchProfileDataQuery);
    if(result?.data == null) return null;
    final data = result?.data?['AppUsergetpersonaldata'];

    return ProfileDataModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> updateProfileData(ProfileDataModel input) async{
    final result = await graphQLService.runMutation(
        mutation: profileDataUpdateMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserUpdatePersonalData"];
    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> addAddress(AddAddressModel input) async{
    final result = await graphQLService.runMutation(
        mutation: addAddressMutation,
        variables: {
          "input":input.toJson()
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserAddaddress"];
    return UserAuthResponseModel.fromJson(data);
  }

  Future<List<GetAddressModel>>  fetchUserAddress() async{
    final result = await graphQLService.runQuery(query: getUserAddressesQuery);
    if(result?.data == null) return [];
    final List data = result?.data?['AppUserGetalladdress'] ?? [];
    return data.map((json)=>GetAddressModel.fromJson(json as Map<String,dynamic>)).toList();
  }

  Future<UserAuthResponseModel?> deleteAddress(addressId) async{
    final result = await graphQLService.runMutation(
        mutation: deleteAddressMutation,
        variables: {
          "input":{
            "addressId":addressId
          }
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserDeleteaddress"];
    return UserAuthResponseModel.fromJson(data);
  }


  Future<UserAuthResponseModel?> addCard(CardModel input) async{
      final result = await graphQLService.runMutation(
          mutation: addCardMutation,
          variables: {
            "input":input.toJson()
          }
      );

      if(result?.data == null) return null;

      final data = result!.data!["AppUserAddCard"];
      return UserAuthResponseModel.fromJson(data);
  }

  Future<List<CardModel>>  fetchUserCard() async{
    final result = await graphQLService.runQuery(query: fetchCardsQuery);
    if(result?.data == null) return [];
    final List data = result?.data?['AppUsergetallcards'] ?? [];
    return data.map((json)=>CardModel.fromJson(json as Map<String,dynamic>)).toList();
  }


  Future<UserAuthResponseModel?> deleteCard(String cardId) async{
    final result = await graphQLService.runMutation(
        mutation: removeCardMutation,
        variables: {
          "input":{
            "cardId":cardId
          }
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserDeleteCard"];
    return UserAuthResponseModel.fromJson(data);
  }

  Future<UserAuthResponseModel?> changePassword(String changePassword,String newPassword) async{
    final result = await graphQLService.runMutation(
        mutation: changePasswordMutation,
        variables: {
          "input":{
            "changePassword":changePassword,
            "newPassword":newPassword
          }
        }
    );

    if(result?.data == null) return null;

    final data = result!.data!["AppUserChangePassword"];
    return UserAuthResponseModel.fromJson(data);
  }

}