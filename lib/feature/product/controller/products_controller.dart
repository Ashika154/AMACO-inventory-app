import 'package:flutter/material.dart';
import '../../../Apiservice/repositories/product_repository.dart';
import '../model/product_list_model.dart';

class ProductsController extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductsController(this.productRepository) {
    loadProductList();
  }

  List<ProductListModel> _productList = [];
  List<ProductListModel> get productList => _productList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadProductList() async {
    _isLoading = true;
    notifyListeners();

    _productList = await productRepository.fetchProductList() ?? [];

    print("Fetched ${productList.length} products.");
    for (var product in productList) {
      print(" ${product.name} ");
    }
    notifyListeners();
  }

  int _rating = 0;
  int get rating => _rating;

  int _previousRating = 0;
  int get previousRating => _previousRating;

  void setRating(int index) {
    _rating = index + 1;
    _previousRating = _rating;
    notifyListeners();
  }

  void changeRating(int index) {
    int res = 5 - (_previousRating - index) + 1;
    _rating = res;
    notifyListeners();
  }

  int _productCount = 20;
  int get productCount => _productCount;
  int tempCount = 20;

  bool _disableDec = false;
  bool get disableDec => _disableDec;

  void incCount() {
    _productCount += 1;
    _disableDec = true;
    notifyListeners();
  }

  void decCount() {
    if (_productCount > tempCount) {
      _productCount -= 1;
      _disableDec = true;
    } else {
      _disableDec = false;
    }
    notifyListeners();
  }

  bool _showBottomSheetSuccess = false;
  bool get showBottomSheetSuccess => _showBottomSheetSuccess;

  void showBottomSheet() {
    _showBottomSheetSuccess = !_showBottomSheetSuccess;
    notifyListeners();
  }

  bool _showSecondBottomSheetSuccess = false;
  bool get showSecondBottomSheetSuccess => _showSecondBottomSheetSuccess;

  void showSecondBottomSheet() {
    _showSecondBottomSheetSuccess = !_showSecondBottomSheetSuccess;
    notifyListeners();
  }

  bool _removeSubmitSuccess = false;
  bool get removeSubmitSuccess => _removeSubmitSuccess;

  void showRemoveSubmitSuccess() {
    _removeSubmitSuccess = !_removeSubmitSuccess;
    notifyListeners();
  }
}