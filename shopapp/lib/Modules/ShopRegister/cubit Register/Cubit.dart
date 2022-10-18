import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Models/Shop_LoginModel.dart';
import 'package:shopapp/Shared/Network/remote/Dio.dart';

import '../../../Shared/Network/EndPoints.dart';
import 'States.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=> BlocProvider.of(context);
  ShopLoginModel? model;

  void userLogin({
  required String email,
    required String password,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(
      lang: 'en',
        url: LOGIN,
        data: {
          'email':email,
          'password' : password,
        },
    ).then((value) {
      print(value.data);
      model=ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(model!));
    }).catchError((error){
      print('erorrrrrrrrrrrrrrrrrrrrrr'+error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(
      lang: 'en',
      url: REGISTER,
      data: {
        'name' : name,
        'email':email,
        'password' : password,
        'phone' : phone,
      },
    ).then((value) {
      print(value.data);
      model=ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(model!));
    }).catchError((error){
      print('erorrrrrrrrrrrrrrrrrrrrrr'+error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }



}