class CompanyModel {
  final String id;
  final String name;
  final String logo;
  final String status;

  CompanyModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.status,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
   // print('Parsing company: ${json['name']}');
    return CompanyModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logo: json['logo']?.toString().trim() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}