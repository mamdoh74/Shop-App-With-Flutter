import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Models/ShopCategoriesModel.dart';
import 'package:shopapp/Models/ShopFavouritesModel.dart';
import 'package:shopapp/Models/Shop_LoginModel.dart';
import 'package:shopapp/Shared/Network/remote/Dio.dart';

import '../../Models/ShopFavouritesScreenModel.dart';
import '../../Models/ShopProductsModel.dart';
import '../../Modules/Shop_Categories/ShopCategoriesScreen.dart';
import '../../Modules/Shop_Products/ShopProductsScreen.dart';
import '../../Modules/Shop_Settings/ShopSettingScreen.dart';
import '../../Modules/Shop_favoirits/ShopFavouritesScreen.dart';
import '../Components/Constants.dart';
import '../Network/EndPoints.dart';
import '../Network/local/Shared_Preferences/Cache_Helper.dart';
import 'States.dart';

class ShopCubit extends Cubit<ShopAppStates>{
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  //bool isdarkCache = CacheHelper.getData(key: 'isDark')??false;
  bool isdark=false;
  Icon? darkIcon ;
  int currentIndex =0;
  List<Widget> Screens=[
    ShopProductsScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];
  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(
  icon: Icon(Icons.home),
  label: 'Products'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Category'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favourites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'),
  ];
  void ChangeScreen(index){
    currentIndex=index;
    emit(ShopChangeScreen());
  }
  void changeMode( {bool? isdarkFromChache}){
    if(isdarkFromChache != null)
      isdark = isdarkFromChache;
    else
      isdark = !isdark;
    darkIcon= isdark ? Icon(Icons.dark_mode) :Icon(Icons.light_mode);
    emit(ShopChangeModeState());
  }

  ProductsModel? products;
  Map<int,bool>? favourits={};
  void getShopHomeData(){
    emit(ShopProductsLoadingState());
    print(token);
    DioHelper.GetData(
      url: HOME,
      Authorization: token,
      lang: 'en',
    ).then((value) {
      products= ProductsModel.fromjson(value.data);
      print(value.data['message']);
      print(products!.data!.banners![0].image.toString());

      products!.data!.products!.forEach((element) {
        favourits!.addAll({
          element.id! : element.in_favorites!
        });
      });
      print(favourits);
      emit(ShopProductsSuccessState());
    }).catchError((error){
      emit(ShopProductsErrorState(error.toString()));
    });
  }

  CategoriesModel? Categorymodel;

  void getCategoriesData(){
    emit(ShopCategoriesLoadingState());
    DioHelper.GetData(
        url: CATEGORIES,
      lang: 'en',
    ).then((value) {
      Categorymodel=CategoriesModel.fromjson(value.data);
      print(Categorymodel!.data!.data![0].name);
      print(Categorymodel!.data!.data!.length);

      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      emit(ShopCategoriesErrorState(error));
    });


  }

  FavouritesModel? model;
  void ChangeFavourite(int productId)
  {
    favourits![productId] = !favourits![productId]!;
    emit(ShopChangeFavouritesColorSuccessState());
    DioHelper.PostData(
        url: FAVOURITES,
        data: {
          'product_id':productId
        },
      Authorization: token,
    ).then((value) {
      model=FavouritesModel.fromjson(value.data);
      if(!model!.status!)
        {
          favourits![productId] = !favourits![productId]!;
        }
      print(model!.message!);
      emit(ShopChangeFavouritesSuccessState(model!));
      GetFavourite();
    }).catchError((error){
      favourits![productId] = !favourits![productId]!;
      emit(ShopChangeFavouritesErrorState(error));
    });
  }

  FavouritesScreenModel? getFavo;
  void GetFavourite()
  {
    emit(ShopGetFavouritesLoadingState());
    DioHelper.GetData(
        url: FAVOURITES,
      Authorization: token,
    ).then((value) {
      print('start');
      getFavo = FavouritesScreenModel.fromjson(value.data);
      print('last');
      print(getFavo!.data!.data[0].prod!.name);
      emit(ShopGetFavouritesSuccessState());
    }).catchError((error) {
      emit(ShopGetFavouritesErrorState(error.toString()));
    });
  }

  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopSettingsLoadingState());
    DioHelper.GetData(
        url: PROFILE,
      Authorization: token
    ).then((value) {
      userModel=ShopLoginModel.fromjson(value.data);
      print('final');
      print(userModel!.data!.name);
      emit(ShopSettingsSuccessState());
    }).catchError((error){
      emit(ShopSettingsErrorState(error.toString()));
    });
  }

  void userUpdate({
    required String name,
    required String email,
    required String phone,
  }){
    emit(ShopUpdateLoadingState());
    DioHelper.PutData(
      lang: 'en',
      url: UPDATE,
      data: {
        'name' : name,
        'email':email,
        'phone' : phone,
      },
      Authorization: token,
    ).then((value) {
      print(value.data);

      emit(ShopUpdateSuccessState(userModel!));
    }).catchError((error){
      print('erorrrrrrrrrrrrrrrrrrrrrr'+error.toString());
      emit(ShopUpdateErrorState(error.toString()));
    });
  }

}