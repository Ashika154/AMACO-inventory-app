import 'package:amaco_app/Apiservice/graphql_queries.dart';
import 'package:amaco_app/Apiservice/graphql_service.dart';
import 'package:amaco_app/feature/product/model/product_list_model.dart';

class ProductRepository {
  final GraphQLService graphQLService;

  ProductRepository({required this.graphQLService});

  Future<List<ProductListModel>?> fetchProductList() async {
    final result = await graphQLService.runQuery(query: fetchProductListQuery);
    if (result?.data == null) return null;
    final List products = result?.data?['products'] ?? [];

    return products.map((item) => ProductListModel.fromJson(item)).toList();
  }
}