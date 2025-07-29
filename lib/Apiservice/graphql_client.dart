
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_strings.dart';

class GraphQLConfig{

  static Future<String> getToken()async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token ?? "";
  }

  static Future<GraphQLClient> getClient() async{
    final token = await getToken();
    final HttpLink httpLink = HttpLink(
        ConstantString.baseUrl,
        defaultHeaders: {
          if(token.isNotEmpty)
            'Authorization':'Bearer $token'
        }
    );

    return GraphQLClient(link: httpLink, cache: GraphQLCache(store: InMemoryStore()));
  }

  static Future<ValueNotifier<GraphQLClient>> initClient() async{
    final client = await getClient();
    return ValueNotifier(client);
  }
}