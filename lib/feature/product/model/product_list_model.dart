class ProductListModel {
  final String id;
  final String name;
  final String companyId;
  final String description;
  final String categoryId;
  final String subCategoryId;
  final double productCost;
  final String productUnit;
  final double deliveryCost;
  final int minimumQuantity;
  final String productDetails;
  final String productAvailability;
  final int productQuantity;
  final String productImage;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  ProductListModel({
    required this.id,
    required this.name,
    required this.companyId,
    required this.description,
    required this.categoryId,
    required this.subCategoryId,
    required this.productCost,
    required this.productUnit,
    required this.deliveryCost,
    required this.minimumQuantity,
    required this.productDetails,
    required this.productAvailability,
    required this.productQuantity,
    required this.productImage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
      description: json['description'],
      categoryId: json['categoryId'],
      subCategoryId: json['subCategoryId'],
      productCost: (json['productCost'] as num).toDouble(),
      productUnit: json['productUnit'],
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      minimumQuantity: json['minimumQuantity'],
      productDetails: json['productDetails'],
      productAvailability: json['productAvailability'],
      productQuantity: json['productQuantity'],
      productImage: json['productImage'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'companyId': companyId,
    'description': description,
    'categoryId': categoryId,
    'subCategoryId': subCategoryId,
    'productCost': productCost,
    'productUnit': productUnit,
    'deliveryCost': deliveryCost,
    'minimumQuantity': minimumQuantity,
    'productDetails': productDetails,
    'productAvailability': productAvailability,
    'productQuantity': productQuantity,
    'productImage': productImage,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'createdBy': createdBy,
    'updatedBy': updatedBy,
  };
}