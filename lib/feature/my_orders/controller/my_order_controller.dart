import 'package:flutter/cupertino.dart';

class MyOrderController extends ChangeNotifier{
  bool _reviewSubmitSuccess = false;
  bool get reviewSubmitSuccess =>_reviewSubmitSuccess;

  void showReviewSubmitSuccess(){
    _reviewSubmitSuccess = !_reviewSubmitSuccess;
    notifyListeners();
  }

  int _rating = 0;
  int get rating => _rating;

  int _previousRating = 0;
  int get previousRating => _previousRating;

  void setRating(int index){
    _rating = index+1;
    _previousRating = _rating;
    notifyListeners();
  }

  void changeRating(int index){
    int res = 5-(_previousRating - index)+1;
    _rating = res;
    notifyListeners();
  }

}