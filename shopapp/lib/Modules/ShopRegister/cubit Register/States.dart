import 'package:shopapp/Models/Shop_LoginModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopLoginModel model;
  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}


