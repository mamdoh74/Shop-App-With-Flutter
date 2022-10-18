import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Modules/Shop_Search/cubit/states.dart';
import 'package:shopapp/Shared/Components/Constants.dart';
import 'package:shopapp/Shared/Network/remote/Dio.dart';

import '../../../Models/ShopSearchModel.dart';
import '../../../Shared/Network/EndPoints.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInintialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  ShopSearchModel? model;
  void SearchProducts(String text)
  {
    emit(SearchLoadingState());
    DioHelper.PostData(
        url: SEARCH,
        data: {
          'text':text,
        },
      Authorization: token,
    ).then((value) {
      model=ShopSearchModel.fromjson(value.data);
      print('mamdoh done');
      print(model!.data!.data[0].name);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState(error));
    });
  }

}