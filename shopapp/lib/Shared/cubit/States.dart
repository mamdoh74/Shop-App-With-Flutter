import '../../Models/ShopFavouritesModel.dart';
import '../../Models/Shop_LoginModel.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ShopChangeModeState extends ShopAppStates{}

class ShopChangeScreen extends ShopAppStates{}

class ShopProductsLoadingState extends ShopAppStates{}
class ShopProductsSuccessState extends ShopAppStates{}
class ShopProductsErrorState extends ShopAppStates{
  String error;
  ShopProductsErrorState(this.error);
}

class ShopCategoriesLoadingState extends ShopAppStates{}
class ShopCategoriesSuccessState extends ShopAppStates{}
class ShopCategoriesErrorState extends ShopAppStates{
  String error;
  ShopCategoriesErrorState(this.error);
}

class ShopChangeFavouritesSuccessState extends ShopAppStates{
  FavouritesModel model;
  ShopChangeFavouritesSuccessState(this.model);
}
class ShopChangeFavouritesErrorState extends ShopAppStates{
  String error;
  ShopChangeFavouritesErrorState(this.error);
}

class ShopChangeFavouritesColorSuccessState extends ShopAppStates{}

class ShopGetFavouritesLoadingState extends ShopAppStates{}
class ShopGetFavouritesSuccessState extends ShopAppStates{}
class ShopGetFavouritesErrorState extends ShopAppStates{
  String error;
  ShopGetFavouritesErrorState(this.error);
}

class ShopSettingsLoadingState extends ShopAppStates{}
class ShopSettingsSuccessState extends ShopAppStates{}
class ShopSettingsErrorState extends ShopAppStates{
  String error;
  ShopSettingsErrorState(this.error);
}


class ShopUpdateLoadingState extends ShopAppStates{}

class ShopUpdateSuccessState extends ShopAppStates{
  ShopLoginModel model;
  ShopUpdateSuccessState(this.model);
}

class ShopUpdateErrorState extends ShopAppStates{
  final String error;
  ShopUpdateErrorState(this.error);
}