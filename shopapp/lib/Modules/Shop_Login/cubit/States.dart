import 'package:shopapp/Models/Shop_LoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  ShopLoginModel model;
  ShopLoginSuccessState(this.model);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}
