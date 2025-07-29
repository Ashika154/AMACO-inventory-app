
import 'package:amaco_app/core/helper/app_log.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final  GraphQLClient client;

  GraphQLService({required this.client});

  Future<QueryResult?> runQuery({
    required String query,
    Map<String,dynamic>? variables,
    void Function(dynamic data)? onCompeted,
    void Function(dynamic error)? onError,
  }) async{
    try{
      final result = await client.query(QueryOptions(
        document: gql(query),
        variables: variables ?? {},
        fetchPolicy: FetchPolicy.networkOnly,
      ));

      if(result.hasException){
        onError?.call(result.exception!);
        return null;
      }

      onCompeted?.call(result.data);
      return result;
    }catch(e){
      AppLog.d("Unexpected GraphQl error :$e");
      return null;
    }
  }

  Future<QueryResult?> runMutation({
    required String mutation,
    Map<String,dynamic>? variables,
    void Function(dynamic data)? onCompleted,
    void Function(dynamic data)? onError
  })async{
    try{
      final result = await client.mutate(MutationOptions(
          document: gql(mutation),
          variables: variables ?? {}
      ));

      if(result.hasException){
        if(onError != null){
          onError(result.exception!);
        }else{
          _handleGraphQLError(result.exception!);
        }
        return null;
      }

      if(onCompleted != null){
        onCompleted(result.data);
      }
      return result;
    }
    catch(e){
      AppLog.d('Unexpected GraphQL error: $e');
      return null;
    }
  }

  void _handleGraphQLError(OperationException error){
    if(error.linkException != null){
      AppLog.d('Network error: ${error.linkException}');
    }
    for(var graphQLError in error.graphqlErrors){
      AppLog.d('GraphQL error: ${graphQLError.message}');
    }
  }
}