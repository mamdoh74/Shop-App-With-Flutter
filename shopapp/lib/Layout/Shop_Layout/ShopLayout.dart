import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Modules/Shop_Login/ShopLogin.dart';
import 'package:shopapp/Shared/Components/Components.dart';
import 'package:shopapp/Shared/Network/local/Shared_Preferences/Cache_Helper.dart';
import 'package:shopapp/Shared/cubit/Cubit.dart';
import 'package:shopapp/Shared/cubit/States.dart';

import '../../Modules/Shop_Search/ShopSearchScreen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context ,state){},
      builder: (context,state){
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: (){
                  CacheHelper.RemoveData(key: 'userToken');
                  navigateToAndReplace(ShopLogin(), context);
                },
              ),
              IconButton(onPressed: (){
                CacheHelper.PutData(key: 'isDark', value: !cubit.isdark);
                cubit.changeMode();
              }, icon: cubit.darkIcon!),
              IconButton(onPressed: (){
                navigateTo(ShopSearchScreen(), context);
              }, icon: Icon(Icons.search_rounded)),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (index){
              cubit.ChangeScreen(index);
            },
            currentIndex: cubit.currentIndex,
          ),

        );
      },
    );
  }
}
