import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Network/local/Shared_Preferences/Cache_Helper.dart';
import 'package:shopapp/Shared/cubit/Cubit.dart';


import 'Layout/Shop_Layout/ShopLayout.dart';
import 'Modules/On_Boarding/On_Boarding.dart';
import 'Modules/Shop_Login/ShopLogin.dart';
import 'Shared/Bloc_Observer/Bloc_Observer.dart';
import 'Shared/Components/Constants.dart';
import 'Shared/Network/remote/Dio.dart';
import 'Shared/Styles/Themes/Themes.dart';
import 'Shared/cubit/States.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer= MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isSkipped = CacheHelper.getData(key: 'isSkipped')??false;
  token = CacheHelper.getData(key: 'userToken');
  Widget? widgett;
  if(isSkipped)
    {
      if(token!=null)
        widgett = ShopLayout();
      else widgett = ShopLogin();
    }
  else widgett = On_Boarding();

  runApp(MyApp(
    widget: widgett,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp({
    required this.widget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..changeMode(isdarkFromChache: CacheHelper.getData(key: 'isDark'))..getShopHomeData()..getCategoriesData()..GetFavourite()..getUserData()),
      ],
      child: BlocConsumer< ShopCubit , ShopAppStates >(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit cubit = ShopCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: cubit.isdark ? ThemeMode.dark : ThemeMode.light,

            home: widget,
          );
        },
      )
    );
  }
}
