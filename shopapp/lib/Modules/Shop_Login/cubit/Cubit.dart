import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Models/Shop_LoginModel.dart';
import 'package:shopapp/Shared/Network/remote/Dio.dart';

import '../../../Shared/Network/EndPoints.dart';
import 'States.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);
  ShopLoginModel? model;

  void userLogin({
  required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
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
      emit(ShopLoginSuccessState(model!));
    }).catchError((error){
      print('erorrrrrrrrrrrrrrrrrrrrrr'+error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}